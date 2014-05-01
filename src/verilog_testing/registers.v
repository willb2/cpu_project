

module registers(clk, readReg1, readReg2, writeReg, readData1, readData2, writeData); 
	input clk;
	input [4:0] readReg1, readReg2, writeReg;
	input [31:0] writeData;
	output reg [31:0] readData1, readData2;

	reg [31:0] reggies [0:31];
	
	initial reggies[0] = 0;

	always@(posedge clk) begin
		readData1 = reggies[readReg1];
		readData2 = reggies[readReg2];
	end
		
	always@(negedge clk) begin  // Maybe use back end of clock cycle (falling edge)
		if(writeReg != 0)
			reggies[writeReg] = writeData;
	end


endmodule


module registers_tb();
	reg clk_tb;
	reg [4:0] readReg1_tb, readReg2_tb, writeReg_tb;
	reg [31:0] writeData_tb;
	wire [31:0] readData1_tb, readData2_tb;

	initial 
	begin
		$display("Registers Testbench");
		// Set parameters
		clk_tb =1'b0;
		readReg1_tb = 5'h00;
		readReg2_tb = 5'h02;
		writeReg_tb = 5'h02;
		writeData_tb = 32'hF0F0;
		#1
		clk_tb =1'b1;
		#2
		$display("register %h has data %h", readReg1_tb, readData1_tb);
		$display("register %h has data %h", readReg2_tb, readData2_tb);
		writeData_tb = 32'hFFFF;
		#3
		clk_tb =1'b0; // Data latched to writeReg
		#4
		clk_tb =1'b1; // Data outputted from writeReg
		#5
		$display("register %h has data %h", readReg2_tb, readData2_tb);
		

		$finish;
	end

	registers reg_t(clk_tb, readReg1_tb, readReg2_tb, writeReg_tb, readData1_tb, readData2_tb, writeData_tb);

endmodule
