`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/30/2024 06:36:19 AM
// Design Name: 
// Module Name: Fetch
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


module FetchStage(
    input CLK,
    input RESET,
    input PCsrcE,
    input StallF, StallD, FlushD,
    input [31:0] PCTargetE,
    output [31:0] PCD,
    output [31:0] InstrD,
    output [31:0] PCPlus4D
    );
    
    //Declaring Wires
    logic [31:0] PCF, PC_F, PCPlus4;
    logic [31:0] InstrF;
    
    //Pipeline Registers
    reg [31:0] InstrF_reg, PCF_reg, PCPlus4_reg;
    
    //Initialization of Modules
    PCMUX PCMUX (                       //PC MUX
        .PCPlus4F (PCPlus4),        //0
        .PCTargetE (PCTargetE),     //1
        .PCsrcE (PCsrcE),
        .PC_F (PC_F)
    );
    
    ProgramCounter PC (                 //Program Counter
        .CLK(CLK),
        .PC_reset(RESET),
        .PC_StallEN(StallF), 
        .PC_IN(PC_F), 
        .PC_OUT(PCF)
    );
    
    InstructionMemory MEM (             //Instruction Memory
        .MEM_reset(RESET),
        .A(PCF),
        .RD(InstrF)
    );
    
    PCPlus4 PC4 (                       //PC Plus 4
        .PC(PCF),
        .PCPlus(PCPlus4)
    );
    
    //Pipeline Logic
    /*always_comb begin
        InstrF_reg <= InstrF;
        PCF_reg <= PCF;
        PCPlus4_reg <= PCPlus4;
    end*/

    always_ff@ (posedge CLK) begin
        if (RESET || FlushD) begin
            InstrF_reg <= 0;
            PCF_reg <= 0;
            PCPlus4_reg <= 0;
        end else if (StallD) begin
            InstrF_reg <= InstrF_reg;
            PCF_reg <= PCF_reg;
            PCPlus4_reg <= PCPlus4_reg;
        end else begin
            InstrF_reg <= InstrF;
            PCF_reg <= PCF;
            PCPlus4_reg <= PCPlus4;
        end
    end
    
    //Pipeline Registers to Output
    assign InstrD = InstrF_reg;
    assign PCD = PCF_reg;
    assign PCPlus4D = PCPlus4_reg;
    
endmodule
