`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:38:18 06/20/2021
// Design Name:   PPCPU_Data_Adventure_Solved_Stall
// Module Name:   E:/ISE_projects/ppcpu_data/third.v
// Project Name:  ppcpu_data
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: PPCPU_Data_Adventure_Solved_Stall
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module third;

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

	// Instantiate the Unit Under Test (UUT)
	PPCPU_Data_Adventure_Solved_Stall uut (
		.Clock(Clock), 
		.Resetn(Resetn), 
		.PC(PC), 
		.ID_INST(ID_INST), 
		.IF_INST(IF_INST), 
		.EXE_ALU(EXE_ALU), 
		.MEM_ALU(MEM_ALU), 
		.WB_ALU(WB_ALU), 
		.pcsource(pcsource), 
		.stall(stall)
	);

	initial begin
		// Initialize Inputs
		Clock = 0;
		Resetn = 0;

		// Wait 100 ns for global reset to finish
		#100;
      Resetn=1; 
		// Add stimulus here

	end
	always #50 Clock=~Clock;
      
endmodule

