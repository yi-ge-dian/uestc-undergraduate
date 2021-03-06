`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:09:27 05/15/2019 
// Design Name: 
// Module Name:    Inst_ROM 
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
module Inst_ROM(a,inst
    );
	 input [5:0] a;
	 output [31:0] inst;
	 wire [31:0] rom [0:63];
	 
	//有控制冒险的流水线指令
	 
 	 assign rom[6'h00]=32'h00000000;
	 assign rom[6'h01]=32'h30001043;		//xori r3,r2,4	 
	 assign rom[6'h02]=32'h400010a6;    //bne r5,r6,offset=4,label=28
	 assign rom[6'h03]=32'h00101041;		//add r4,r2,r1    
	 assign rom[6'h04]=32'h34001045;		//load r5,4(r2)   
	 assign rom[6'h05]=32'h08211807;		//srl r6,r7,2
	 assign rom[6'h06]=32'h38000ce8;		//store r8,3(r7) 

	 
/*	 //有数据冒险的流水线指令
	 
	 assign rom[6'h00]=32'h00000000;
	 assign rom[6'h01]=32'h30001043;		//xori r3,r2,4
	 assign rom[6'h02]=32'h00101043;		//add r4,r2,r3   
	 assign rom[6'h03]=32'h34001045;		//load r5,4(r2)   
	 assign rom[6'h04]=32'h08211807;		//srl r6,r7,2
	 assign rom[6'h05]=32'h38000ce8;		//store r8,3(r7) 
	 assign rom[6'h06]=32'h3c001064;    //beq r3,r4,4,offset=4,label=44*/
	 
	 //无冒险的流水线指令
	 
/*	 assign rom[6'h00]=32'h00000000;
	 assign rom[6'h01]=32'h30001043;		//xori r3,r2,4
	 assign rom[6'h02]=32'h00101041;		//add r4,r2,r1   
	 assign rom[6'h03]=32'h34001045;		//load r5,4(r2)   
	 assign rom[6'h04]=32'h08211807;		//srl r6,r7,2
	 assign rom[6'h05]=32'h38000ce8;		//store r8,3(r7) 
	 assign rom[6'h06]=32'h3c001064;    //beq r3,r4,4,offset=4,label=44*/
	 
	 
	 assign rom[6'h07]=32'h00000000;		
	 assign rom[6'h08]=32'h00000000;
	 assign rom[6'h09]=32'h00000000;
	 assign rom[6'h0A]=32'h00000000;
	 assign rom[6'h0B]=32'h00000000;
	 assign rom[6'h0C]=32'h00000000;
	 assign rom[6'h0D]=32'h00000000;
	 assign rom[6'h0E]=32'h00000000;
	 assign rom[6'h0F]=32'h00000000;
	 assign rom[6'h10]=32'h00000000;
	 assign rom[6'h11]=32'h00000000;
	 assign rom[6'h12]=32'h00000000;
	 assign rom[6'h13]=32'h00000000;
	 assign rom[6'h14]=32'h00000000;
	 assign rom[6'h15]=32'h00000000;
	 assign rom[6'h16]=32'h00000000;
	 assign rom[6'h17]=32'h00000000;
	 assign rom[6'h18]=32'h00000000;
	 assign rom[6'h19]=32'h00000000;
	 assign rom[6'h1A]=32'h00000000;
	 assign rom[6'h1B]=32'h00000000;
	 assign rom[6'h1C]=32'h00000000;
	 assign rom[6'h1D]=32'h00000000;
	 assign rom[6'h1E]=32'h00000000;
	 assign rom[6'h1F]=32'h00000000;
	 assign rom[6'h20]=32'h00000000;
	 assign rom[6'h21]=32'h00000000;
	 assign rom[6'h22]=32'h00000000;
	 assign rom[6'h23]=32'h00000000;
	 assign rom[6'h24]=32'h00000000;
	 assign rom[6'h25]=32'h00000000;
	 assign rom[6'h26]=32'h00000000;
	 assign rom[6'h27]=32'h00000000;
	 assign rom[6'h28]=32'h00000000;
	 assign rom[6'h29]=32'h00000000;
	 assign rom[6'h2A]=32'h00000000;
	 assign rom[6'h2B]=32'h00000000;
	 assign rom[6'h2C]=32'h00000000;
	 assign rom[6'h2D]=32'h00000000;
	 assign rom[6'h2E]=32'h00000000;
	 assign rom[6'h2F]=32'h00000000;
	 assign rom[6'h30]=32'h00000000;
	 assign rom[6'h31]=32'h00000000;
	 assign rom[6'h32]=32'h00000000;
	 assign rom[6'h33]=32'h00000000;
	 assign rom[6'h34]=32'h00000000;
	 assign rom[6'h35]=32'h00000000;
	 assign rom[6'h36]=32'h00000000;
	 assign rom[6'h37]=32'h00000000;
	 assign rom[6'h38]=32'h00000000;
	 assign rom[6'h39]=32'h00000000;
	 assign rom[6'h3A]=32'h00000000;
	 assign rom[6'h3B]=32'h00000000;
	 assign rom[6'h3C]=32'h00000000;
	 assign rom[6'h3D]=32'h00000000;
	 assign rom[6'h3E]=32'h00000000;
	 assign rom[6'h3F]=32'h00000000;
	 
	 assign inst=rom[a];
endmodule
