module parity_exh_tb();

    reg  clk;
    reg  reset;
    reg  serial_in;
    wire parity_out;
    wire valid;
    integer pattern_idx;
    integer error_count;

    stream_parity_gen dut (
        .clk(clk),
        .reset(reset),
        .serial_in(serial_in),
        .parity_out(parity_out),
        .valid(valid)
    );

    initial clk = 1'b0;
    always #5 clk = ~clk;


    task apply_reset;
        begin
            @(negedge clk);
            reset     = 1'b1;
            serial_in = 1'b0;
            repeat (2) @(negedge clk);
            reset     = 1'b0;
        end
    endtask


    task send_and_check;
        input [7:0] byte_data;
        integer b;
        reg expected_parity;
        begin
        
            expected_parity = ^byte_data;

        
            for (b = 7; b >= 0; b = b - 1) begin
                @(negedge clk);
                serial_in = byte_data[b];
            end

    
            @(posedge clk);
            #1;

            if (valid !== 1'b1) begin
                $display("[ERROR] Time %0t | valid expected HIGH for 8'b%b", $time, byte_data);
                error_count = error_count + 1;
            end

            if (parity_out !== expected_parity) begin
                $display("[ERROR] Time %0t | Byte: 8'b%b | Got: %b | Expected: %b", 
                         $time, byte_data, parity_out, expected_parity);
                error_count = error_count + 1;
            end
        end
    endtask
 
    initial begin
        error_count = 0;
        apply_reset;

        $display("--------------------------------------------------");
        $display("Starting Exhaustive Parity Simulation (0 to 255)...");
        $display("--------------------------------------------------");


        for (pattern_idx = 0; pattern_idx < 256; pattern_idx = pattern_idx + 1) begin
        
            apply_reset();
            send_and_check(pattern_idx[7:0]);
        end
        $display("--------------------------------------------------");
        if (error_count == 0) begin
            $display(">> SUCCESS: ALL 256 PATTERNS PASSED EXHAUSTIVE TEST <<");
        end else begin
            $display(">> FAILURE: %0d ERRORS FOUND <<", error_count);
        end
        $display("--------------------------------------------------");

        repeat (5) @(negedge clk);
        $stop;
    end

endmodule