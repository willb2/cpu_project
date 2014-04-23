module adder2_tb;

  reg [31:0] counter;

  initial
    begin
      zero_32 = 32'h00000000;   // 32 bit zero
      zero    = 0;              // one bit zero
      four_32 = 32'h00000004;   // four
      clear   = 1;              // one shot clear
      clk     = 0;              // master clock
      counter = 0;              // master clock counter, raising edge
      #200 clear = 0;           // clear time finished
      forever #5000 clk = ~clk; // run clock 10ns period
    end

  initial #60000 $finish; // stop after 60 ns

  adder2 adder(zero_32, four_32, counter);

  always @(posedge clk) // to show state of registers in pipeline
    begin
      $write("at clock ");
      $write("%h", counter);
      $write("\n");         // blank line
      counter = counter+1;
    end


endmodule