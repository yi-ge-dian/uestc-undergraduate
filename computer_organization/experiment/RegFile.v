`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:59:10 09/25/2020 
// Design Name: 
// Module Name:    RegFile 
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
//寄存器堆
module RegFile(
			 input [4:0]  Rn1,Rn2,Wn,
			 input        Write,
			 input [31:0]  Wd,
			 output [31:0] A,B,
			 input Clock
    );
	 
    reg [31:0] Register[1:31]; //定义31个32位的寄存器
	 
	 //Read data
	 assign A = (Rn1 == 0)? 0 : Register[Rn1];
	 assign B = (Rn2 == 0)? 0 : Register[Rn2];
	 
	 //Write data
	
	 always @ ( posedge Clock) begin
		  if (( Write ) && ( Wn != 0)) Register[Wn] <= Wd;
	 end 

/*
    integer i;
	
	 initial begin
			for ( i = 1 ; i <= 31 ; i = i + 1) Register [i] = i ;
	 end		
*/

endmodule