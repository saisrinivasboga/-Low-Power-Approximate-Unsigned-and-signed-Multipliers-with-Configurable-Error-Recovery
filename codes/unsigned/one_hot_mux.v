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

`define width 128

module one_hot_mux(Rst,P1,P2,P3,P4,P5, sel,mux_out,Sign );
parameter width= `width;
input [ (width+3):0]P1,P2,P3,P4,P5 ;
input [4:0]sel ;
    input   Rst;                   

output [width+width-1:0]mux_out;
reg    [width+width-1:0]mux_out;

	output [15:0] Sign;  
  reg [15:0]Sign;  
always @ (*)
begin : MUX
 if(Rst)
	 begin
    case(sel ) 
    5'b00001 : mux_out = P1;
    5'b00010 : mux_out = P2;
	 5'b00100 : mux_out = P3;
    5'b01000 : mux_out = P4;
    5'b10000 : mux_out = P5;

    endcase 
    end
 else
    begin
    Sign= mux_out[63:47];
    mux_out = {P1[width-1:0],P2[width-1:0]};
    end
end

endmodule //End Of Module mux