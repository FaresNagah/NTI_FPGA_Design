module full_adder_gl(
    input a,b,cin,
    output sum,cout
);
xor(sum,a,b,cin);
and(c1,a,b);
and(c2,b,cin);
and(c3,a,cin);
or(cout,c1,c2,c3);
endmodule