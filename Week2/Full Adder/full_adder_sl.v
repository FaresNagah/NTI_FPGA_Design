module full_adder_sl(
    input a,b,cin,
    output sum,cout
);
wire s1,c1,c2;
half_adder h1(a,b,s1,c1);
half_adder h2(s1,cin,sum,c2);
or(cout,c1,c2);
endmodule