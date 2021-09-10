`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/09/04 20:35:11
// Design Name: 
// Module Name: PC
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


module PC(
    input I_clk  ,
    input I_rstn  ,
    input I_C_dataRelated,
    input [31:0]I_pc_update  ,
    output [31:0]O_pc_out
    );
    
    reg [31:0] pc_value;
    
    always@(posedge I_clk or negedge I_rstn) begin
        if(!I_rstn)pc_value <= 32'b0;
        else if(!I_C_dataRelated)pc_value <= I_pc_update;
    end
    
    assign O_pc_out=pc_value;
    
endmodule
