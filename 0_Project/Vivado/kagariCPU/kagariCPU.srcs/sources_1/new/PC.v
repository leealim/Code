`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/08/26 21:48:27
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
        input         clk,
        input         rstn,
    
        output  [31:0] pco,
        
        input [31:0] a,
        input [31:0] b,
        input [15:0] imm_i,
        input [25:0] imm_b,
        input [1:0] pc_c
    );
    
    reg [31:0] pc_value;
    
    wire[31:0] pc_add=pc_value+4;
    
    always@(posedge clk or negedge rstn) begin
        if(!rstn)pc_value <= 32'hbfc00000;
        else if(pc_c==1&&a==b) pc_value <= pc_add + (imm_i << 2);
        else if(pc_c==2) pc_value <= {pc_add[31:28], imm_b[25:0], 2'b00};
        else pc_value <= pc_add;
    end
    
    assign pco=pc_value;
    
endmodule