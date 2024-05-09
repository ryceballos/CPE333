`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/30/2024 08:44:13 AM
// Design Name: 
// Module Name: SignExtend
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments: Logic found at MariaImplementations_Ch7.pdf pg. 14
// 
//////////////////////////////////////////////////////////////////////////////////


module SignExtend(
    input [31:0] SE_Instruction,
    input [31:0] Instr,
    input [1:0] ImmSrc,
    output [31:0] Imm_Ext
    );
    
    assign Instr = {SE_Instruction[31:20], 20'b0};

    assign Imm_Ext = (ImmSrc == 2'b00) ? {{20{Instr[31]}},Instr[31:20]} : 
                     (ImmSrc == 2'b01) ? {{20{Instr[31]}},Instr[31:25],Instr[11:7]} : 32'h00000000; 

endmodule
