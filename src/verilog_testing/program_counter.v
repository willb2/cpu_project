

module program_counter(address1, address2, mux, addressOut);
	input mux;
	input [31:0] address1, address2;
	output reg [31:0] addressOut;

	always @ (mux)
	if (mux) begin
		addressOut = address2;
	end else begin
		addressOut = address1;
	end
	

endmodule


module program_counter_tb();
	reg mux_tb;
	reg [31:0] address1_tb, address2_tb;
	wire [31:0] addressOut_tb;

	initial begin
		$display("Program Counter Testbench");
		address1_tb = 32'h0A;
		address2_tb = 32'h0B;
		mux_tb = 0;
		#1
		$display("Mux: %h -> Address: %h", mux_tb, addressOut_tb);
		#2
		mux_tb = 1;
		#3
		$display("Mux: %h -> Address: %h", mux_tb, addressOut_tb);

		$finish;
	end

	program_counter program_counter_t(address1_tb, address2_tb, mux_tb, addressOut_tb);


endmodule