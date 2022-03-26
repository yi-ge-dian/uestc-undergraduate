`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:38:30 06/20/2021
// Design Name:   Control_Unit
// Module Name:   E:/ISE_projects/sccpu/test_controlunit.v
// Project Name:  sccpu
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Control_Unit
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_controlunit;

	// Inputs
	reg rsrtequ;
	reg [5:0] func;
	reg [5:0] op;

	// Outputs
	wire wreg;
	wire m2reg;
	wire wmem;
	wire [2:0] aluc;
	wire regrt;
	wire aluimm;
	wire sext;
	wire [1:0] pcsource;
	wire shift;

	// Instantiate the Unit Under Test (UUT)
	Control_Unit uut (
		.rsrtequ(rsrtequ), 
		.func(func), 
		.op(op), 
		.wreg(wreg), 
		.m2reg(m2reg), 
		.wmem(wmem), 
		.aluc(aluc), 
		.regrt(regrt), 
		.aluimm(aluimm), 
		.sext(sext), 
		.pcsource(pcsource), 
		.shift(shift)
	);

	initial begin
		// Initialize Inputs
		rsrtequ = 0;
		func = 0;
		op = 0;

		// Wait 100 ns for global reset to finish
		#100;
      rsrtequ = 1;     
		// Add stimulus here
		#50;op[5:0]=6'b010010;//jump
		#50;op[5:0]=6'b001111;//beq
		#50;op[5:0]=6'b001110;//store
		#50;op[5:0]=6'b001101;//load
		#50;op[5:0]=6'b001100;//xori
		#50;op[5:0]=6'b000101;//addi
		#50;op[5:0]=6'b000010;func[5:0]=6'b000010;//srl	
		#50;op[5:0]=6'b000000;func[5:0]=6'b000001;//add	

	end
      
endmodule

