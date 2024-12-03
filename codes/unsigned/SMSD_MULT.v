`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Design Name: 
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
module AM1_AM2#(
    parameter pN = 128                
)(
    input   Rst,                    // Reset
    input   Clk,                    // Clock
    input   Ld,                     // Load Registers and Start Multiplier
    input   [(	pN - 1):0] M,      // Multiplicand
    output  reg [ (pN+3):0] P1,   
	 output  reg [ (pN+3):0] P2 ,  
    output  reg [ (pN+3):0] P3 ,  
    output  reg [ (pN+3):0] P4 ,  
    output  reg [ (pN+3):0] P5,   
    input   [(	pN - 1):0] N      // Multiplicand

);

//
//  Declarations
reg     [pN-1:0] P;      // Multiplicand w/ sign guard bit
reg     [pN-1:0] R;      // Multiplicand w/ sign guard bit
reg     [pN-1:0] A;      // Multiplicand w/ sign guard bit
reg     [   pN:0] Cntr;   // Operation Counter
reg     [   pN:0] Valid;   // Operation Counter

reg     [2**pN:0] S;      // Adder w/ sign guard bit
reg     [(2**(pN+1) + 1):0] Prod;   // Double length product w/ guard bits

///////////////////////////////////////////////////////////////////////////////
//
//  Implementation
//

always @(posedge Clk)
begin
    if(Rst)
        Cntr <= #1 0;
    else if(Ld)
        Cntr <= #1 2**pN;
    else if(|Cntr)
        Cntr <= #1 (Cntr - 1);
end

//  Multiplicand Register
//      includes an additional bit to guard sign bit in the event the
//      most negative value is provided as the multiplicand.

always @(posedge Clk)
begin
    if(Rst)
        A <= #1 0;
    else if(Ld)
        A <= #1 {M[2**pN ], M};  
end

//  Compute Upper Partial Product: (2**pN + 1) bits in width

always @(*)
begin
    case(Prod[1:0])
        2'b01   : S <= Prod[(2**(pN+1) + 1):(2**pN + 1)] + A;
        2'b10   : S <= Prod[(2**(pN+1) + 1):(2**pN + 1)] - A;
        default : S <= Prod[(2**(pN+1) + 1):(2**pN + 1)];
    endcase
end

//  Register Partial products and shift rigth arithmetically.
//      Product register has guard bits on both ends.

always @(posedge Clk)
begin
    if(Rst)
        Prod <= #1 0;
    else if(Ld)
        Prod <= #1 {R, 1'b0};
end

//  Assign the product less the two guard bits to the output port

always @(posedge Clk)
begin
    if(Rst)
        P <= #1 0;

end

//  Count the number of shifts
//      This implementation does not use any optimizations to perform multiple
//      bit shifts to skip over runs of 1s or 0s.

always @(posedge Clk)
begin
    if(Rst)
	 begin
			 P1 = M ;
			 P2 = M << 1;
			 P3 = (M << 1)+ M;
			 P4 = M << 2;
			 P5 = (M << 2)+ M;

	 end
    else
	 begin
			 P1 = M ;
			 P2 = N;
			 P3 = (N << 1)+ N;
			 P4 = N << 2;
			 P5 = (M << 2)+ N;

	 end
end

endmodule
