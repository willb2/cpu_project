
module counter(clk, rst, en, cout);
	input clk;
	input rst;
	input en;
	output [3:0] cout;

	wire clk;
	wire rst;
	wire en;

	reg[3:0] cout;

	always @ (posedge clk)
	begin : COUNTER
		if (rst == 1'b1) begin
			cout <= #1 4'b0000;
		end
		else if (en == 1'b1) begin
			cout <= #1 cout+1;
		end
	end

endmodule



module counter_tb();

	reg clk, rst, en;
	wire[3:0] cout;

	initial begin
		$display("time\t clk reset enable counter");
		$monitor("%g\t %b   %b     %b      %b",  $time, clk, rst, en, cout);
		clk = 1;
		rst = 0;
		en = 0;
		#5 rst = 1;
		#10 rst = 0;
		#10 en = 1;
		#100 en = 0;
		#5 $finish;
	end

	always begin
		#5 clk = ~clk;
	end

	counter t_counter(clk, rst, en, cout);

endmodule
