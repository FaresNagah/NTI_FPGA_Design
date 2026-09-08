module full_adder_gl(
    input a,b,cin,
    output sum,cout
);
    wire xor1, and1, and2;

    xor(xor1, a, b);
    and(and1, a, b);
    and(and2, xor1, cin);
    xor(sum, xor1, cin);
    or(cout, and1, and2);



endmodule