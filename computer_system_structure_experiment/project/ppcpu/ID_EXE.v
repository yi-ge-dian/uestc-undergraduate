`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:02:31 05/12/2021 
// Design Name: 
// Module Name:    id_exe 
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
module ID_EXE(id_m2reg, id_wmem, id_aluc, id_aluimm, id_ra, id_rb, id_imm, id_shift,id_wreg,id_rn,
					clk,clrn,exe_m2reg, exe_wmem, exe_aluc, exe_aluimm, exe_ra, exe_rb, exe_imm, exe_shift,exe_wreg,exe_rn
    );
	 input id_m2reg,id_wmem,id_aluimm,id_shift,id_wreg;
	 input [2:0] id_aluc;
	 input [31:0] id_ra,id_rb,id_imm;
	 input [4:0] id_rn;
	 input clk,clrn;
	 output exe_m2reg,exe_wmem,exe_aluimm,exe_shift,exe_wreg;
	 output [2:0] exe_aluc;
	 output [31:0] exe_ra,exe_rb,exe_imm;
	 output [4:0] exe_rn;
	 
	 reg exe_m2reg,exe_wmem,exe_aluimm,exe_shift,exe_wreg;
	 reg [2:0] exe_aluc;
	 reg [31:0] exe_ra,exe_rb,exe_imm;
	 reg [4:0] exe_rn;

	 always @(posedge clk or negedge clrn)
		if(clrn==0)
			begin 
				exe_m2reg<=0;	exe_wmem<=0;
				exe_aluc<=0;	exe_aluimm<=0;
				exe_ra<=0;		exe_rb<=0;
				exe_imm<=0;		exe_shift<=0;
				exe_wreg<=0;	exe_rn<=0;
		   end
		else 
			begin 
				exe_m2reg<=id_m2reg;		exe_wmem<=id_wmem;
				exe_aluc<=id_aluc;		exe_aluimm<=id_aluimm;
				exe_ra<=id_ra;				exe_rb<=id_rb; 
				exe_imm<=id_imm;			exe_shift<=id_shift;
				exe_wreg<=id_wreg;		exe_rn<=id_rn;
			end
endmodule
