/*
	   ALU is to perform different arithmetic or mathematical operations such as addition, subtraction, multiplication and division.
*/

// Mux: data2reg: 0    data2ext: 1

module alu(clk, aluOp, data1, data2reg, data2ext, mux, result, zero);
	input clk, mux;
	input signed [3:0] aluOp;  //op code 4 bits
	input signed [31:0] data1, data2reg, data2ext; //data in register 32 bit
	output wire [31:0] result; // 32 bit results
	
	reg [31:0] data2; //32 bit data
	reg [31:0] out; //32 bit output
	output reg zero;

	always @ (posedge clk) begin
		#40
		if (mux == 1) begin
			data2 = data2ext;
		end else begin
			data2 = data2reg;
		end
	end

	always @ (posedge clk) begin
		#41
		case(aluOp)
			4'b0000 : // AND op code
				begin
					out = data1 & data2;
					$display("ALU: AND op: %h", out);
				end
			4'b0001 : // OR op code
				begin
					out = data1 | data2;
					$display("ALU: OR op: %h", out);
				end
			4'b0010 : // add op code
				begin
					out = data1 + data2; 
					$display("ALU: ADD op: %h + %h = %h", data1, data2, out);
				end
			4'b0110 : // subtract op code
				begin
					out = data1 - data2; 
					$display("ALU: SUB op: %h - %h = %h", data1, data2, out);
				end
			default :
				begin
					out = 32'h1;
					$display("ALU: UNKOWN Op");
				end
		endcase
	end

	always @ (out) begin
		if(out == 0) begin
			zero = 1;
		end else begin
			zero = 0;
		end
	end

	assign result = out; //setting out to result for output

endmodule

/* *******************************************************
// ***************** alu testbench for testing/debugging
// *******************************************************
module alu_tb();

	reg clk_tb, mux_tb;
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

	alu alu_t(clk_tb, aluOp_tb, data1_tb, data2reg_tb, data2ext_tb, mux_tb, result_tb, zero_tb);


endmodule

*/
