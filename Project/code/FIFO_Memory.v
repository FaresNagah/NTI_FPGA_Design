module sync_fifo #(
    parameter WIDTH = 8,
    parameter DEPTH = 32
) (
    input clk, rst_n,
    input wr_en, r_en,
    input [WIDTH - 1 : 0] data_in,
    output empty, full,
    output reg [WIDTH - 1 : 0] data_out
);

    reg [$clog2(DEPTH) - 1 : 0] w_ptr, r_ptr; // $clog2 is ceiling of log base 2 
    reg [$clog2(DEPTH + 1) - 1 : 0] cnt;
    reg [WIDTH - 1 : 0] mem [0 : DEPTH - 1];

    assign empty = (cnt == 0);
    assign full = (cnt == DEPTH);
    
    always @(posedge clk) begin
        if(!rst_n) begin
            w_ptr <= 0;
            r_ptr <= 0;
            data_out <= 0;
            cnt <= 0;
        end else begin
            if (wr_en && !full) begin
                mem [w_ptr] <= data_in;
                w_ptr <= w_ptr + 1;
            end 
            if (r_en && !empty) begin
                data_out <= mem[r_ptr];
                r_ptr <= r_ptr + 1;
            end

            case ({wr_en && !full , r_en && !empty})
                2'b10: begin
                    cnt <= cnt + 1;
                end 
                2'b01: begin
                    cnt <= cnt - 1;
                end
                default: cnt <= cnt;
            endcase
        end
    end
endmodule