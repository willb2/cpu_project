/*
	What is the address size?
*/


module instr_memory(address, instruction);
	input [31:0] address;
	output reg [31:0] instruction;

	reg [31:0] Mem [0:10]; // 201 32-bit words
	reg [5:0] opcode;

	initial $readmemh("instructions.txt", Mem);
	
	always@(address) begin
		instruction = Mem[address];
	end

	always@(instruction) begin
		opcode = instruction[31:26];
		if(opcode == 6'h02) begin
			$display("JMP Instruction: Jumping from address %h to %h", address, instruction[24:0]);
			instruction = Mem[instruction[24:0]];
		end
	end

endmodule


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


