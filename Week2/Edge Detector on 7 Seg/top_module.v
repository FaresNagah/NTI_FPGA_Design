module top_modul #(
    parameter clk_in  = 50_000_000,
    parameter clk_out = 8             
)(
    input  wire       clk,
    input  wire       rst_n,               
    input  wire       in,                  
    output wire [6:0] seg_r,
    output wire [6:0] seg_rc,
    output wire [6:0] seg_f,
    output wire [6:0] seg_fc,
    output wire [6:0] seg_t,
    output wire [6:0] seg_tc
);

   
    wire s_clk;
    wire rise_tick;
    wire fall_tick;
    wire edge_tick;

    wire [3:0] rise_count;
    wire [3:0] fall_count;
    wire [3:0] total_count;

    
    clk_divider #(
        .Clk_in_par  (clk_in),
        .Clk_out_par (clk_out)
    ) dut (
        .clk_in  (clk),
        .rst_n   (rst_n),
        .clk_out (s_clk)
    );

    
    edg_detector d_dut (
        .clk       (s_clk),
        .reset_n    (rst_n),
        .in        (in),
        .rise_tick (rise_tick),
        .fall_tick (fall_tick),
        .edge_tick (edge_tick)
    );

    
    edg_counter c_dut (
        .clk         (s_clk),
        .rst_n       (rst_n),
        .rise_tick   (rise_tick),
        .fall_tick   (fall_tick),
        .edge_tick   (edge_tick),
        .rise_count  (rise_count),
        .fall_count  (fall_count),
        .total_count (total_count)
    );

    
    six_digit_decoder m_dut (
        .clk           (s_clk),
        .rst_n         (rst_n),
        .edge_detected (edge_tick),
        .rise_count    (rise_count),
        .fall_count    (fall_count),
        .total_count   (total_count),
        .seg_r         (seg_r),
        .seg_rc        (seg_rc),
        .seg_f         (seg_f),
        .seg_fc        (seg_fc),
        .seg_t         (seg_t),
        .seg_tc        (seg_tc)
    );



endmodule