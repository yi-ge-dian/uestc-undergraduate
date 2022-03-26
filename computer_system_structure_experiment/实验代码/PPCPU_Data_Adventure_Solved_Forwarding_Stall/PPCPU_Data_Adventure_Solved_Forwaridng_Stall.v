`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:33:59 05/14/2019 
// Design Name: 
// Module Name:    SCCPU 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module PPCPU_Data_Adventure_Solved_Forwading_Stall(Clock, Resetn, PC,ID_INST,IF_INST,EXE_ALU,MEM_ALU,WB_ALU,stall,pcsource
    );
	 input Clock, Resetn;
	 output [31:0] PC;
	 output [31:0] ID_INST,IF_INST;
	 output [31:0] EXE_ALU,MEM_ALU,WB_ALU;
	 output stall;
	 output [1:0] pcsource;
	 
	 
	 wire [31:0] bpc, jpc;  
	 wire [31:0] wdi;
	 wire z;
	 
	 //IF
	 wire [31:0] if_pc4,if_inst;
	 //ID
	 wire [31:0] id_pc4,id_inst,id_imm,id_wreg;
	 wire id_m2reg, id_wmem, id_aluimm,id_shift;
	 wire [2:0] id_aluc;
	 wire [4:0] id_rn;
	 //EXE
	 wire [31:0] exe_ra,exe_rb,exe_imm,exe_Alu_Result;
	 wire exe_m2reg,exe_wmem,exe_aluimm,exe_shift,exe_wreg;
	 wire [2:0] exe_aluc;
	 wire [4:0] exe_rn;
	 //MEM
	 wire [31:0] mem_Alu_Result,mem_rb,mem_mo;
	 wire mem_wmem,mem_wreg;
	 wire [4:0] mem_rn;
	 //WB
	 wire [31:0] wb_Alu_Result,wb_mo,wb_wreg;
	 wire wb_m2reg;
	 wire [4:0] wb_rn;

	 
	 	 
	/*----------------------------	forwarding--------------------------*/
	 wire[1:0] FwdA,FwdB;//��·ѡ���������ź�
	 wire [4:0] rs,rt;
	 wire [31:0] id_ra_org,id_rb_org;//ID�Ĵ���ȡ����ra,rb
	 wire [31:0] id_ra, id_rb;//ID�����������
	 
	 assign FwdA =((exe_rn != 5'b0) & exe_wreg & (exe_rn == rs) & ~exe_m2reg) ? 2'b01 : // ѡ exe_Alu
                 ((mem_rn != 5'b0) & mem_wreg & (mem_rn == rs) & ~mem_m2reg) ? 2'b10 : // ѡ mem_Alu
                 ((mem_rn != 5'b0) & mem_wreg & (mem_rn == rs) &  mem_m2reg) ? 2'b11 : 2'b00;  // 2'b11 ѡmem_mo(load)��2b'00 
	 assign FwdB =((exe_rn != 5'b0) & exe_wreg & (exe_rn == rt) & ~exe_m2reg) ? 2'b01 : // ѡ exe_Alu
                 ((mem_rn != 5'b0) & mem_wreg & (mem_rn == rt) & ~mem_m2reg) ? 2'b10 : // ѡ mem_Alu
                 ((mem_rn != 5'b0) & mem_wreg & (mem_rn == rt) &  mem_m2reg) ? 2'b11 : 2'b00;  // 2'b11 ѡmem_mo(load)��2b'00 
	/*-----------------------------------------------------------------*/
	
	

	 /*------------------------forwarding+stall--------------------------*/
	 wire id_wreg_org,id_wmem_org;
	 wire regrt;
	 //detect adventure
	 assign stall= ((rs == exe_rn) | (rt == exe_rn) & ~regrt)&(exe_rn !=0)&(exe_wreg & exe_m2reg);
	 //
	 assign id_wreg = ~stall & id_wreg_org;
	 assign id_wmem = ~stall & id_wmem_org;
	/*-----------------------------------------------------------------*/
	 
	 
	 
	 //IF
	 IF_STAGE stage1 (Clock, Resetn, pcsource, bpc, jpc, if_pc4, if_inst,PC,stall);
	 //IF_ID
	 IF_ID  if_id(if_pc4,if_inst,Clock,Resetn,id_pc4,id_inst,stall);	 
	 //ID
	 ID_STAGE stage2 (id_pc4, id_inst, wdi, ~Clock, Resetn, bpc, jpc, pcsource,
				         id_m2reg, id_wmem_org, id_aluc, id_aluimm, id_ra_org, id_rb_org, id_imm, id_shift, z,id_wreg_org,wb_wreg,id_rn,wb_rn,regrt,rs,rt);
		
	 //forwarding  mux32-4-1
	 mux32_4_1 fwd_a(id_ra_org,exe_Alu_Result,mem_Alu_Result,mem_mo,FwdA,id_ra);
	 mux32_4_1 fwd_b(id_rb_org,exe_Alu_Result,mem_Alu_Result,mem_mo,FwdB,id_rb);
		
	 //ID_EXE		
	 ID_EXE id_exe(id_m2reg, id_wmem, id_aluc, id_aluimm, id_ra, id_rb, id_imm, id_shift,id_wreg,id_rn,
			         Clock,Resetn,exe_m2reg, exe_wmem, exe_aluc, exe_aluimm, exe_ra, exe_rb, exe_imm, exe_shift,exe_wreg,exe_rn);
    //EXE						
	 EXE_STAGE stage3 (exe_aluc, exe_aluimm, exe_ra,exe_rb, exe_imm, exe_shift, exe_Alu_Result, z); 
	 //EXE_MEM
	 EXE_MEM exe_mem(exe_Alu_Result,exe_rb,exe_wmem,exe_m2reg,exe_wreg,exe_rn,
					     Clock,Resetn,mem_Alu_Result,mem_rb,mem_wmem,mem_m2reg,mem_wreg,mem_rn);
	 //MEM
	 MEM_STAGE stage4 (mem_wmem, mem_Alu_Result[4:0], mem_rb, Clock, mem_mo);
	 //MEM_WB
	 MEM_WB mem_wb(mem_Alu_Result,mem_m2reg,mem_wreg,mem_rn,mem_mo,
					   Clock,Resetn,wb_Alu_Result,wb_m2reg,wb_wreg,wb_rn,wb_mo);
    //WB						
	 WB_STAGE stage5 (wb_Alu_Result,wb_mo, wb_m2reg, wdi);
	 
	 assign ID_INST=id_inst;
	 assign IF_INST=if_inst;
	 assign EXE_ALU=exe_Alu_Result;
	 assign MEM_ALU=mem_Alu_Result;
	 assign WB_ALU=wb_Alu_Result;
	 

endmodule
