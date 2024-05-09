`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/30/2024 04:36:14 PM
// Design Name: 
// Module Name: PCTarget
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


module PCTarget(
    input [31:0] PCE, ImmExtE,
    output [31:0] PCTargetE
    );
    
    assign PCTargetE = PCE + ImmExtE;
endmodule
