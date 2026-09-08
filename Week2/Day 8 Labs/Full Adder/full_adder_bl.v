module full_adder_bl(
    input a,
    input b,
    input cin,
    output reg sum,
    output reg cout
);

    always @(*) begin
        {cout, sum} = a + b + cin;
        
    end


endmodule