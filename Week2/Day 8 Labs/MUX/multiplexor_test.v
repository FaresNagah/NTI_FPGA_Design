module multiplexor_test;
    localparam WIDTH = 5;
    reg sel;
    reg [WIDTH-1:0] in0;
    reg [WIDTH-1:0] in1;
    wire [WIDTH-1:0] mux_out;

    multiplexor #(.WIDTH(WIDTH)) dut (
        .sel(sel),
        .in0(in0),
        .in1(in1),
        .mux_out(mux_out)
    );

    initial begin
        in0 = 5'h15;
        in1 = 5'h0A;

        sel = 1'b0;
        #10;
        if (mux_out !== in0) begin
            $display("TEST FAILED: sel=0, expected %h, got %h", in0, mux_out);
            $finish;
        end

        sel = 1'b1;
        #10;
        if (mux_out !== in1) begin
            $display("TEST FAILED: sel=1, expected %h, got %h", in1, mux_out);
            $finish;
        end

        $display("TEST PASSED");
        $finish;
    end
endmodule
