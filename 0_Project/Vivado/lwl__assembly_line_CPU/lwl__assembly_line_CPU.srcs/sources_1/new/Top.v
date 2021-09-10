`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/08/31 13:08:20
// Design Name: 
// Module Name: Top
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


module Top(
        input clk,
        input rstn
    );
    wire C_dataRelated;
    
    wire [31:0] inst_addr;

    wire C_jump_d,C_borj_d;
    wire [31:0] imme_d;
    wire [31:0] pcPlus4_d;
    wire [31:0] rsd_d;
    wire [31:0] rtd_d;
    wire [31:0] inst_d;
    
    wire [31:0] pc_update;
    PCupdate pcu(
        .I_clk          (clk        ), 
        .I_rstn         (rstn       ),
        .I_borj         (C_borj_d   ),
        .I_jump         (C_jump_d   ),
        .I_rsd          (rsd_d      ),
        .I_rtd          (rtd_d      ),
        .I_imme         (imme_d     ),
        .I_pcPlus4_d    (pcPlus4_d  ),
        .I_pcPlus4_f    (inst_addr+4),
        .I_inst         (inst_d     ),
        
        .O_pc_update    (pc_update  )
    );
    
    PC pc(
        .I_clk          (clk        ), 
        .I_rstn         (rstn       ), 
        .I_C_dataRelated(C_dataRelated),
        .I_pc_update    (pc_update  ),
        
        .O_pc_out       (inst_addr  )
    );

    wire [31:0] inst_f; 
    InstructionMemory im(
        .I_clk          (clk        ), 
        .I_rstn         (rstn       ), 
        .I_inst_addr    (inst_addr  ),
        
        .O_inst_out     (inst_f     )
    );

    IFID ifid(
        .I_clk          (clk        ), 
        .I_rstn         (rstn       ),
        .I_C_dataRelated(C_dataRelated),
        .I_inst         (inst_f     ),
        .I_pcPlus4      (inst_addr+4),
        
        .O_inst         (inst_d     ),
        .O_pcPlus4      (pcPlus4_d  )
        );
    
    
    SignedExtend se(
        .I_clk          (clk        ), 
        .I_rstn         (rstn       ),
        .I_imm          (inst_d[15:0]   ),//imm
        
        .O_imm_e        (imme_d       )
        );//Á¢¼´ÊýÀ©Õ¹
    
    
    wire C_RegWriteData_w,C_RegsWe_w;
    wire [4:0] addr_regs_write_w;
    wire [31:0] dm_data_w;
    wire [31:0] resALU_w;
    Register regs(
        .I_clk          (clk        ), 
        .I_rstn         (rstn       ),
        .I_read_addr_1  (inst_d[25:21]  ),//rs                  
        .I_read_addr_2  (inst_d[20:16]  ),//rt         
        .I_we           (C_RegsWe_w),
        .I_write_addr   (addr_regs_write_w),
        .I_write_data   (C_RegWriteData_w?dm_data_w:resALU_w),
        
        .O_read_data_1  (rsd_d),          
        .O_read_data_2  (rtd_d)        
        );
    wire [1:0] C_ifsltsub_d;
    wire [7:0]     C_ALUop_d;
    wire C_RegWriteAddr_d,C_RegWriteData_d,C_ifluisll_d,C_RegsWe_d,C_DataMemWe_d,C_ALUsrcB_d,C_ALUsrcA_d;     
    Control ctrl(
        .I_clk          (clk        ), 
        .I_rstn         (rstn       ),
        .I_opcode       (inst_d[31:26]  ),//opcode
        .I_func         (inst_d[5:0]    ),//func
        
        .O_ALUsrcA       (C_ALUsrcA_d     ),
        .O_ALUsrcB       (C_ALUsrcB_d     ),
        .O_ALUop        (C_ALUop_d      ),
        .O_DataMemWe    (C_DataMemWe_d  ),
        .O_RegsWe       (C_RegsWe_d     ),
        .O_RegWriteData (C_RegWriteData_d   ),
        .O_RegWriteAddr (C_RegWriteAddr_d   ),
        .O_jump         (C_jump_d       ),
        .O_borj         (C_borj_d       ),
        .O_ifsltsub     (C_ifsltsub_d   )
        );
    
    wire [31:0] rsd_e;
    wire [31:0] rtd_e;  
    wire [31:0] imme_e;
    wire [4:0] rd_e;
    wire [4:0] rt_e;
    wire [7:0] C_ALUop_e;
    wire [1:0] C_ifsltsub_e;
    wire C_RegWriteAddr_e,C_RegWriteData_e,C_RegsWe_e,C_ifluisll_e,C_DataMemWe_e,C_ALUsrcB_e,C_ALUsrcA_e;
    IDEX idex(
        .I_clk          (clk        ), 
        .I_rstn         (rstn       ),
        .I_C_dataRelated(C_dataRelated),
        .I_regiterData1 (rsd_d      ),
        .I_regiterData2 (rtd_d      ),
        .I_imm_extend   (imme_d     ),
        .I_rd           (inst_d[15:11]  ),
        .I_rt           (inst_d[20:16]  ),
        .I_C_ALUsrcA     (C_ALUsrcA_d ),
        .I_C_ALUsrcB     (C_ALUsrcB_d ),
        .I_C_ALUop      (C_ALUop_d  ),
        .I_DataMemWe    (C_DataMemWe_d  ),
        .I_RegsWe       (C_RegsWe_d     ),
        .I_RegWriteData (C_RegWriteData_d   ),
        .I_RegWriteAddr (C_RegWriteAddr_d   ),
        .I_C_ifsltsub   (C_ifsltsub_d       ),
        
        .O_regiterData1 (rsd_e      ),
        .O_regiterData2 (rtd_e      ),
        .O_imm_extend   (imme_e     ),
        .O_rd           (rd_e      ),
        .O_rt           (rt_e      ),
        .O_C_ALUsrcA     (C_ALUsrcA_e ),
        .O_C_ALUsrcB     (C_ALUsrcB_e ),
        .O_C_ALUop      (C_ALUop_e  ),
        .O_DataMemWe    (C_DataMemWe_e  ),
        .O_RegsWe       (C_RegsWe_e     ),
        .O_RegWriteData (C_RegWriteData_e   ),
        .O_RegWriteAddr (C_RegWriteAddr_e   ),
        .O_C_ifsltsub   (C_ifsltsub_e       )
        );
    
    wire [31:0] resALU_e;
    ALU alu(
        .I_clk          (clk        ), 
        .I_rstn         (rstn       ),
        .I_A            ((C_ALUsrcA_e)?imme_e:rsd_e),
        .I_B            ((C_ALUsrcB_e)?imme_e:rtd_e),                    
        .I_op           (C_ALUop_e    ),
                            
        .O_C            (resALU_e   )          
        );
    
    wire [31:0] resALU_m;
    wire C_RegWriteData_m,C_RegsWe_m,C_DataMemWe_m;
    wire [4:0] addr_regs_write_m;
    wire [31:0] data_dataMem_m;
    EXMEM exmem(
        .I_clk          (clk        ), 
        .I_rstn         (rstn       ),
        .I_addr_dataMem (C_ifsltsub_e==1?{31'b0, resALU_e[31]}:C_ifsltsub_e==2?{imme_e[15:0], 16'b0}:resALU_e   ),
        .I_data_dataMem (rtd_e      ),
        .I_addr_regs_write  (C_RegWriteAddr_e?rd_e:rt_e ),
        .I_DataMemWe    (C_DataMemWe_e  ),
        .I_RegsWe       (C_RegsWe_e    ),
        .I_RegWriteData (C_RegWriteData_e   ), 

        .O_addr_dataMem (resALU_m   ),
        .O_data_dataMem (data_dataMem_m  ),
        .O_addr_regs_write  (addr_regs_write_m  ),
        .O_DataMemWe    (C_DataMemWe_m  ),
        .O_RegsWe       (C_RegsWe_m     ),
        .O_RegWriteData (C_RegWriteData_m   )
        );
    
    wire [31:0] dm_data_m;
    DataMemory dm(
        .I_clk          (clk        ), 
        .I_rstn         (rstn       ),
        .I_we           (C_DataMemWe_m),
        .I_address      (resALU_m   ),
        .I_write_data   (data_dataMem_m),
        
        .O_read_data    (dm_data_m  )         
        );
    
    MEMWB memwb(
        .I_clk          (clk        ), 
        .I_rstn         (rstn       ),
        .I_resALU       (resALU_m   ),
        .I_dm_data      (dm_data_m  ), 
        .I_addr_regs_write  (addr_regs_write_m  ),
        .I_RegsWe       (C_RegsWe_m     ),
        .I_RegWriteData (C_RegWriteData_m   ),
        
        
        .O_resALU       (resALU_w   ),
        .O_dm_data      (dm_data_w  ),
        .O_addr_regs_write  (addr_regs_write_w  ),
        .O_RegsWe       (C_RegsWe_w     ),
        .O_RegWriteData (C_RegWriteData_w   )
        );
        
    DataRelated dr(
        .I_clk          (clk        ), 
        .I_rstn         (rstn       ),
        .I_reg_write_addr_e (C_RegWriteAddr_e?rd_e:rt_e ),
        .I_reg_write_addr_m (addr_regs_write_m  ),
        .I_reg_write_addr_w (addr_regs_write_w)  ,
        .I_RegsWe_e       (C_RegsWe_e    ),
        .I_RegsWe_m       (C_RegsWe_m     ),
        .I_RegsWe_w       (C_RegsWe_w), 
        .I_ALUsrcA       (C_ALUsrcA_d     ),
        .I_ALUsrcB       (C_ALUsrcB_d     ), 
        .I_read_addr_1  (inst_d[25:21]  ),//rs                  
        .I_read_addr_2  (inst_d[20:16]  ),//rt 
        
        .O_if_dr_Stop   (C_dataRelated)
        );
endmodule
