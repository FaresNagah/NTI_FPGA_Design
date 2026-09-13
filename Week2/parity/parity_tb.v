module tb_stream_parity_gen();

    reg  clk;
    reg  reset;
    reg  serial_in;
    wire parity_out;
    wire valid;

    reg [7:0] test_data;
    integer i;

    
    stream_parity_gen dut (
        .clk(clk),
        .reset(reset),
        .serial_in(serial_in),
        .parity_out(parity_out),
        .valid(valid)
    );

   
    initial clk = 1'b0;
    always #5 clk = ~clk;

    initial begin
      
        reset     = 1'b1;
        serial_in = 1'b0;
        test_data = 8'b0;

        
        #25;
        @(negedge clk);
        reset = 1'b0;

        test_data = 8'b1011_0010;
        for (i = 7; i >= 0; i = i - 1) begin
            @(negedge clk);
            serial_in = test_data[i];
        end

        test_data = 8'b1010_0001;
        for (i = 7; i >= 0; i = i - 1) begin
            @(negedge clk);
            serial_in = test_data[i];
        end

        repeat (5) @(negedge clk);

        $stop;
    end

endmodule