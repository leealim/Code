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
        );//���ָ��λ��inst_addr
        
    InstructionFile inst_file(
        clk,rstn,
        inst_addr,
        inst
    );//���ָ��inst
    
    Imm_extend immextend(
        clk,rstn,
        inst[15:0],
        imm,
        imm_extenc_c
        );//��������չ
        
    Control ctrl(
        clk,rstn,
        opcd,
        func,
        
        regwe,  //�Ĵ���дʹ��
        rwdc,   //�Ĵ���д����
        op,     //alu����ѡ��
        rwac,   //�Ĵ���дλ��
        aluopc, //alu������ѡ��
        memwe,  //���ݴ洢��дʹ��
        pc_c,   //��ת����
        imm_extenc_c    //��������չѡ��
        );//����ģ��
    
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
        );//ALUģ��
    
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
        );//�Ĵ���
endmodule
