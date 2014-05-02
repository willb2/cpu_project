

module and_gate(zero, pcSrc, branchMux);
	input zero, pcSrc;
	output reg branchMux;

	always @ (*) begin
		if ((zero == 1) && (pcSrc == 1)) begin
			branchMux = 1'b1;
		end else begin
			branchMux = 1'b0;
		end
	end

endmodule


module and_gate_tb();
	reg zero_tb;
	reg pcSrc_tb;
	wire branchMux_tb;

	initial begin
		$display("AndGate Testbench");
		zero_tb = 1;
		pcSrc_tb = 1;
		#1
		$display("%h, %h --> %h", zero_tb, pcSrc_tb, branchMux_tb);


		$finish;
	end


	and_gate and_gate(zero_tb, pcSrc_tb, branchMux_tb);
endmodule