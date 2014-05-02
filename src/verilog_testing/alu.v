/*
	
*/

// Mux: data2reg: 0    data2ext: 1

module alu(aluOp, data1, data2reg, data2ext, mux, result, zero);
	input mux;
	input signed [3:0] aluOp;
	input signed [31:0] data1, data2reg, data2ext;
	output wire [31:0] result;
	
	reg [31:0] data2;
	reg [31:0] out;
	output reg zero;

	always @ (mux) begin
		if (mux == 1) begin
			data2 = data2ext;
		end else begin
			data2 = data2reg;
		end
	end

	always @ (*) begin
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

	always @ (out) begin
		if(out == 0) begin
			zero = 1;
		end else begin
			zero = 0;
		end
	end

	assign result = out;

endmodule


module alu_tb();

	reg mux_tb;
	reg [3:0] aluOp_tb;
	reg [31:0] data1_tb;
	reg [31:0] data2reg_tb;
	reg [31:0] data2ext_tb;

	wire [31:0] result_tb;
	wire zero_tb;

	initial 
	begin
		$display("ALU Testbench");
		data1_tb = 32'h0000000F;
		data2reg_tb = 32'h00000007;
		mux_tb = 0;
		
		aluOp_tb = 4'b0000;
		#100
		$display("AND: %h & %h = %h", data1_tb, data2reg_tb, result_tb);
		
		aluOp_tb = 4'b0001;
		#100
		$display("OR: %h | %h = %h", data1_tb, data2reg_tb, result_tb);
		
		data2reg_tb = 32'h0000000F;
		aluOp_tb = 4'b0110;
		#100
		$display("SUB: %h - %h = %h  zero: %h", data1_tb, data2reg_tb, result_tb, zero_tb);
		
		aluOp_tb = 4'b0010;
		#100
		$display("ADD: %h + %h = %h  zero: %h", data1_tb, data2reg_tb, result_tb, zero_tb);
		
		$finish;
	end

	alu alu_t(aluOp_tb, data1_tb, data2reg_tb, data2ext_tb, mux_tb, result_tb, zero_tb);


endmodule


