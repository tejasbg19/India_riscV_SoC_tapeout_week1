  module dff_simple (input  wire clk, input  wire d, output reg  q);
      always @(posedge clk)
      begin
        q <= d;   
      end
      endmodule
