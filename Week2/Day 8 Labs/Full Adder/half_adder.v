module half_adder(
    input a,b ,
    output sum,cout
);

    assign {cout, sum} = a + b;

endmodule