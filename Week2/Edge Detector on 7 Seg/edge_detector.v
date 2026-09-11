module edg_detector (
    input  wire clk,reset_n,in,
    output wire rise_tick,
    output wire fall_tick,
    output wire edge_tick
);

    
    positive_edge_moore dut (
        .clk   (clk),
        .rst_n (reset_n),
        .trig  (in),
        .pulse (rise_tick)
    );

    falling_edge_moore f_dut (
        .clk   (clk),
        .rst_n (reset_n),
        .trig  (in),
        .pulse (fall_tick)
    );

    assign edge_tick = rise_tick | fall_tick;

endmodule