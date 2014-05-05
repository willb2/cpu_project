/*

*/


module registers(clk, readReg1, readReg2, writeReg, readData1, readData2, writeDataALU, writeDataMem, memToReg, regWrite, regDst); 
	input clk, memToReg, regWrite, regDst;
	input [4:0] readReg1, readReg2, writeReg;
	input [31:0] writeDataALU, writeDataMem;
	output reg [31:0] readData1, readData2;

	reg [31:0] reggies [0:31];
	reg [31:0] writeData;

	initial reggies[0] = 0;

	always @ (posedge clk) begin
		#30
		readData1 = reggies[readReg1];
		readData2 = reggies[readReg2];
		$display("REG Inputs: readReg1 %h, readReg2 %h, writeReg %h", readReg1, readReg2, writeReg);
	end

		
	always @ (negedge clk) begin  // Maybe use back end of clock cycle (falling edge)
		if(regWrite == 1) begin
			if (regDst == 1) begin
				if (writeReg != 0) begin
					if(memToReg == 1) begin
						reggies[writeReg] = writeDataMem;
						$display("REG: Data %h written from Mem to Reg %h", writeDataMem, writeReg);
					end else begin
						reggies[writeReg] = writeDataALU;
						$display("REG: Data %h written from ALU to Reg %h", writeDataALU, writeReg);						
					end
				end else begin
					$display("REG: CANNOT WRITE TO ZERO REG");
				end
			end else begin
				if (readReg2 != 0) begin
					if(memToReg == 1) begin
						reggies[readReg2] = writeDataMem;
						$display("REG: Data %h written from Mem to Reg %h", writeDataMem, readReg2);
					end else begin
						reggies[readReg2] = writeDataALU;
						$display("REG: Data %h written from ALU to Reg %h", writeDataALU, readReg2);
					end
				end else begin
					$display("REG: CANNOT WRITE TO ZERO REG");
				end
			end
		end
	end

endmodule

/* ************************************************************
// ***************** registers testbench for testing/debugging
// ************************************************************
module registers_tb();
	reg clk_tb, memToReg_tb, regWrite_tb, regDst_tb;
	reg [4:0] readReg1_tb, readReg2_tb, writeReg_tb; //5 bit read/write registers
	reg [31:0] writeDataMem_tb, writeDataALU_tb; //32bit mem write
	wire [31:0] readData1_tb, readData2_tb; //32bit mem read

	initial 
	begin
		$display("Registers Testbench");
		// declare and initialize parameters
		clk_tb =1'b0; //1 bit binary
		memToReg_tb = 1'b0; //1 bit binary
		readReg1_tb = 5'h00; //5 bit hex
		readReg2_tb = 5'h02; //5 bit hex
		writeReg_tb = 5'h02; //5 bit hex
		writeDataMem_tb = 32'hF0F0; //32bit hex
		regDst_tb = 1;
		regWrite_tb = 1;

		#1
		clk_tb =1'b1;
		#2
		$display("register %h has data %h", readReg1_tb, readData1_tb);
		$display("register %h has data %h", readReg2_tb, readData2_tb);
		writeDataMem_tb = 32'hFFFF;
		#3
		clk_tb =1'b0; // Data latched to writeReg
		#4
		clk_tb =1'b1; // Data outputted from writeReg
		#5
		$display("register %h has data %h", readReg2_tb, readData2_tb);
		

		$finish;
	end

	registers reg_t(clk_tb, readReg1_tb, readReg2_tb, writeReg_tb, readData1_tb, readData2_tb, writeDataALU_tb, writeDataMem_tb, memToReg_tb, regWrite_tb, regDst_tb);

endmodule
*/