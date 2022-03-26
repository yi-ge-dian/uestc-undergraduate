`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:58:12 09/25/2020 
// Design Name: 
// Module Name:    INST_ROM 
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
//指令存储器，存储的指令序列，(需要修改)
module INST_ROM(
	 input [31:0] addr,
	 output [31:0] Inst
    ); 
	 wire [31:0] ram [31:0];
	 
	 assign ram[5'h00]=0;    			//
	 assign ram[5'h01]=32'h3c011100;    //lui R1,0x1100;ALU=0x11000000
	 assign ram[5'h02]=32'h3c020011;    //lui R2,0x0011;ALU=0x00110000
	 
	 assign ram[5'h03]=32'h00221824;    //and R3,R1,R2; ALU=0x00000000
	 assign ram[5'h04]=32'h00221826;    //xor R3,R1,R2;	ALU=0x11110000
	 
	 assign ram[5'h05]=32'h00221820;    //add R3,R1,R2;	ALU=0x11110000

	 assign ram[5'h06]=32'hac610001;    //sw R1,1(R3) ALU=0x11110001
	 
	 assign ram[5'h07]=32'h8c640002;    //lw R4,2(R3) ALU=0x11110002
	 
	 assign ram[5'h08]=32'h10220001;    //beq R1,R2,1 ALU=R1-R2=0x10ef0000
	 
	 assign Inst=ram[addr[6:2]];		//以字节为单位进行寻址，32位指令占用4字节，PC+4指向下一条指令地址。

endmodule
