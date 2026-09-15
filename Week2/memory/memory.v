module memory #(
  parameter integer AWIDTH = 5,
  parameter integer DWIDTH = 8
)(
  input                     clk,
  input                     wr,
  input                     rd,
  input      [AWIDTH-1:0]   addr,
  inout      [DWIDTH-1:0]   data
);

  reg [DWIDTH-1:0] mem [(1 << AWIDTH) - 1:0];

  always @(posedge clk) begin
    if (wr) begin
      mem[addr] <= data;
    end
  end

  
  assign data = (rd) ? mem[addr] : {DWIDTH{1'bz}};

endmodule