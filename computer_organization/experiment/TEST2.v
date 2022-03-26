`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:16:09 09/25/2020
// Design Name:   Single_Cycle_Computer
// Module Name:   D:/dwl/experiment/TEST2.v
// Project Name:  experiment
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Single_Cycle_Computer
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module TEST2;

	// Inputs
	reg Reset;
	reg Clock;

	// Outputs
	wire [31:0] Result;
	wire [31:0] addr;

	// Instantiate the Unit Under Test (UUT)
	Single_Cycle_Computer uut (
		.Reset(Reset), 
		.Clock(Clock), 
		.Result(Result), 
		.addr(addr)
	);

	initial begin
		// Initialize Inputs
		Reset = 1;
		Clock = 0;

		// Wait 100 ns for global reset to finish
		#100;
       Reset=0;
		// Add stimulus here

	end
      always #50 Clock=~Clock;
endmodule

