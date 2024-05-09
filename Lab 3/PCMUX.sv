`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/24/2024 07:31:59 PM
// Design Name: 
// Module Name: PCMUX
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


module PCMUX(
    /*input [31:0] JAL,
   input [31:0] JALR,    
   input [31:0] MEPC,
   input [31:0] MTVEC,
   input [31:0] BRANCH,
   input [31:0] PC_ADD4,
   input [2:0] PC_SEL,
   output logic [31:0] muxOut*/
   input [31:0] PCPlus4F,
   input [31:0] PCTargetE,    
   input PCsrcE,
   output logic [31:0] PC_F
   );
   
   /*always_comb begin
        case (PC_SEL)
            3'b000: //Sets the incremented address to the output because each address is 4 bytes
                muxOut = PC_ADD4;
            3'b001: //Allows us to run the JALR command
                muxOut = JALR;
            3'b010: //Allows us to run the BRANCH command
                muxOut = BRANCH;
            3'b011: //Allows us to run the JAL command
                muxOut = JAL;
            3'b100: //Allows us to run the MTVEC command
                muxOut = MTVEC;
            3'b101: //Allows us to run the MEPC command
                muxOut = MEPC;
            default:
                muxOut = 32'h0badbad0;
        endcase
   end*/
   assign PC_F = (~PCsrcE) ? PCPlus4F : PCTargetE;
endmodule