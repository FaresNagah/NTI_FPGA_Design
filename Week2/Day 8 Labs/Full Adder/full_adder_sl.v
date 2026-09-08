module full_adder_sl(
    input a, b ,cin,
    output sum, cout
);

    wire xor1, and1, and2;
    

    half_adder Hdd1(
        .a(a),
        .b(b),
        .sum(xor1),
        .cout(and1)
    );

    half_adder Hdd2(
        .a(xor1),
        .b(cin),
        .sum(sum),
        .cout(and2)
    );

    or(cout, and1, and2); 

endmodule