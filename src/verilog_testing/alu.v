

module alu(aluOp, data1, data2, result); //zero);
	input [3:0] aluOp;
	input [31:0] data1, data2;
	output reg [31:0] result;
	//output zero;

	wire signed [31:0] data1_s, data2_s;
	wire signed [31:0] data_add;
	wire signed [31:0] data_sub;

	assign data1_s = data1;
	assign data2_s = data2;
	assign data_add = (data1_s + data2_s);
	assign data_sub = (data1_s - data2_s);


	// ALU Opcode
		// 0000 AND
		// 0001 OR
		// 0010 add
		// 0110 subtract
		// 0111 set on less than
		// 1100 NOR
	always @ (*) begin
		case(aluOp)
			4'b0000 : result = data1 & data2; // AND
			4'b0001 : result = data1 | data2; // OR
			4'b0010 : result = data_add; // add
			4'b0110 : result = data_sub; // subtract
			4'b0111 : result = 32'h0; // set on less than
			4'b1100 : result = 32'h0; // NOR
			default : result = 32'h0;
		endcase
	end

endmodule


module alu_tb();

	reg [3:0] aluOp_tb;
	reg [31:0] data1_tb;
	reg [31:0] data2_tb;
	wire [31:0] result_tb;

	initial 
	begin
		$display("ALU Testbench");
		aluOp_tb = 4'b1111;//0010;
		data1_tb = 32'h0001;
		data2_tb = 32'h0001;
		$display("ADD: %h + %h = %h", data1_tb, data2_tb, result_tb);

		aluOp_tb = 4'b0110;
		//data1_tb = 32'h0001;
		//data2_tb = 32'h0001;
		$display("SUB: %h - %h = %h", data1_tb, data2_tb, result_tb);

		
		$finish;
	end

	alu alu_t(aluOp_tb, data1_tb, data2_tb, result_tb);



endmodule


