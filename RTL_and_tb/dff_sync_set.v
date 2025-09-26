 module dff_sync_set (input wire clk, input wire set, input wire d, output reg q);
    always @(posedge clk)
       begin
        if (set)
          q <= 1'b1;
        else
          q <= d;
       end
    endmodule
