module top_tb;

    reg        clk;
    reg        rst_n;
    reg        in;

    wire [6:0] seg_r,  seg_rc;
    wire [6:0] seg_f,  seg_fc;
    wire [6:0] seg_t,  seg_tc;

    
    top_modul #(
        .clk_in  (10),
        .clk_out (2)
    ) dut (
        .clk     (clk),
        .rst_n   (rst_n),
        .in      (in),
        .seg_r   (seg_r),
        .seg_rc  (seg_rc),
        .seg_f   (seg_f),
        .seg_fc  (seg_fc),
        .seg_t   (seg_t),
        .seg_tc  (seg_tc)
    );

    
    always #10 clk = ~clk;

   initial begin
        clk   = 0;
        rst_n = 0;
        in    = 0;

        // Hold reset for 50 ns, then release
        #50;
        rst_n = 1;
        #100;

        // 1st Rising Edge: hold HIGH long enough for slow_clk to sample
        in = 1;
        #250;

        // 1st Falling Edge: hold LOW
        in = 0;
        #250;

        // 2nd Rising Edge
        in = 1;
        #250;

        // 2nd Falling Edge
        in = 0;
        #250;

        $finish;
    end

endmodule