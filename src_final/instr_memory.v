/*
 Read Only Memory used to store and retrieve program instructions. (2^28 bytes large / 2^26 words large)
	What is the address size?
*/


module instr_memory(clk, address, instruction);
	input clk;
	input [31:0] address;
	output reg [31:0] instruction, jumpNextAddr;
	output reg jumpMux;

	reg [31:0] Mem [0:10]; // 11 32-bit words
	reg [5:0] opcode; // 5 bit opcode
	reg signed [31:0] newInstr; //singed 32bit instruction
	reg [31:0] oldInstr; //32 bit instruction

	initial $readmemh("instructions.txt", Mem);
	
	always@(posedge clk) begin
		#10
		instruction = Mem[address];
		$display("IMEM: new instruction: %h", instruction);
	end

endmodule

/* ********************************************************************
// ***************** instruction_memory testbench for testing/debugging
// ********************************************************************
module instr_memory_tb();
	reg [31:0] address_tb;
	wire [31:0] instruction_tb;

	initial 
	begin
		$display("Instruction Memory Testbench");
		// Set parameters
		address_tb = 32'h0000;
		#100
		$display("retrieved %h from address %h", instruction_tb, address_tb);

		address_tb = 32'h0001;
		#100
		$display("retrieved %h from address %h", instruction_tb, address_tb);

		address_tb = 32'h0002;
		#100
		$display("retrieved %h from address %h", instruction_tb, address_tb);

		address_tb = 32'h0003;
		#100
		$display("retrieved %h from address %h", instruction_tb, address_tb);

		$finish;
	end

	instr_memory instrmem_t(address_tb, instruction_tb);

endmodule

*/
