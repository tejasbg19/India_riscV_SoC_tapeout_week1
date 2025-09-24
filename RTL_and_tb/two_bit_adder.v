module two_bit_adder(A,B,Cin,Cout,S);
input [1:0] A,B;
input Cin;
output Cout;
output [1:0] S;

full_adder fa1(.A(A[0]), .B(B[0]),.Cin(Cin),.S(S[0]),.Cout(C1));
full_adder fa2(.A(A[1]), .B(B[1]),.Cin(C1),.S(S[1]),.Cout(Cout));
endmodule
