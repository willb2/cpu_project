/*
Random Access Memory used to store and retrieve program data. What is the address size?
*/

module data_memory(clk, memRead, memWrite, address, dataIn, dataOut);
	input clk, memRead, memWrite;
	input [31:0] address, dataIn; //32 bit input
	output reg [31:0] dataOut; //32bit output

	reg [31:0] Mem [0:3]; //4 32-bit words

	initial $readmemh("data.txt", Mem); //reads data from data.txt and puts in Mem

	always@(posedge clk) begin
		#50
		if(memRead) begin //tests that data.txt was not empty
			dataOut = Mem[address];
			$display("DMEM: output set to %h from address %h", Mem[address], address);
		end
	end

	always @(negedge clk) begin
		if(memWrite) begin
			Mem[address] = dataIn;
			$display("DMEM: captured data %h at address %h", dataIn, address);
		end
	end

endmodule

/* *******************************************************
// ***************** data_memory testbench for testing/debugging
// *******************************************************
module data_memory_tb();
	reg clk_tb;
	reg memRead_tb;
	reg memWrite_tb;
	reg [31:0] address_tb;
	reg [31:0] dataIn_tb;
	wire [31:0] dataOut_tb;

	initial 
	begin
		$display("Data Memory Testbench");
		// Set parameters
		clk_tb = 0;
		memRead_tb = 1'b0;
		memWrite_tb = 1'b0;
		address_tb = 32'h0001;
		dataIn_tb = 32'hF0F0;

		// Check that memory has been initialized with data
		address_tb = 32'h0000;
		clk_tb = 1;
		#1
		memRead_tb = 1'b1;
		#2
		//#100
		$display("Initialization check: retrieved %h from address %h", dataOut_tb, address_tb);
		memRead_tb = 1'b0;

		clk_tb = 0;
		#1
		clk_tb = 1;

		//
		memWrite_tb = 1'b1;
		#100
		$display("writing %h to address %h", dataIn_tb, address_tb);
		memWrite_tb = 1'b0;

		clk_tb = 0;
		#1
		clk_tb = 1;

		address_tb = 32'h0002;
		dataIn_tb = 32'h1111;
		memWrite_tb = 1'b1;
		#100
		$display("writing %h to address %h", dataIn_tb, address_tb);
		memWrite_tb = 1'b0;

		clk_tb = 0;
		#1
		clk_tb = 1;

		address_tb = 32'h0001;
		memRead_tb = 1'b1;
		#100
		$display("retrieved %h from address %h", dataOut_tb, address_tb);
		memRead_tb = 1'b0;

		$finish;
	end

	data_memory datamem_t(clk_tb, memRead_tb, memWrite_tb, address_tb, dataIn_tb, dataOut_tb);

endmodule


*/