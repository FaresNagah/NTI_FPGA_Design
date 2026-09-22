module Four_Fifo_Buffers #(
    parameter DATA_WIDTH = 40
) (
    input clk, rst_n, wr_en0 , wr_en1, wr_en2, wr_en3,
    input r_en0, r_en1, r_en2, r_en3,
    input [DATA_WIDTH - 1 : 0] data_in0, data_in1, data_in2, data_in3,
    output empty0, empty1, empty2, empty3,
    output full0, full1, full2, full3,
    output [DATA_WIDTH - 1 : 0] data_out0, data_out1, data_out2, data_out3
);

    sync_fifo #(
        .WIDTH(DATA_WIDTH),
        .DEPTH(16)
    ) FIFO0 (
        .clk(clk),
        .rst_n(rst_n),
        .wr_en(wr_en0),
        .r_en(r_en0),
        .data_in(data_in0),
        .empty(empty0),
        .full(full0),
        .data_out(data_out0)
    );

    sync_fifo #(
        .WIDTH(DATA_WIDTH),
        .DEPTH(16)
    ) FIFO1 (
        .clk(clk),
        .rst_n(rst_n),
        .wr_en(wr_en1),
        .r_en(r_en1),
        .data_in(data_in1),
        .empty(empty1),
        .full(full1),
        .data_out(data_out1)
    );

    sync_fifo #(
        .WIDTH(DATA_WIDTH),
        .DEPTH(16)
    ) FIFO2 (
        .clk(clk),
        .rst_n(rst_n),
        .wr_en(wr_en2),
        .r_en(r_en2),
        .data_in(data_in2),
        .empty(empty2),
        .full(full2),
        .data_out(data_out2)
    );

    sync_fifo #(
        .WIDTH(DATA_WIDTH),
        .DEPTH(16)
    ) FIFO3 (
        .clk(clk),
        .rst_n(rst_n),
        .wr_en(wr_en3),
        .r_en(r_en3),
        .data_in(data_in3),
        .empty(empty3),
        .full(full3),
        .data_out(data_out3)
    );
    
endmodule