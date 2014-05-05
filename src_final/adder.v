/*
  This module is an adder of two inputs that are 32 bits (a,b) that are in Hex format and adds them together.
*/

module adder(a, b, sum);
 
  input  [31:0] a;     // 32bit a input
	input [31:0] b;     // 32bit b input
	output [31:0] sum;   // 32bit sum output
  reg [31:0] result;  //32bit register for storing
	
  always @ (*) 
  begin
    result = a + b; // calculates the addition of a and b
  end

  assign sum = result; //assigns the result to the returned sum value

endmodule // add32

/* **********************************************
// ***************** adder testbench for testing
// **********************************************
module adder_tb;

  reg [31:0] a_tb;
  reg [31:0] b_tb;
  wire [31:0] sum_tb;

  initial 
  begin
    $display("Adder Testbench");
    a_tb = 32'hFFFFFFFF;
    b_tb = 32'h0007;
    
    #100
    $display("Add: %h + %h = %h", a_tb, b_tb, sum_tb);
    
    $finish;
  end

  adder adder_tb(a_tb, b_tb, sum_tb);

endmodule
*/