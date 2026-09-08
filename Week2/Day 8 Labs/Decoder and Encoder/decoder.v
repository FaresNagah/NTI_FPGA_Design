module decoder #(
    parameter WIDTH = 2,
    parameter OUT_WIDTH = 4
)(

    input [WIDTH-1:0] in,
    input enable,
    output reg [OUT_WIDTH-1:0] out
);

    always @(*) begin
        if (enable) begin
            case (in)
                2'b00: begin out = 4'b0001; end
                2'b01: begin out = 4'b0010; end
                2'b10: begin out = 4'b0100; end
                2'b11: begin out = 4'b1000; end
            endcase 
        end
    end

endmodule