`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/08/28 16:10:38
// Design Name: 
// Module Name: CPUtop
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


module CPUtop(
        input         clk,
        input         rstn
    );
      
    wire [31:0] inst_addr;
    wire [31:0] inst;
   
    wire [31:0] imm; 
    wire imm_extenc_c;
    
    wire [5:0] opcd;
    wire [5:0] func;
    wire [4:0] rs;
    wire [4:0] rt;
    wire [4:0] rd;
    assign  rs=inst[25:21],
            rt=inst[20:16],
            rd=inst[15:11],
            opcd=inst[31:26],
            func=inst[5:0];
            
    //register
    wire [31:0] regnum1;
    wire [31:0] regnum2;
    wire [1:0] pc_c;
    
    
    //ALU
    wire [31:0] result;
    
    //Control
    wire regwe;
    wire [1:0] op;
    wire [1:0]rwdc;
    wire [1:0]rwac;
    wire aluopc,imm_extenc_c;
    
    
    wire memwe;
    wire [31:0] readData;
   
    
    PC pc(
        clk,rstn,
        inst_addr,//output:pc_value
        regnum1,
        regnum2,
        inst[15:0],
        inst[25:0],
        pc_c
        );//获得指令位置inst_addr
        
    InstructionFile inst_file(
        clk,rstn,
        inst_addr,
        inst
    );//获得指令inst
    
    Imm_extend immextend(
        clk,rstn,
        inst[15:0],
        imm,
        imm_extenc_c
        );//立即数扩展
        
    Control ctrl(
        clk,rstn,
        opcd,
        func,
        
        regwe,  //寄存器写使能
        rwdc,   //寄存器写数据
        op,     //alu操作选择
        rwac,   //寄存器写位置
        aluopc, //alu操作数选择
        memwe,  //数据存储器写使能
        pc_c,   //跳转控制
        imm_extenc_c    //立即数扩展选择
        );//控制模块
    
    DataFile datafile(
        clk,rstn,
        memwe,
        result,     //address
        readData,   //output: readdata
        regnum2           //writedata
        );
   
    ALU alu(
        clk,rstn,
        (aluopc==1)?regnum2:imm,    //A
        regnum1,                    //B
        op,                         //op
        result                      //output:C
        );//ALU模块
    
    register re(
        clk,rstn,
        rs,                         //ra1
        regnum1,                    //output:rd1
        rt,                         //ra2
        regnum2,                    //output:rd2
        regwe,                      //we
        (rwac==1)?rd:rt,            //wa
        (rwdc==1)?result:
            (rwdc==2)?readData:imm        //wd
        );//寄存器
endmodule
