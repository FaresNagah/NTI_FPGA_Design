module encoder_tb;
        reg [3:0] in;
        reg enable;
        wire [1:0] out;


        encoder dut (
        .in(in),
        .enable(enable),
        .out(out)
        );

    initial begin
        enable = 0; in = 4'b0000; #10;
        $display("Test case 1: in=%b, enable=%b, out=%b", in, enable, out);
        #10;
        enable = 1; in = 4'b0001; #10;
        $display("Test case 2: in=%b, enable=%b, out=%b", in, enable, out);
        #10;
    
        enable = 1; in = 4'b0010; #10;
        $display("Test case 3: in=%b, enable=%b, out=%b", in, enable, out);
        #10;
       
        enable = 1; in = 4'b0100; #10;
        $display("Test case 4: in=%b, enable=%b, out=%b", in, enable, out);
        #10;
        enable = 1; in = 4'b1000; #10;
        $display("Test case 5: in=%b, enable=%b, out=%b", in, enable, out);

        $finish;
    end
    

endmodule