module driver #(
    parameter WIDTH = 8
)(

    input wire data_en,
    input wire [WIDTH-1:0] data_in,
    output [WIDTH-1:0] data_out


);

assign data_out = data_en ? data_in :{WIDTH{1'bz}};





endmodule