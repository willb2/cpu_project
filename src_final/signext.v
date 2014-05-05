/*
Sign extends an incoming two’s compliment number by filling additional 16 most significant bits with the most-significant bit of the incoming number.
*/
module signext(in, out);
	input signed [15:0] in;
	output signed [31:0] out;

	assign out = in;

endmodule



/* ***************************************************************
// ***************** signextender testbench for testing/debugging
// ***************************************************************
module signext_tb();

	reg [15:0] in_tb;
	wire [31:0] out_tb;

	initial 
	begin
		$display("Signext Testbench");

		in_tb = 16'h1234;
		$display("Current value of input = %h", in_tb);
		$display("Current value of output = %h", out_tb);

		in_tb = 16'hF234;
		$display("Current value of input = %h", in_tb);
		$display("Current value of output = %h", out_tb);

		$finish;
	end

	signext signext_t(in_tb, out_tb);

endmodule
*/