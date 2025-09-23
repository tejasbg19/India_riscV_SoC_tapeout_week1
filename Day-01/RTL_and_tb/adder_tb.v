module tb;
reg A,B,Cin;
wire S,Cout;

adder a1(A,B,Cin,S,Cout);
initial 
begin 
A = 0 ; B=0; Cin=0;
#5 A=0; B=0; Cin=1;
#5 A=0; B=1; Cin=0;
#5 A=0; B=1; Cin =1;
#5 A=1; B=1; Cin =1;
#5 $finish;
end

initial 
begin 
$dumpfile("Wave.vcd");
$dumpvars(0,tb);
end
endmodule
