/*
  Should inputs be signed?
*/

module adder(a, b, sum);
 
  input  [31:0] a;     // a input
	input [31:0] b;     // b input
	output [31:0] sum;   // sum output
  reg [31:0] result;
	
  always @ (*) 
  begin
    result = a + b;
  end

  assign sum = result;

endmodule // add32

/*
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