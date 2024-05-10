`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/09/2024 08:34:50 PM
// Design Name: 
// Module Name: HazardUnit
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module HazardUnit(
    input RegWriteM, RegWriteW,
    input [4:0] RdM, RdW, RS1E, RS2E,
    output [1:0] ForwardAE, ForwardBE
    );
    
    assign ForwardAE = ((RS1E == RdM) && RegWriteM) ? 2'b10 :
                       ((RS1E == RdW) && RegWriteW) ? 2'b01 : 2'b00;
    
    assign ForwardBE = (((RS1E == RdM) && RegWriteM) && (RS1E != 5'b00000)) ? 2'b10 :
                       (((RS1E == RdW) && RegWriteW) && (RS1E != 5'b00000)) ? 2'b01 : 2'b00;
    
endmodule
