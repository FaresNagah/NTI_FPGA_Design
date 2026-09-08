module alu #(
    parameter WIDTH = 8
)(
    input  wire [2:0]       opcode,
    input  wire [WIDTH-1:0] in_a,
    input  wire [WIDTH-1:0] in_b,
    output wire             a_is_zero,
    output reg  [WIDTH-1:0] alu_out
);

    assign a_is_zero = !in_a;

    always @(*) begin
        
            
        case (opcode)
            3'b000:  alu_out = in_a;
            3'b001:  alu_out = in_a;
            3'b010:  alu_out = in_a + in_b;
            3'b011:  alu_out = in_a & in_b;
            3'b100:  alu_out = in_a ^ in_b;
            3'b101:  alu_out = in_b;
            3'b110:  alu_out = in_a;
            3'b111:  alu_out = in_a;
            default alu_out = in_a; 
        endcase
    end

endmodule