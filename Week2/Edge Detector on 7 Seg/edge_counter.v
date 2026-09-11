module edg_counter (
    input  wire clk, rst_n , rise_tick, fall_tick, edge_tick,
    output reg  [3:0] rise_count,
    output reg  [3:0] fall_count,
    output reg  [3:0] total_count
);

    always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        rise_count  <= 4'd0;
        fall_count  <= 4'd0;
        total_count <= 4'd0;
    end else  begin
            if (rise_tick)
                rise_count <= rise_count + 1'b1;

            if (fall_tick)
                fall_count <= fall_count + 1'b1;

            if (edge_tick)
                total_count <= total_count + 1'b1;
        end
    end

endmodule