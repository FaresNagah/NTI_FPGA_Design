module clk_divider #(
    parameter Clk_in_par  = 50_000_000,
    parameter Clk_out_par = 8
) (
    input  wire clk_in,
    input  wire rst_n, 
    output reg  clk_out
);

    localparam HALF_PERIOD   = (Clk_in_par / Clk_out_par) / 2;
    localparam COUNTER_WIDTH = $clog2(HALF_PERIOD);

    reg [COUNTER_WIDTH-1:0] counter;

    always @(posedge clk_in or negedge rst_n) begin
        if (rst_n == 1'b0) begin
            counter <= {COUNTER_WIDTH{1'b0}};
            clk_out <= 1'b0;
        end else begin
            if (counter == (HALF_PERIOD - 1)) begin
                counter <= {COUNTER_WIDTH{1'b0}};
                clk_out <= ~clk_out;
            end else begin
                counter <= counter + 1'd1;
            end
        end
    end

endmodule
