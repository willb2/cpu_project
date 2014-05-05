/*
The Program Counter is a set of registers that contain the address of the instruction to be fetched from instruction memory.
*/

// Mux:  Norm: 0    Branch: 1

module program_counter(clk, rst, addressNorm, addressBranch, mux, addressOut, jumpNextAddr, jumpMux);
	input clk, rst, mux, jumpMux;
	input [31:0] addressNorm, addressBranch, jumpNextAddr; //32 bit data input
	output reg [31:0] addressOut; //32 bit register output

	reg [31:0] nextAddr;

	always @ (negedge rst) begin
		nextAddr = 32'h0;
		$display("PC: ADDR RST to %h", nextAddr);
	end

	always @ (negedge clk) begin
		if (jumpMux) begin
			nextAddr = jumpNextAddr;
		end
		else if (mux) begin
			nextAddr = addressBranch;
		end else begin
			nextAddr = addressNorm;
		end
	end

	always @ (posedge clk) begin
		addressOut = nextAddr;
		$display("PC: New Addr: %h", addressOut);
	end
		
endmodule

/* ******************************************************************
// ***************** program_counter testbench for testing/debugging
// ******************************************************************
module program_counter_tb();

	reg clk_tb;
	reg rst_tb;
	reg mux_tb;
	reg [31:0] addressNorm_tb, addressBranch_tb;
	wire [31:0] addressOut_tb;

	initial begin
		$display("Program Counter Testbench");
		addressNorm_tb = 32'h0A;
		addressBranch_tb = 32'h0B;
		mux_tb = 0;
		clk_tb = 0;
		#1
		clk_tb = 1;
		#1
		$display("Mux: %h -> Address: %h", mux_tb, addressOut_tb);
		#1
		mux_tb = 1;
		#2
		clk_tb = 0;
		#1
		clk_tb = 1;
		#3
		$display("Mux: %h -> Address: %h", mux_tb, addressOut_tb);
		#1
		rst_tb = 1;
		#1
		$display("Reset Mux: %h -> Address: %h", mux_tb, addressOut_tb);
		$finish;
	end

	program_counter program_counter_t(clk_tb, rst_tb, addressNorm_tb, addressBranch_tb, mux_tb, addressOut_tb);

endmodule
*/
