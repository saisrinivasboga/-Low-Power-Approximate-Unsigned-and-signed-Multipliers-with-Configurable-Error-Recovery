`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Design Name:   
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Sign_Magnitude
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////
`define width 128

module new_tb;
parameter width= `width;

	// Inputs
	reg [width-1:0] x;
	reg [width-1:0] y;
	reg Clk;
	reg Rst;

	// Outputs
	wire [width+width-1:0] p;

	// Instantiate the Unit Under Test (UUT)
	proposed_multiplier uut (
		.p(p), 
		.x(x), 
		.y(y), 
		.Clk(Clk), 
		.Rst(Rst)
	);

always 		#1 Clk=~Clk ;
	initial begin
		// Initialize Inputs
		x = 0;
		y = 0;
		Clk = 0;
		Rst = 1;

		// Wait 100 ns for global reset to finish
		#100;
		x = -25;
		y = -100;
		Rst = 0;
        
		// Add stimulus here

	end
      
endmodule

