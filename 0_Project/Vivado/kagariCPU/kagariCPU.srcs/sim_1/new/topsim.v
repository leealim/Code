`timescale 1ns/1ps
module tx_1();
  reg   clk;
  reg   nrst;  
  // Instantiate the Unit Under Test (UUT)
CPUtop topcpu(
        clk,nrst
    );
  initial
  begin
    clk = 1'b0;
    nrst = 1'b0;
    #10
    nrst = 1'b1;
    #500
    nrst = 1'b0;
  end  
  //��ִ����initial��ʼ����alwaysѭ��
  always
  begin
    #5 clk = ~clk;
  end  
endmodule