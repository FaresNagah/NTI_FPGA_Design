module register #(
  parameter WIDTH = 8
)(
  input                    clk,
  input                    rst,
  input                    load,
  input      [WIDTH-1:0]   data_in,
  output reg [WIDTH-1:0]   data_out
);

  always @(posedge clk) begin
    if (rst) begin
      data_out <= {WIDTH{1'b0}};
    end else if (load) begin
      data_out <= data_in;
    end
  end

endmodule