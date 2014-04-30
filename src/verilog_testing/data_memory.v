/*
	What is the address size?
*/

module data_memory(memRead, memWrite, address, dataIn, dataOut);
	input memRead, memWrite;
	input [31:0] address, dataIn;
	output reg [31:0] dataOut;

	reg [31:0] Mem [0:200]; // 201 32-bit words

	//initial $readmemh("data_memory.txt", mem);
	
	always@(memRead)
		if(memRead)
			dataOut = Mem[address];

	always @(memWrite)
		if(memWrite)
			Mem[address] = dataIn;

endmodule


module data_memory_tb();
	reg memRead_tb;
	reg memWrite_tb;
	reg [31:0] address_tb;
	reg [31:0] dataIn_tb;
	wire [31:0] dataOut_tb;

	initial 
	begin
		$display("Data Memory Testbench");
		// Set parameters
		memRead_tb = 1'b0;
		memWrite_tb = 1'b0;
		address_tb = 32'h0001;
		dataIn_tb = 32'hF0F0;

		memWrite_tb = 1'b1;
		#100
		$display("writing %h to address %h", dataIn_tb, address_tb);
		memWrite_tb = 1'b0;

		address_tb = 32'h0002;
		dataIn_tb = 32'h1111;
		memWrite_tb = 1'b1;
		#100
		$display("writing %h to address %h", dataIn_tb, address_tb);
		memWrite_tb = 1'b0;

		address_tb = 32'h0001;
		memRead_tb = 1'b1;
		#100
		$display("retrieved %h from address %h", dataOut_tb, address_tb);
		memRead_tb = 1'b0;

		$finish;
	end

	data_memory datamem_t(memRead_tb, memWrite_tb, address_tb, dataIn_tb, dataOut_tb);

endmodule


