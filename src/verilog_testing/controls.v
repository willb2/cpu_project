

module controls(clk, opcode, funct, regDst, regWrite, aluSrc, pcSrc, memRead, memWrite, memToReg, aluOp, jumpNextAddr, jumpMux, instruction);
	input clk;
	input [5:0] opcode;
	input [5:0] funct;
	output reg regDst, regWrite, aluSrc, pcSrc, memRead, memWrite, memToReg;
	output reg [3:0] aluOp;
	output reg jumpMux;
	output reg [31:0] jumpNextAddr;
	input [31:0] instruction;

	// Opcodes
		// ADD  	0x00  	0x20 (Funct)    Ex: 0b[000000][ $rs ][ $rt ][ $rd ][00000][100000]
		// ADDI 	0x08  	 				Ex: 0b[001000][ $zero ] [ $dest ] [ signextimm ]
		// LW 		0x23  					Ex: 0b[100011][ $zero ] [ $dest ] [  offset  ]
		// SW 		0x2B  					Ex: 0b[101011][ $zero ] [ $src ] [ offset ]
		// BEQ 		0x04  					Ex: 0b[000100][$rs][$rt][ instrAddrOffset-1 ]
		// BNE 		0x05  					Ex: 0b[000101][$rs][$rt][ instrAddrOffset-1 ]
		// JMP 		0x02  					Ex: 0b[000010][ instrAddr  ]


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

	always @ (posedge clk) 
	begin
		#20
		case(opcode)
			6'h00 : // ADD
				begin
					regDst = 1'b1; // RgDst comes from rt field 		RgDst comes from rd field
					regWrite = 1'b1; // None 							writeData input written to Write register
					aluSrc = 1'b0; // 2nd ALU src from RegData2 		2nd ALU src from SignExtend
					pcSrc = 1'b1; // PC input from adder+4 			PC input from adder, branch target
					memRead = 1'b0; // None 							Data Read from Memory
					memWrite = 1'b0; // None							Data Written to Memory
					memToReg = 1'b0; // RegWriteData comes from ALU 	RegWriteData comes from Memory
					aluOp = 4'b0010; // 
					jumpMux = 1'b0;
					$display("CNTL: ADD: regDst: %h, regWrite: %h, aluSrc: %h, pcSrc: %h, memRead: %h, memWrite: %h, memToReg: %h, aluOp: %h", regDst, regWrite, aluSrc, pcSrc, memRead, memWrite, memToReg, aluOp);
				end
			6'h08 : // ADDI
				begin
					regDst = 1'b0; // RgDst comes from rt field 		RgDst comes from rd field
					regWrite = 1'b1; // None 							writeData input written to Write register
					aluSrc = 1'b1; // 2nd ALU src from RegData2 		2nd ALU src from SignExtend
					pcSrc = 1'b0; // PC input from adder+4 			PC input from adder, branch target
					memRead = 1'b0; // None 							Data Read from Memory
					memWrite = 1'b0; // None							Data Written to Memory
					memToReg = 1'b0; // RegWriteData comes from ALU 	RegWriteData comes from Memory
					aluOp = 4'b0010; // 
					jumpMux = 1'b0;
					$display("CNTL: ADDI: regDst: %h, regWrite: %h, aluSrc: %h, pcSrc: %h, memRead: %h, memWrite: %h, memToReg: %h, aluOp: %h", regDst, regWrite, aluSrc, pcSrc, memRead, memWrite, memToReg, aluOp);
				end

			6'h23 : // LW
				begin
					regDst = 1'b0; // RgDst comes from rt field 		RgDst comes from rd field
					regWrite = 1'b1; // None 							writeData input written to Write register
					aluSrc = 1'b1; // 2nd ALU src from RegData2 		2nd ALU src from SignExtend
					pcSrc = 1'b0; // PC input from adder+4 			PC input from adder, branch target
					memRead = 1'b1; // None 							Data Read from Memory
					memWrite = 1'b0; // None							Data Written to Memory
					memToReg = 1'b1; // RegWriteData comes from ALU 	RegWriteData comes from Memory
					aluOp = 4'b0010; // 
					jumpMux = 1'b0;
					$display("CNTL: LW: regDst: %h, regWrite: %h, aluSrc: %h, pcSrc: %h, memRead: %h, memWrite: %h, memToReg: %h, aluOp: %h", regDst, regWrite, aluSrc, pcSrc, memRead, memWrite, memToReg, aluOp);
				end

			6'h2B : // SW
				begin
					regDst = 1'b0; // RgDst comes from rt field 		RgDst comes from rd field
					regWrite = 1'b0; // None 							writeData input written to Write register
					aluSrc = 1'b1; // 2nd ALU src from RegData2 		2nd ALU src from SignExtend
					pcSrc = 1'b0; // PC input from adder+4 			PC input from adder, branch target
					memRead = 1'b0; // None 							Data Read from Memory
					memWrite = 1'b1; // None							Data Written to Memory
					memToReg = 1'b0; // RegWriteData comes from ALU 	RegWriteData comes from Memory
					aluOp = 4'b0010; // 
					jumpMux = 1'b0;
					$display("CNTL: SW: regDst: %h, regWrite: %h, aluSrc: %h, pcSrc: %h, memRead: %h, memWrite: %h, memToReg: %h, aluOp: %h", regDst, regWrite, aluSrc, pcSrc, memRead, memWrite, memToReg, aluOp);
				end

			6'h04 : // BEQ
				begin
					regDst = 1'b1; // RgDst comes from rt field 		RgDst comes from rd field
					regWrite = 1'b0; // None 							writeData input written to Write register
					aluSrc = 1'b0; // 2nd ALU src from RegData2 		2nd ALU src from SignExtend
					pcSrc = 1'b1; // PC input from adder+4 			PC input from adder, branch target
					memRead = 1'b0; // None 							Data Read from Memory
					memWrite = 1'b0; // None							Data Written to Memory
					memToReg = 1'b0; // RegWriteData comes from ALU 	RegWriteData comes from Memory
					aluOp = 4'b0110; // 
					jumpMux = 1'b0;
					$display("CNTL: BEQ: regDst: %h, regWrite: %h, aluSrc: %h, pcSrc: %h, memRead: %h, memWrite: %h, memToReg: %h, aluOp: %h", regDst, regWrite, aluSrc, pcSrc, memRead, memWrite, memToReg, aluOp);
				end

			6'h05 : // BNE
				begin
					regDst = 1'b1; // RgDst comes from rt field 		RgDst comes from rd field
					regWrite = 1'b0; // None 							writeData input written to Write register
					aluSrc = 1'b0; // 2nd ALU src from RegData2 		2nd ALU src from SignExtend
					pcSrc = 1'b1; // PC input from adder+4 			PC input from adder, branch target
					memRead = 1'b0; // None 							Data Read from Memory
					memWrite = 1'b0; // None							Data Written to Memory
					memToReg = 1'b0; // RegWriteData comes from ALU 	RegWriteData comes from Memory
					aluOp = 4'b0110; // 
					jumpMux = 1'b0;
					$display("CNTL: BNE: regDst: %h, regWrite: %h, aluSrc: %h, pcSrc: %h, memRead: %h, memWrite: %h, memToReg: %h, aluOp: %h", regDst, regWrite, aluSrc, pcSrc, memRead, memWrite, memToReg, aluOp);
				end

			6'h02 : // JMP
				begin
					regDst = 1'b0; // RgDst comes from rt field 		RgDst comes from rd field
					regWrite = 1'b0; // None 							writeData input written to Write register
					aluSrc = 1'b0; // 2nd ALU src from RegData2 		2nd ALU src from SignExtend
					pcSrc = 1'b0; // PC input from adder+4 			PC input from adder, branch target
					memRead = 1'b0; // None 							Data Read from Memory
					memWrite = 1'b0; // None							Data Written to Memory
					memToReg = 1'b0; // RegWriteData comes from ALU 	RegWriteData comes from Memory
					aluOp = 4'b0000; //
					jumpMux = 1'b1;
					jumpNextAddr = (instruction & 32'h0000FFFF);
					$display("CNTL: JMP: regDst: %h, regWrite: %h, aluSrc: %h, pcSrc: %h, memRead: %h, memWrite: %h, memToReg: %h, aluOp: %h, jumpMux: %h", regDst, regWrite, aluSrc, pcSrc, memRead, memWrite, memToReg, aluOp, jumpMux);
				end

			default : 
				begin
					regDst = 1'b0; // RgDst comes from rt field 		RgDst comes from rd field
					regWrite = 1'b0; // None 							writeData input written to Write register
					aluSrc = 1'b0; // 2nd ALU src from RegData2 		2nd ALU src from SignExtend
					pcSrc = 1'b0; // PC input from adder+4 			PC input from adder, branch target
					memRead = 1'b0; // None 							Data Read from Memory
					memWrite = 1'b0; // None							Data Written to Memory
					memToReg = 1'b0; // RegWriteData comes from ALU 	RegWriteData comes from Memory
					aluOp = 4'b0010; // 
					jumpMux = 1'b0;
					$display("CNTL: Unknown Instruction: %h", opcode);
				end
		endcase
	end

endmodule

/*
module controls_tb();

	reg clk_tb;
	reg [5:0] opcode_tb;
	reg [5:0] funct_tb;
	wire regDst_tb, regWrite_tb, aluSrc_tb, pcSrc_tb, memRead_tb, memWrite_tb, memToReg_tb;
	wire [3:0] aluOp_tb;

	initial 
	begin
		$display("Controls Testbench");
		clk_tb = 0;
		opcode_tb = 6'h00;
		funct_tb = 6'h00;
		
		#1
		clk_tb = 1;

		#100
		$display("Add Instruction: regDst %h, regWrite %h, aluSrc %h", regDst_tb, regWrite_tb, aluSrc_tb);
		$display("Add Instruction: pcSrc %h, memRead %h, memWrite %h", pcSrc_tb, memRead_tb, memWrite_tb);
		$display("Add Instruction: memToReg %h, aluOp %h", memToReg_tb, aluOp_tb);

		
		$finish;
	end

	controls controls_t(clk_tb, opcode_tb, funct_tb, regDst_tb, regWrite_tb, aluSrc_tb, pcSrc_tb, memRead_tb, memWrite_tb, memToReg_tb, aluOp_tb);

endmodule
*/