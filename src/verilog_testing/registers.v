

module registers(readReg1, readReg2, writeReg, readData1, readData2, writeData);
	input [4:0] readReg1, readReg2, writeReg;
	input [31:0] writeData;
	output reg [31:0] readData1, readData2;

	reg [31:0] reggies [0:31];

	//initial $readmemh("instructions.txt", mem);
	initial reggies[0] = 0;

	/*
	initial begin
		for(k = 0; k < 32; k++) 
		begin
			reggies = 32'h0000;
		end
	end
	*/
	always@(readReg1)
		readData1 = reggies[readReg1];
	
	always@(readReg2)
		readData2 = reggies[readReg2];
	
	always@(writeReg)
		#10
		if(writeReg != 0)
			reggies[writeReg] = writeData;


endmodule


module registers_tb();
	reg [4:0] readReg1_tb, readReg2_tb, writeReg_tb;
	reg [31:0] writeData_tb;
	wire [31:0] readData1_tb, readData2_tb;

	initial 
	begin
		$display("Registers Testbench");
		// Set parameters
		readReg1_tb = 5'h00;
		readReg2_tb = 5'h02;
		writeReg_tb = 5'h00;
		writeData_tb = 32'hF0F0;

		#100
		$display("register %h has data %h", readReg1_tb, readData1_tb);



		$finish;
	end

	registers reg_t(readReg1_tb, readReg2_tb, writeReg_tb, readData1_tb, readData2_tb, writeData_tb);

endmodule
