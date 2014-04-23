

module controls(opcode, funct, regDst, regWrite, aluSrc, pcSrc, memRead, memWrite, memToReg, aluOp);
	input [5:0] opcode;
	input [4:0] funct;
	output regDst, regWrite, aluSrc, pcSrc, memRead, memWrite, memToReg;
	output [3:0] aluOp;






	// ALU OP
		// OpCode 		ALUOp 		Funct Field  	ALU Action 			ALU Control Input
		
		// LW 			00 			XXXXXX			add 				0010
		// SW 			00 			XXXXXX			add 				0010
		// Br Eq 		01  		XXXXXX			subtract 			0110
		// R-Type 		10 			100000			add 				0010
		// R-Type 		10 			100010 			subtract 			0110
		// R-Type 		10 			100100 			AND 				0000
		// R-Type		10 			100101 			OR 					0001
		// R-Type 		10 			101010 			set on less than 	0111


	




endmodule