`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:45:09 10/23/2015 
// Design Name: 
// Module Name:    ALUop 
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
module ALUop(
    input  [5:0] func,
	 input  [1:0] ALUctr,
	 output [2:0] ALU_op 
    );
	 
    wire i_Rt  = ALUctr[1] & ~ALUctr[0];
	 
    assign ALU_op[2] = (i_Rt & ((~func[2] & func[1]) | (func[2] & func[0]))) | ALUctr[0];
	 assign ALU_op[1] = (i_Rt & func[2] & func[1]) | (ALUctr[1] & ALUctr[0]);
	 assign ALU_op[0] = (i_Rt & func[2] & ~func[1]);

endmodule
