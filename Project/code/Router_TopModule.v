module Router_Top #(
    parameter DATA_WIDTH = 24
) (
    input clk, rst_n,
    input wr_en0, wr_en1, wr_en2, wr_en3,
    input [DATA_WIDTH-1:0] data_in0, data_in1, data_in2, data_in3,
    input Router_Ready,
    input port0_ready, port1_ready, port2_ready, port3_ready,    
    output [DATA_WIDTH-1:0] port0_data,  port1_data,  port2_data,  port3_data,
    output port0_valid, port1_valid, port2_valid, port3_valid,
    output empty0, empty1, empty2, empty3,
    output full0,  full1,  full2,  full3
);

    wire grant0, grant1, grant2, grant3;
    wire [DATA_WIDTH-1:0] data_out;
    wire packet_valid;

    FIFO_Arbiter_System #(.DATA_WIDTH(DATA_WIDTH)) inst_arb (
        .clk(clk),
        .rst_n(rst_n),
        .wr_en0(wr_en0),
        .wr_en1(wr_en1),
        .wr_en2(wr_en2),
        .wr_en3(wr_en3),
        .data_in0(data_in0),
        .data_in1(data_in1),
        .data_in2(data_in2),
        .data_in3(data_in3),
        .Router_Ready(Router_Ready),
        .empty0(empty0),
        .empty1(empty1),
        .empty2(empty2),
        .empty3(empty3),
        .full0(full0),
        .full1(full1),
        .full2(full2),
        .full3(full3),
        .grant0(grant0),
        .grant1(grant1),
        .grant2(grant2),
        .grant3(grant3),
        .data_out(data_out),
        .packet_valid(packet_valid)
    );

    Packet_Routing #(.DATA_WIDTH(DATA_WIDTH)) inst_rout (
        .clk(clk),
        .rst_n(rst_n),
        .packet_in(data_out),
        .packet_valid(packet_valid),
        .port0_ready(port0_ready),
        .port1_ready(port1_ready),
        .port2_ready(port2_ready),
        .port3_ready(port3_ready),
        .port0_valid(port0_valid),
        .port1_valid(port1_valid),
        .port2_valid(port2_valid),
        .port3_valid(port3_valid),
        .port0_data(port0_data),
        .port1_data(port1_data),
        .port2_data(port2_data),
        .port3_data(port3_data)
    );

endmodule