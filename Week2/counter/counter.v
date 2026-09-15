module counter #(
  parameter WIDTH = 5
)(
  input                    clk,
  input                    rst,
  input                    load,
  input                    enab,
  input      [WIDTH-1:0]   cnt_in,
  output reg [WIDTH-1:0]   cnt_out
);

  function [WIDTH-1:0] next_count;
    input               rst_val;
    input               load_val;
    input               enab_val;
    input [WIDTH-1:0]   in_val;
    input [WIDTH-1:0]   curr_val;
    begin
      if (rst_val)
        next_count = {WIDTH{1'b0}};
      else if (load_val)
        next_count = in_val;
      else if (enab_val)
        next_count = curr_val + 1'b1;
      else
        next_count = curr_val;
    end
  endfunction

  always @(posedge clk) begin
    cnt_out <= next_count(rst, load, enab, cnt_in, cnt_out);
  end

endmodule