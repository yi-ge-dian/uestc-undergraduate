`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   09:16:36 06/21/2021
// Design Name:   PPCPU
// Module Name:   E:/ISE_projects/ppcpu/test_ppcpu.v
// Project Name:  ppcpu
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: PPCPU
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_ppcpu;

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

	// Instantiate the Unit Under Test (UUT)
	PPCPU uut (
		.Clock(Clock), 
		.Resetn(Resetn), 
		.PC(PC), 
		.ID_INST(ID_INST), 
		.IF_INST(IF_INST), 
		.EXE_ALU(EXE_ALU), 
		.MEM_ALU(MEM_ALU), 
		.WB_ALU(WB_ALU)
	);

	initial begin
		// Initialize Inputs
		Clock = 0;
		Resetn = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		Resetn=1;
	end
	always #50 Clock=~Clock;
      
endmodule

