/*
	
*/

module alu(aluOp, data1, data2, result); //zero);
	input wire [3:0] aluOp;
	input wire [31:0] data1, data2;
	output wire [31:0] result;
	reg [31:0] out;
	//output zero;


	// ALU Opcode
		// 0000 AND
		// 0001 OR
		// 0010 add
		// 0110 subtract
		// 0111 set on less than
		// 1100 NOR
	always @ (*) 
	begin
		case(aluOp)
			4'b0000 : out = data1 & data2; // AND
			4'b0001 : out = data1 | data2; // OR
			4'b0010 : out = data1 + data2; // add
			4'b0110 : out = data1 - data2; // subtract
			4'b0111 : out = 32'h0; // set on less than
			4'b1100 : out = 32'h0; // NOR
			default : out = 32'h0;
		endcase
	end

	assign result = out;

endmodule


module alu_tb();

	reg [3:0] aluOp_tb;
	reg [31:0] data1_tb;
	reg [31:0] data2_tb;
	wire [31:0] result_tb;

	initial 
	begin
		$display("ALU Testbench");
		data1_tb = 32'h000F;
		data2_tb = 32'h0007;
		
		aluOp_tb = 4'b0000;
		#100
		$display("AND: %h & %h = %h", data1_tb, data2_tb, result_tb);
		
		aluOp_tb = 4'b0001;
		#100
		$display("OR: %h | %h = %h", data1_tb, data2_tb, result_tb);
		
		aluOp_tb = 4'b0110;
		#100
		$display("SUB: %h - %h = %h", data1_tb, data2_tb, result_tb);
		
		aluOp_tb = 4'b0010;
		#100
		$display("ADD: %h + %h = %h", data1_tb, data2_tb, result_tb);
		
		$finish;
	end

	alu alu_t(aluOp_tb, data1_tb, data2_tb, result_tb);


endmodule


