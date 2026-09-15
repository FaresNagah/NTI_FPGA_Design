module counter #(
    parameter WIDTH = 5
) (
    input [WIDTH - 1 : 0] cnt_in,
    input enab, load, clk, rst,
    output reg [WIDTH - 1 : 0] cnt_out
);

    function [WIDTH - 1 : 0] counter_next;
        input [WIDTH - 1 : 0] current_count;
        input [WIDTH - 1 : 0] load_value;
        input en;
        input ld;
        
        begin
            if (ld)
                counter_next = load_value;
            else if (en)
                counter_next = current_count + 1;
            else
                counter_next = current_count;
        end
    endfunction

    always @(posedge clk) begin
        if (rst)
            cnt_out <= 0;
        else
            cnt_out <= counter_next(cnt_out, cnt_in, enab, load);
    end

endmodule