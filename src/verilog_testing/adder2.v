module adder2(a, b, sum);
	input  [31:0] a;     // a input
	input  [31:0] b;     // b input
	output [31:0] sum;   // sum output
	assign #250 {sum} = a + b;
endmodule // add32