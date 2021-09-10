`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/08/25 15:07:16
// Design Name: 
// Module Name: register
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


module register(
        input         clk,
        input         rstn,

        input   [4:0] reg1Addr,
        output [31:0] reg1Data,
        input   [4:0] reg2Addr,
        output [31:0] reg2Data,
        
        input         writeEnable,       //write enable, HIGH valid
        input  [ 4:0] writeAddr,
        input  [31:0] writeData
    );
    
    reg [31:0] regs[31:0];
    integer i;
    assign reg1Data=regs[reg1Addr];
    assign reg2Data=regs[reg2Addr];
    always@(posedge clk or negedge rstn or posedge writeEnable)begin
        if(!rstn) begin
            for(i=0;i<=31;i=i+1) begin
				regs[i] <= 32'b0;
		     end
        end
        else if(writeEnable) regs[writeAddr]<=writeData;
    end
endmodule
