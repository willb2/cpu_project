
module   full_adder_32bit( cin, cout, in_a, in_b,  sum
);   
    parameter   reg_size = 31;   
    input   cin;
    input   [reg_size:0] in_a;
    input   [reg_size:0] in_b;
    output  [reg_size:0] sum;
    output  cout;   
    assign   {cout,sum} = in_a + in_b + cin;

 // initial begin
    //sum = 8'hf0;
    //$display("sum : %d", sum);
//end


endmodule
//






