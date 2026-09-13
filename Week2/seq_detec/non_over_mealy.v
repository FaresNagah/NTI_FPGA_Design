module non_over_mealy (
    input clk, rst_n, 
    input seq_in, 
    output reg seq_correct
);

    localparam s0 = 3'b000,
               s1 = 3'b001,
               s2 = 3'b010,
               s3 = 3'b011,
               s4 = 3'b100,
               s5 = 3'b101;

    reg [2:0] cs, ns;

    // current state logic 
    always @(posedge clk) begin
        if (!rst_n) begin
            cs <= s0;
        end else begin
            cs <= ns;
        end
    end 

    // next state logic 
    always @(*) begin
        case (cs)
            s0: begin
                if (seq_in) begin
                    ns = s1;
                end else begin
                    ns = s0;
                end
            end 

            s1: begin
                if (seq_in) begin
                    ns = s2;
                end else begin
                    ns = s0;
                end
            end

            s2: begin
                if (seq_in) begin
                    ns = s2;
                end else begin
                    ns = s3;
                end
            end

            s3: begin
                if (seq_in) begin
                    ns = s4;
                end else begin
                    ns = s0;
                end
            end

            s4: begin
                if (seq_in) begin
                    ns = s2;
                end begin
                    ns = s5;
                end
            end

            s5: begin
                if (seq_in) begin
                    ns = s0; // Skipping Overlap happens here !!!!!!!!!!!!
                end else begin
                    ns = s0;
                end
            end
            default: ns = s0;
        endcase
    end


    // output logic 
    always @(*) begin
        if (cs == s5 && seq_in) begin
            seq_correct = 1;
        end else begin
            seq_correct = 0;
        end
    end
    
endmodule