`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:06:14 06/20/2021
// Design Name:   IF_STAGE
// Module Name:   E:/ISE_projects/sccpu/test1.v
// Project Name:  sccpu
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: IF_STAGE
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test1;

	// Inputs
	reg clk;
	reg clrn;
	reg [1:0] pcsource;
	reg [31:0] bpc;
	reg [31:0] jpc;

	// Outputs
	wire [31:0] pc4;
	wire [31:0] inst;
	wire [31:0] PC;

	// Instantiate the Unit Under Test (UUT)
	IF_STAGE uut (
		.clk(clk), 
		.clrn(clrn), 
		.pcsource(pcsource), 
		.bpc(bpc), 
		.jpc(jpc), 
		.pc4(pc4), 
		.inst(inst), 
		.PC(PC)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		clrn = 0;
		pcsource = 0;
		bpc = 0;
		jpc = 0;

		// Wait 100 ns for global reset to finish
		#100;
		clrn=1;bpc=32'h00000014;jpc=32'h0000000c;pcsource=2'b00;
		#100;
		clrn=1;bpc=32'h00000014;jpc=32'h0000000c;pcsource=2'b01;
		#100;
		clrn=1;bpc=32'h00000014;jpc=32'h0000000c;pcsource=2'b10;
		#100;
		clrn=1;bpc=32'h00000014;jpc=32'h0000000c;pcsource=2'b11;
		#100;
		clrn=1;bpc=32'h00000014;jpc=32'h0000000c;pcsource=2'b00;
        
		// Add stimulus here

	end
	always #50 clk=~clk;
      
endmodule

