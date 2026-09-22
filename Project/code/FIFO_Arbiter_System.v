module FIFO_Arbiter_System #(
    parameter DATA_WIDTH = 40
) (
    input clk, rst_n,
    input wr_en0, wr_en1, wr_en2, wr_en3,
    input [DATA_WIDTH-1:0] data_in0, data_in1, data_in2, data_in3,
    input Router_Ready,
    output empty0, empty1, empty2, empty3,
    output full0, full1, full2, full3,
    output grant0, grant1, grant2, grant3,
    output reg [DATA_WIDTH-1:0] data_out,
    output packet_valid
);

    

    wire r_en0, r_en1, r_en2, r_en3;

    assign r_en0 = grant0 && Router_Ready;
    assign r_en1 = grant1 && Router_Ready;
    assign r_en2 = grant2 && Router_Ready;
    assign r_en3 = grant3 && Router_Ready;


    

    wire [DATA_WIDTH-1:0] data_out0, data_out1, data_out2, data_out3;


    Four_Fifo_Buffers #(
        .DATA_WIDTH(DATA_WIDTH)
    ) FIFO_BUFFERS (
        .clk(clk),
        .rst_n(rst_n),
        .wr_en0(wr_en0),
        .wr_en1(wr_en1),
        .wr_en2(wr_en2),
        .wr_en3(wr_en3),
        .r_en0(r_en0),
        .r_en1(r_en1),
        .r_en2(r_en2),
        .r_en3(r_en3),
        .data_in0(data_in0),
        .data_in1(data_in1),
        .data_in2(data_in2),
        .data_in3(data_in3),
        .empty0(empty0),
        .empty1(empty1),
        .empty2(empty2),
        .empty3(empty3),
        .full0(full0),
        .full1(full1),
        .full2(full2),
        .full3(full3),
        .data_out0(data_out0),
        .data_out1(data_out1),
        .data_out2(data_out2),
        .data_out3(data_out3)
    );



    RR_Arbiter ARBITER (
        .clk(clk),
        .rst_n(rst_n),
        .empty0(empty0),
        .empty1(empty1),
        .empty2(empty2),
        .empty3(empty3),
        .Router_Ready(Router_Ready),
        .grant0(grant0),
        .grant1(grant1),
        .grant2(grant2),
        .grant3(grant3)
    );


   
    reg [3:0] selected_fifo;

    assign packet_valid = |selected_fifo;

    always @(posedge clk) begin
        if (!rst_n) begin
            selected_fifo <= 4'b0000;
        end
        else if (Router_Ready) begin
            selected_fifo <= {grant3, grant2, grant1, grant0};
        end
    end

    always @(*) begin
    case (selected_fifo)

        4'b0001: data_out = data_out0;

        4'b0010: data_out = data_out1;

        4'b0100: data_out = data_out2;

        4'b1000: data_out = data_out3;

        default: data_out = {DATA_WIDTH{1'b0}};

    endcase
end

endmodule