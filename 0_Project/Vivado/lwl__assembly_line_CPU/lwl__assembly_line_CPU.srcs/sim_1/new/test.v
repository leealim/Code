`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/09/06 23:02:54
// Design Name: 
// Module Name: test
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module test();
  reg   clk;
  reg   nrst;  
Top t(
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
  //在执行完initial后开始进行always循环
  always
  begin
    #5 clk = ~clk;
  end  
endmodule