/*

*/

// Mux:  Norm: 0    Branch: 1

module program_counter(addressNorm, addressBranch, mux, addressOut);

	input mux;
	input [31:0] addressNorm, addressBranch;
	output reg [31:0] addressOut;

	always @ (mux)
	if (mux) begin
		addressOut = addressBranch;
	end else begin
		addressOut = addressNorm;
	end
	

endmodule


module program_counter_tb();

	reg mux_tb;
	reg [31:0] addressNorm_tb, addressBranch_tb;
	wire [31:0] addressOut_tb;

	initial begin
		$display("Program Counter Testbench");
		addressNorm_tb = 32'h0A;
		addressBranch_tb = 32'h0B;
		mux_tb = 0;
		#1
		$display("Mux: %h -> Address: %h", mux_tb, addressOut_tb);
		#2
		mux_tb = 1;
		#3
		$display("Mux: %h -> Address: %h", mux_tb, addressOut_tb);

		$finish;
	end

	program_counter program_counter_t(addressNorm_tb, addressBranch_tb, mux_tb, addressOut_tb);

endmodule