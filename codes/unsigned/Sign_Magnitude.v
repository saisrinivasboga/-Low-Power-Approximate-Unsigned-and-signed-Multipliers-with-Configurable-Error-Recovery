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
`define width 128
`timescale 1ns/1ps
module proposed_multiplier(x, y, Clk, Rst,p);

parameter width= `width;

input [width-1:0]x, y;
output [width+width-1:0]p;
input  Clk, Rst;

wire [16:0]Sign ,Sign1; 
 wire  [ (width+3):0] P1;   
	wire  [ (width+3):0] P2 ;  
  wire [ (width+3):0] P3 ;  
   wire [ (width+3):0] P4 ;  
   wire  [ (width+3):0] P5 ;
  wire [width-1:0] OUT; 
  
wire	[width+width-1:0]mux_out;

approximate_adder o1 (y, OUT,Sign);  

 AM1_AM2       s1 (Rst,Clk,Rst,x,P1,P2,P3,P4,P5,y);

one_hot_mux     o2 (Rst,P1,P2,P3,P4,P5, OUT,mux_out,Sign1 );

assign Sign_out=Sign^Sign1;

parial_products_reduction           b1  (p, mux_out[width+width-1:width], mux_out[width-1:0],Sign_out);



endmodule
