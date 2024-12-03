`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:   
// Design Name: 
// Module Name:     
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
module approximate_adder (y, OUT,Sign);  
  input [63:0]y;  
  output [63:0] OUT;  
  reg [63:0] OUT;  
   output [15:0] Sign;  
  reg [15:0]Sign;  
 
  always @(y or OUT )  
  begin  

  OUT = 2**y; 
  Sign= OUT[63:47];
  end  
endmodule 