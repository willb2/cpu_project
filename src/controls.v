

module controls(opcode, funct, regDst, regWrite, aluSrc, pcSrc, memRead, memWrite, memToReg, aluOp);
	input [5:0] opcode;
	input [4:0] funct;
	output regDst, regWrite, aluSrc, pcSrc, memRead, memWrite, memToReg;
	output [3:0] aluOp;


	// Controls
		// Signal Name			Effect When Deasserted 			Effect When Assert

		// RegDst 				RgDst comes from rt field 		RgDst comes from rd field
		// RegWrite 			None 							writeData input written to Write register
		// ALUSrc 				2nd ALU src from RegData2 		2nd ALU src from SignExtend
		// PCSrc 				PC input from adder+4 			PC input from adder, branch target
		// MemRead 				None 							Data Read from Memory
		// MemWrite 			None							Data Written to Memory
		// MemToReg 			RegWriteData comes from ALU 	RegWriteData comes from Memory



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