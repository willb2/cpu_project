/*
Register Mux: 
	Mem: 0    
	ALU: 1
Program Counter Mux:  
	Norm: 0 
	Branch: 1
ALU Mux: 
	data2reg: 0    
	data2ext: 1
*/
`include "program_counter.v"
`include "instr_memory.v"
`include "controls.v"
`include "adder.v"
`include "registers.v"
`include "signext.v"
`include "alu.v"
`include "data_memory.v"
`include "and_gate.v"


module top(clk); // test probes?
	input clk;

	// Datapath Wires
	wire [31:0] pc_out;
	wire [31:0] instruction;
	wire [31:0] regData1;
	wire [31:0] regData2;
	wire [31:0] signextData;
	wire [31:0] alu_out;
	wire [31:0] dmem_out;
	wire [31:0] norm_iaddr;
	wire [31:0] branch_iaddr;
	wire [31:0] signext_out;

	// Control Wires
	wire regDst;
	wire regWrite;
	wire aluSrc;
	wire pcSrc;
	wire memRead;
	wire memWrite;
	wire memToReg;
	wire [3:0] aluOp;
	wire zero;

	// Glue Wires
	reg branchMux;


	// Initialization?


	// Modules
	program_counter pc(norm_iaddr, branch_iaddr, branchMux, pc_out);
	
	instr_memory im(pc_out, instruction);
	
	// Opcode [31:26]    Funct [5:0]   
	controls controls(instruction[31:26], instruction[5:0], regDst, regWrite, aluSrc, pcSrc, memRead, memWrite, memToReg, aluOp);

	adder adder_norm(pc_out, 31'h01, norm_iaddr);
	
	adder adder_branch(norm_iaddr, signext_out, branch_iaddr);
	
	// [Rs 25:21] [Rt 20:16] [Rd 15:11]
	registers reggies(clk, instruction[25:21], instruction[20:16], instruction[15:11], regData1, regData2, alu_out, dmem_out, memToReg);
	
	signext signext(instruction[15:0], signext_out);

	alu alu(aluOp, regData1, regData2, signext_out, aluSrc, alu_out, zero);
	
	data_memory dm(memread, memWrite, alu_out, regData2, dmem_out);

	and_gate and_gate(zero, pcSrc, branchMux);

endmodule


module top_tb();
	reg clk_tb;

	initial 
	begin
		$display("Top-Level Testbench");
		
		

		$finish;
	end

	top top_t(clk_tb);


endmodule


