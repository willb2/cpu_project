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


module top(clk, rst);
	input clk, rst;

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
	wire [31:0] jumpNextAddr;

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
	wire jumpMux;

	// Glue Wires
	wire branchMux;


	// Modules
	program_counter pc(clk, rst, norm_iaddr, branch_iaddr, branchMux, pc_out, jumpNextAddr, jumpMux);
	
	instr_memory im(clk, pc_out, instruction);
	
	// Opcode [31:26]    Funct [5:0]   
	controls controls(clk, instruction[31:26], instruction[5:0], regDst, regWrite, aluSrc, pcSrc, memRead, memWrite, memToReg, aluOp, jumpNextAddr, jumpMux, instruction);

	adder adder_norm(pc_out, 31'h01, norm_iaddr);
	
	adder adder_branch(norm_iaddr, signext_out, branch_iaddr);
	
	// [Rs 25:21] [Rt 20:16] [Rd 15:11]
	registers reggies(clk, instruction[25:21], instruction[20:16], instruction[15:11], regData1, regData2, alu_out, dmem_out, memToReg, regWrite, regDst);
	
	signext signext(instruction[15:0], signext_out);

	alu alu(clk, aluOp, regData1, regData2, signext_out, aluSrc, alu_out, zero);
	
	data_memory dm(clk, memRead, memWrite, alu_out, regData2, dmem_out);

	and_gate and_gate(zero, pcSrc, branchMux);

endmodule


module top_tb();
	reg clk_tb;
	reg rst_tb;
	reg [5:0] count;

	initial begin
		$display("Top-Level Testbench");
		rst_tb = 1;
		clk_tb = 0;
		count = 0;
		#1
		rst_tb = 0;
	end
	/*
	initial begin
		$display("Top-Level Testbench");
		rst_tb = 1;
		clk_tb = 0;
		#1
		rst_tb = 0;
		#1
		$display("---- Clk Cycle 1 ----");
		#100
		clk_tb = 1;
		#100
		clk_tb = 0;
		
		#1
		$display("---- Clk Cycle 2 ----");
		#100
		clk_tb = 1;
		#100
		clk_tb = 0;
		
		#1
		$display("---- Clk Cycle 3 ----");
		#100
		clk_tb = 1;
		#100
		clk_tb = 0;
		
		#1
		$display("---- Clk Cycle 4 ----");
		#100
		clk_tb = 1;
		#100
		clk_tb = 0;

		#1
		$display("---- Clk Cycle 5 ----");
		#100
		clk_tb = 1;
		#100
		clk_tb = 0;

		#1
		$display("---- Clk Cycle 6 ----");
		#100
		clk_tb = 1;
		#100
		clk_tb = 0;

		$finish;
	end
	*/
	always begin
		while (count < 6'h15) begin
			count = count + 1;
			#1 $display("---- Clk Cycle %h ----", count);
			#100 clk_tb = 1;
			#100 clk_tb = 0;
		end
		$finish;
	end

	top top_t(clk_tb, rst_tb);


endmodule


