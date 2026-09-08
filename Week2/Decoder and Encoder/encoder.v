module encoder #(
    parameter WIDTH = 4,
    parameter OUT_WIDTH = 2
)(
    input [WIDTH-1:0] in,
    input enable,
    output reg [OUT_WIDTH-1:0] out
);
    
    always @(*) begin
        
        if (enable) begin
            case (in)
                4'b0000: begin out = 2'b00;  end
                4'b0001: begin out = 2'b01;  end
                4'b0010: begin out = 2'b10;  end
                4'b0011: begin out = 2'b11;  end
            endcase
        end
    end

endmodule