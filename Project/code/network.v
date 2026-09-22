// Structural wrapper wiring Ports 0, 1, 2 to memories and exposing Port 3 to TB
module Network_System_Top (
    input clk, rst_n, Router_Ready, tb_wr_en,
    input [23:0] tb_data_in,
    input tb_port3_ready,
    output wire [23:0] tb_port3_data,
    output tb_port3_valid,
    output tb_fifo3_full,
    output tb_fifo3_empty
);

    wire wr_en0, wr_en1, wr_en2;
    wire [23:0] data_in0, data_in1, data_in2;
    wire [23:0] port0_data, port1_data, port2_data;
    wire port0_valid, port1_valid, port2_valid;
    wire port0_ready, port1_ready, port2_ready;
    wire full0, full1, full2;
    wire empty0, empty1, empty2;

    Router_Top #(.DATA_WIDTH(24)) router_inst (
        .clk(clk),
        .rst_n(rst_n),
        .wr_en0(wr_en0), .wr_en1(wr_en1), .wr_en2(wr_en2), .wr_en3(tb_wr_en),
        .data_in0(data_in0), .data_in1(data_in1), .data_in2(data_in2), .data_in3(tb_data_in),
        .Router_Ready(Router_Ready),
        .port0_ready(port0_ready), .port1_ready(port1_ready), .port2_ready(port2_ready), .port3_ready(tb_port3_ready),
        .port0_data(port0_data), .port1_data(port1_data), .port2_data(port2_data), .port3_data(tb_port3_data),
        .port0_valid(port0_valid), .port1_valid(port1_valid), .port2_valid(port2_valid), .port3_valid(tb_port3_valid),
        .empty0(empty0), .empty1(empty1), .empty2(empty2), .empty3(tb_fifo3_empty),
        .full0(full0),   .full1(full1),   .full2(full2),   .full3(tb_fifo3_full)
    );

    ram_network_node_fixed #(.DATA_WIDTH(24), .ADDR_WIDTH(5), .RAM_DEPTH(32), .RESP_DEST(2'b11)) node0 (
        .clk(clk), .rst_n(rst_n),
        .rx_valid(port0_valid), .rx_data(port0_data), .rx_ready(port0_ready),
        .tx_wr_en(wr_en0), .tx_data(data_in0), .fifo_full(full0)
    );

    ram_network_node_fixed #(.DATA_WIDTH(24), .ADDR_WIDTH(5), .RAM_DEPTH(32), .RESP_DEST(2'b11)) node1 (
        .clk(clk), .rst_n(rst_n),
        .rx_valid(port1_valid), .rx_data(port1_data), .rx_ready(port1_ready),
        .tx_wr_en(wr_en1), .tx_data(data_in1), .fifo_full(full1)
    );

    ram_network_node_fixed #(.DATA_WIDTH(24), .ADDR_WIDTH(5), .RAM_DEPTH(32), .RESP_DEST(2'b11)) node2 (
        .clk(clk), .rst_n(rst_n),
        .rx_valid(port2_valid), .rx_data(port2_data), .rx_ready(port2_ready),
        .tx_wr_en(wr_en2), .tx_data(data_in2), .fifo_full(full2)
    );

endmodule