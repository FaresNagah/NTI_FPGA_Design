module debouncertb;

    localparam CLK_FREQ_HZ    = 50_000_000;
    localparam TICK_PERIOD_NS = 100;
    localparam CLK_PERIOD     = 20; 

   
    reg  clk;
    reg  reset_n;
    reg  sw;
    wire db;

   
    bouncer #(
        .CLK_FREQ_HZ(CLK_FREQ_HZ),
        .TICK_PERIOD_NS(TICK_PERIOD_NS)
    ) dut (
        .clk(clk),
        .rst_n(reset_n),
        .sw(sw),
        .db(db)
    );

    always #(CLK_PERIOD / 2) clk = ~clk;

    initial begin
      
        clk     = 0;
        reset_n = 0;
        sw      = 0;

        #(CLK_PERIOD * 5);
        reset_n = 1;
        #(CLK_PERIOD * 2);


        $display("[Time %0t ns] Injecting press bounces...", $time);
        sw = 1; #40;
        sw = 0; #30;
        sw = 1; #50;
        sw = 0; #40;

  
        $display("[Time %0t ns] Holding stable HIGH...", $time);
        sw = 1;
        #500;

    
        $display("[Time %0t ns] Injecting release bounces...", $time);
        sw = 0; #40;
        sw = 1; #30;
        sw = 0; #50;
        sw = 1; #40;

        $display("[Time %0t ns] Holding stable LOW...", $time);
        sw = 0;
        #500;

        $display("[Time %0t ns] Test completed successfully.", $time);
        $stop;
    end

    initial begin
        $monitor("Time=%4t ns | reset_n=%b | sw=%b | db=%b | state=%b", 
                 $time, reset_n, sw, db, dut.state_reg);
    end

endmodule