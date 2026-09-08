module full_adder_tb;
    reg a_tb, b_tb, cin_tb;
    wire sum_tb, cout_tb,sum_bl, cout_bl,sum_gl, cout_gl, sum_sl, cout_sl;

    full_adder_bl dut_bl(
        .a(a_tb),
        .b(b_tb),
        .cin(cin_tb),
        .sum(sum_bl),
        .cout(cout_bl)
    );

    full_adder_gl dut_gl(
        .a(a_tb),
        .b(b_tb),
        .cin(cin_tb),
        .sum(sum_gl),
        .cout(cout_gl)
    );

    full_adder_sl dut_sl(
        .a(a_tb),
        .b(b_tb),
        .cin(cin_tb),
        .sum(sum_sl),
        .cout(cout_sl)
    );

    initial begin
        a_tb = 1'b0; b_tb = 1'b0; cin_tb = 1'b0;
        #10 
        a_tb = 1'b0; b_tb = 1'b0; cin_tb = 1'b1;
        #10 
        a_tb = 1'b0; b_tb = 1'b1; cin_tb = 1'b0;
        #10 
        a_tb = 1'b0; b_tb = 1'b1; cin_tb = 1'b1;
        #10 
        a_tb = 1'b1; b_tb = 1'b0; cin_tb = 1'b0;
        #10 
        a_tb = 1'b1; b_tb = 1'b0; cin_tb = 1'b1;
        #10 
        a_tb = 1'b1; b_tb = 1'b1; cin_tb = 1'b0;
        #10 
        a_tb = 1'b1; b_tb = 1'b1; cin_tb = 1'b1;
        #10 
        $finish;
    end




endmodule