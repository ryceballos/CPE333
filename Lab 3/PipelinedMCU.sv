`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:  J. Callenes
// 
// Create Date: 01/04/2019 04:32:12 PM
// Design Name: 
// Module Name: PIPELINED_OTTER_CPU
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


module PipelinedMCU(
    input CLK,
    input INTR,
    input RESET,
    input [31:0] IOBUS_IN,
    output [31:0] IOBUS_OUT,
    output [31:0] IOBUS_ADDR,
    output logic IOBUS_WR 
);

    wire JumpE, PCSrcE, RegWriteW, RegWriteE, ALUSrcE, MemWriteE, BranchE, RegWriteM, MemWriteM;
    wire [1:0] ResultSrcE, ResultSrcM, ResultSrcW;
    wire [2:0] ALUControlE;
    wire [4:0] RdE, RdM, RdW;
    wire [31:0] PCTargetE, InstrD, PCD, PCPlus4D, ResultW, RD1E, RD2E, ImmExtE, PCE, PCPlus4E, PCPlus4M, WriteDataM, ALUResultM;
    wire [31:0] PCPlus4W, ALUResultW, ReadDataW;
    wire [4:0] RS1E, RS2E;
    wire [1:0] ForwardBE, ForwardAE;

    FetchStage F (
        .CLK(CLK),
        .RESET(RESET),
        .PCsrcE(PCSrcE),
        .PCTargetE(PCTargetE),
        .PCD(PCD),
        .InstrD(InstrD),
        .PCPlus4D(PCPlus4D)
    );
    
    DecodeStage D (
        .CLK(CLK),
        .RESET(RESET),
        .RegWriteW(RegWriteW),
        .RdW(RdW),
        .PCD(PCD), 
        .InstrD(InstrD), 
        .ResultW(ResultW), 
        .PCPlus4D(PCPlus4D),
        .JumpE(JumpE), 
        .BranchE(BranchE), 
        .ALUSrcE(ALUSrcE), 
        .MemWriteE(MemWriteE), 
        .RegWriteE(RegWriteE), 
        .ResultSrcE(ResultSrcE),                      
        .ALUControlE(ALUControlE),
        .RD1E(RD1E), 
        .RD2E(RD2E),
        .ImmExtE(ImmExtE),
        .Rs1E(), 
        .Rs2E(),
        .RdE(RdE),
        .PCE(PCE), 
        .PCPlus4E(PCPlus4E)
    );

    ExecuteStage E (
        .CLK(CLK),
        .RESET(RESET),
        .JumpE(JumpE), 
        .BranchE(BranchE), 
        .ALUSrcE(ALUSrcE), 
        .MemWriteE(MemWriteE), 
        .RegWriteE(RegWriteE),
        .ForwardAE(), 
        .ForwardBE(),
        .ResultSrcE(ResultSrcE),
        .ALUControlE(ALUControlE),
        .Rs1E(), 
        .Rs2E(),
        .RdE(RdE),
        .PCE(PCE), 
        .RD1E(RD1E), 
        .RD2E(RD2E), 
        .ALUResultM2(),
        .ImmExtE(ImmExtE), 
        .PCPlus4E(PCPlus4E),
        .RegWriteM(RegWriteM), 
        .MemWriteM(MemWriteM),
        .ResultSrcM(ResultSrcM),
        .PCSrcE(PCSrcE), 
        .Rs1H(), 
        .Rs2H(),
        .RdM(RdM), 
        .PCPlus4M(PCPlus4M), 
        .PCTargetE(PCTargetE), 
        .WriteDataM(WriteDataM), 
        .ALUResultM(ALUResultM)
    );
    
    MemoryStage M (
        .CLK(CLK),
        .RESET(RESET),
        .RegWriteM(RegWriteM), 
        .MemWriteM(MemWriteM),
        .ResultSrcM(ResultSrcM),
        .RdM(RdM), 
        .PCPlus4M(PCPlus4M), 
        .WriteDataM(WriteDataM), 
        .ALUResultM(ALUResultM),
        .RegWriteH(),
        .RegWriteW(RegWriteW),
        .ResultSrcW(ResultSrcW),
        .RdH(),
        .RdW(RdW), 
        .PCPlus4W(PCPlus4W), 
        .ReadDataW(ReadDataW),
        .ALUResultM2(), 
        .ALUResultW(ALUResultW)
    );
    
    WriteBackStage W (
        .CLK(CLK),
        .RESET(RESET),
        .RegWriteM(RegWriteM),
        .ResultSrcW(ResultSrcW),
        .RdW(RdW), 
        .PCPlus4W(PCPlus4W), 
        .ReadDataW(ReadDataW), 
        .ALUResultW(ALUResultW),
        .RegWriteH(), 
        .RegWriteW(RegWriteW), 
        .RdH(),
        .ResultW(ResultW)
    );
    
    HazardUnit HU (
        .RegWriteM(), 
        .RegWriteW(),
        .RdM(), 
        .RdW(), 
        .RS1E(), 
        .RS2E(),
        .ForwardAE(), 
        .ForwardBE()
    );
endmodule
