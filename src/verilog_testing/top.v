/*
	
*/

module top(clk); // test probes?
	input clk;

	// Lots of wires

	program_counter pc();
	
	instr_memory im();
	
	controls controls();

	adder adder_1(a, b, sum);
	
	adder adder_jump(a, b, sum);
	
	registers reggies();
	
	alu alu();
	
	data_memory dm();


endmodule


module alu_tb();
	reg clk_tb;

	initial 
	begin
		$display("Top-Level Testbench");
		
		

		$finish;
	end

	top top_t(clk_tb);


endmodule


