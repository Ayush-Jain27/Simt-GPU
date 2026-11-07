`timescale 1ns/1ps
module mac (
  input  logic                      clk,
  input  logic                      clear,
  input  logic                      en,
  input  logic signed [7:0]         a,
  input  logic signed [7:0]         b,
  output  logic signed [31:0]       acc
);

logic signed [15:0] product;

assign product = a*b;
 
always_ff @(posedge clk) begin
    if(clear)
        acc <= 32'sd0;
  else if (en)
    acc <= acc + {{16{product[15]}}, product};
end

endmodule
