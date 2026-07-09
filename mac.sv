`timescale 1ns/1ps
module mac (
  input  logic                      clk,
  input  logic                      clear,
  input  logic signed [7:0]         a,
  input  logic signed [7:0]         b,
  output  logic signed [31:0]       acc
);

always_ff @(posedge clk) begin
    if(clear)
        acc <= '0;
    else
        acc <= acc + (a*b);
end

endmodule
