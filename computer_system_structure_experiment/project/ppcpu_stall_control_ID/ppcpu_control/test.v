`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:38:05 06/21/2021
// Design Name:   PPCPU_Control_Adventure_Solved_Stall
// Module Name:   E:/ISE_projects/ppcpu_control/test.v
// Project Name:  ppcpu_control
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: PPCPU_Control_Adventure_Solved_Stall
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test;

	// Inputs
	reg Clock;
	reg Resetn;

	// Outputs
	wire [31:0] PC;
	wire [31:0] ID_INST;
	wire [31:0] IF_INST;
	wire [31:0] EXE_ALU;
	wire [31:0] MEM_ALU;
	wire [31:0] WB_ALU;
	wire [1:0] pcsource;
	wire stall;
	wire [31:0] jpc;
	wire [31:0] bpc;

	// Instantiate the Unit Under Test (UUT)
	PPCPU_Control_Adventure_Solved_Stall uut (
		.Clock(Clock), 
		.Resetn(Resetn), 
		.PC(PC), 
		.ID_INST(ID_INST), 
		.IF_INST(IF_INST), 
		.EXE_ALU(EXE_ALU), 
		.MEM_ALU(MEM_ALU), 
		.WB_ALU(WB_ALU), 
		.pcsource(pcsource), 
		.stall(stall), 
		.jpc(jpc), 
		.bpc(bpc)
	);

	initial begin
		// Initialize Inputs
		Clock = 0;
		Resetn = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		Resetn = 1;
	end
      
	always #50 Clock=~Clock;
endmodule

