`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/09/04 20:35:11
// Design Name: 
// Module Name: Register
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


module Register(
    input I_clk  ,
    input I_rstn  ,
    input [4:0] I_read_addr_1  ,
    input [4:0] I_read_addr_2  ,
    input I_we  ,
    input [4:0]I_write_addr  ,
    input [31:0]I_write_data  ,
    output [31:0]O_read_data_1  ,
    output [31:0]O_read_data_2 
    );
    
    reg [31:0] regs[31:0];
    
    assign O_read_data_1=regs[I_read_addr_1];
    assign O_read_data_2=regs[I_read_addr_2];
    
    integer i=0;
    always@(posedge I_clk or negedge I_rstn or posedge I_we)begin
        if(!I_rstn) begin
            for(i=0;i<=31;i=i+1) begin
				regs[i] <= 32'b0;
		     end
        end
        else if(I_we) regs[I_write_addr]<=I_write_data;
    end
endmodule
