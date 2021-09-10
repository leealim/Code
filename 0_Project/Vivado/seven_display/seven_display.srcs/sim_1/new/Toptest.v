`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/09/08 22:38:37
// Design Name: 
// Module Name: Toptest
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


module Toptest();
    reg   clk;
    reg   rstn;
    reg plus;
    reg minus;
    reg comfirm;
    reg [7:0] switch;
    sevenTop st(
        .clk(clk),
        .rstn(rstn),
        
        .I_plus(plus),
        .I_minus(minus),
        .I_comfirm(comfirm),
        .I_switch(switch),
        
        .O_led_A(),
        .O_px_A(),
        .O_led_B(),
        .O_px_B()
    );
    reg plus;
    reg minus;
    reg comfirm;
    reg [7:0] switch;
    initial
  begin
    clk = 1'b0;
    rstn = 1'b0;
    plus=0;
    minus=0;
    comfirm=0;
    switch=8'b10000000;
    #10
    rstn = 1'b1;
    #10
    comfirm=1;
    #10
    comfirm=0;
    #10
    minus=1;
    #10
    minus=0;
    #10
    switch=8'b00000000;
    #10
    comfirm=1;
    #10
    comfirm=0;
    #500
    rstn = 1'b0;
  end  
  //在执行完initial后开始进行always循环
  always
  begin
    #5 clk = ~clk;
  end  
endmodule
