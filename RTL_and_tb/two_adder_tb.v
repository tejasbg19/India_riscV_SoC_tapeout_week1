module tb;
reg [1:0]A,B;
reg C;
wire [1:0]S;
wire Cout;

two_adder tw1(.A(A),.B(B), .Cin(C),.S(S),.Cout(Cout));

initial 
begin
A = 2'd0; B = 2'd0; C=1'd0;
#5 A = 2'd3; B = 2'd3; C=1'd1;
#5 A = 2'd3; B = 2'd3; C=1'd0;
#5 A = 2'd0; B = 2'd3; C=1'd0;
#5 A = 2'd0; B = 2'd3; C=1'd1;
#5 $finish;
end

initial
begin
$dumpfile("wave_two.vcd");
$dumpvars(0,tb);
end
endmodule
