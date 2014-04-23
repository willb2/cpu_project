

module alu(aluOp, data1, data2, result, zero);
	input [3:0] aluOp
	input [31:0] data1, data2;
	output [31:0] result;
	output zero;

	// ALU Opcode
		// 0000 AND
		// 0001 OR
		// 0010 add
		// 0110 subtract
		// 0111 set on less than
		// 1100 NOR

	



endmodule