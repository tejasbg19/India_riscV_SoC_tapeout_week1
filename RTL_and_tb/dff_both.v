module dff_async_reset_sync_reset (input wire clk, input wire arst, input wire srst, input wire d, output reg q);
      always @(posedge clk or posedge arst)
        begin
          if (arst)
            q <= 1'b0;
          else if (srst)
            q <= 1'b0;
          else
            q <= d;
        end
    endmodule
