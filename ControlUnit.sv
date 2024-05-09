`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/30/2024 07:54:32 AM
// Design Name: 
// Module Name: ControlUnit
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments: Logic found at verilogDetails.pdf pg. 3
// 
//////////////////////////////////////////////////////////////////////////////////


module ControlUnit(
    input [31:0] CU_Instruction,
    input [6:0] CU_opCode,
    input [2:0] CU_funct3,
    input CU_funct7,
    output Jump,
    output Branch,
    output ALUSrc,
    output RegWrite,
    output MemWrite,
    output [1:0] ImmSrc,
    output [1:0] ResultSrc,
    output [2:0] ALUControl
    );
    
typedef enum logic [6:0] {
    LOAD     = 7'b0000011,
    STORE    = 7'b0100011,
    OP       = 7'b0110011,
    BRANCH   = 7'b1100011,
    OP_IMM   = 7'b0010011,
    JAL      = 7'b1101111
    } opcode_t; 
    
    assign CU_opCode = CU_Instruction[6:0];
    assign CU_funct3 = CU_Instruction[14:12];
    assign CU_funct7 = CU_Instruction[30];
    
    reg [1:0] ALUop;
    
    assign RegWrite = (CU_opCode == LOAD || CU_opCode == OP || 
                       CU_opCode == OP_IMM || CU_opCode == JAL) ? 1'b1 : 1'b0;
    assign ImmSrc = (CU_opCode == STORE) ? 2'b01 : 
                    (CU_opCode == BRANCH) ?  2'b10 : 
                    (CU_opCode == JAL) ?  2'b11 : 2'b00;
    assign ALUSrc = (CU_opCode == LOAD || CU_opCode == STORE || 
                     CU_opCode == OP_IMM) ? 1'b1 : 1'b0;
    assign MemWrite = (CU_opCode == STORE) ? 1'b1 : 1'b0;
    assign ResultSrc = (CU_opCode == LOAD) ? 2'b01 : 
                       (CU_opCode == JAL) ? 2'b10 : 1'b00;
    assign Branch = (CU_opCode == BRANCH) ? 1'b1 : 1'b0 ;
    assign ALUop = (CU_opCode == OP || CU_opCode == OP_IMM) ? 2'b10 : 
                   (CU_opCode == BRANCH) ? 2'b01 : 2'b00;
    assign Jump = (CU_opCode == JAL) ? 1'b1 : 1'b0;
    
    
    assign ALUControl = (ALUop == 2'b00) ? 3'b000 :
                        (ALUop == 2'b01) ? 3'b001 :
                        ((ALUop == 2'b10) && (CU_funct3 == 3'b000) && ({CU_opCode[5],CU_funct7} == 2'b11)) ? 3'b001 : 
                        ((ALUop == 2'b10) && (CU_funct3 == 3'b000) && ({CU_opCode[5],CU_funct7} != 2'b11)) ? 3'b000 : 
                        ((ALUop == 2'b10) && (CU_funct3 == 3'b010)) ? 3'b101 : 
                        ((ALUop == 2'b10) && (CU_funct3 == 3'b110)) ? 3'b011 : 
                        ((ALUop == 2'b10) && (CU_funct3 == 3'b111)) ? 3'b010 : 
                                                                  3'b000 ;
  
endmodule
