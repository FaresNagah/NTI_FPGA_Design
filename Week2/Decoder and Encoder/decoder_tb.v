module decoder_tb;

    reg [1:0] in;
    reg enable;
    wire [3:0] out;

    decoder dut (
        .in(in),
        .enable(enable),
        .out(out)
    );

    initial begin
        
        enable = 0; in = 2'b00; #10;
        $display("Test case 1: in=%b, enable=%b, out=%b", in, enable, out);
        #10;
       
        enable = 1; in = 2'b00; #10;
        $display("Test case 2: in=%b, enable=%b, out=%b", in, enable, out);
        #10;
        
        enable = 1; in = 2'b01; #10;
        $display("Test case 3: in=%b, enable=%b, out=%b", in, enable, out);
        #10;    
      
        enable = 1; in = 2'b10; #10;
        $display("Test case 4: in=%b, enable=%b, out=%b", in, enable, out);
        #10;    
       
        enable = 1; in = 2'b11; #10;
        $display("Test case 5: in=%b, enable=%b, out=%b", in, enable, out);

        $finish;
    end


endmodule