`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly SLO - CPE 333
// Engineer: Ryan Ceballos, Yexelle Nash Segovia, Carlos Vidal, Eduardo Gallegos
// 
// Create Date: 01/04/2019 04:32:12 PM
// Design Name: OTTER Pipelined Processor with Control Hazards
// Module Name: PIPELINED_OTTER_CPU
// Project Name: 
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

    wire JumpE, PCSrcE, RegWriteW, RegWriteE, ALUSrcE, MemWriteE, BranchE, RegWriteM, MemWriteM, ResultSrcEH, RegWriteMH, RegWriteWH;
    wire [1:0] ResultSrcE, ResultSrcM, ResultSrcW;
    wire [2:0] ALUControlE;
    wire [4:0] RdE, RdM, RdW;
    wire [31:0] PCTargetE, InstrD, PCD, PCPlus4D, ResultW, RD1E, RD2E, ImmExtE, PCE, PCPlus4E, PCPlus4M, WriteDataM, ALUResultM;
    wire [31:0] PCPlus4W, ALUResultW, ReadDataW;
    wire [4:0] RS1E, RS2E, RS1EH, RS2EH, RDEH, RS1DH, RS2DH, RDMH, RDWH;
    wire [1:0] ForwardBE, ForwardAE;
    wire StallF, StallD, FlushD, FlushE; // BUS SIZE ????

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
        .RdE(RdE),
        .PCE(PCE),
        .PCPlus4E(PCPlus4E),
        .Rs1E(RS1E),
        .Rs2E(RS2E),
        .Rs1DH(RS1DH),
        .Rs2DH(RS2DH)
    );

    ExecuteStage E (
        .CLK(CLK),
        .RESET(RESET),
        .JumpE(JumpE),
        .BranchE(BranchE),
        .ALUSrcE(ALUSrcE),
        .MemWriteE(MemWriteE),
        .RegWriteE(RegWriteE),
        .ForwardAE(ForwardAE),
        .ForwardBE(ForwardBE),
        .ResultSrcE(ResultSrcE),
        .ALUControlE(ALUControlE),
        .Rs1E(RS1E),
        .Rs2E(RS2E),
        .RdE(RdE),
        .PCE(PCE),
        .RD1E(RD1E),
        .RD2E(RD2E),
        .ALUResultM2(ALUResultM),
        .ImmExtE(ImmExtE),
        .PCPlus4E(PCPlus4E),
        .RegWriteM(RegWriteM),
        .MemWriteM(MemWriteM),
        .ResultSrcM(ResultSrcM),
        .PCSrcE(PCSrcE),
        .Rs1EH(RS1EH),
        .Rs2EH(RS2EH),
        .RdEH(RDEH),
        .RdM(RdM),
        .PCPlus4M(PCPlus4M),
        .PCTargetE(PCTargetE),
        .WriteDataM(WriteDataM),
        .ALUResultM(ALUResultM),
        .ResultW(ResultW),
        .ResultSrcEH(ResultSrcEH)
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
        .RegWriteMH(RegWriteMH),
        .RegWriteW(RegWriteW),
        .ResultSrcW(ResultSrcW),
        .RdMH(RDMH),
        .RdW(RdW),
        .PCPlus4W(PCPlus4W),
        .ReadDataW(ReadDataW),
        .ALUResultM2(),
        .ALUResultW(ALUResultW)
    );
    
    WriteBackStage W (
        .CLK(CLK),
        .RESET(RESET),
        .RegWriteW(RegWriteW),
        .ResultSrcW(ResultSrcW),
        .RdW(RdW),
        .PCPlus4W(PCPlus4W),
        .ReadDataW(ReadDataW),
        .ALUResultW(ALUResultW),
        .RegWriteWH(RegWriteWH),
        // .RegWriteW(RegWriteW),
        .RdWH(RDWH),
        .ResultW(ResultW)
    );
    
    HazardUnit H (
        .rst(RESET),
        .RegWriteM(RegWriteMH),
        .RegWriteW(RegWriteWH),
        .PCSrcE(PCSrcE),
        .ResultSrcE(ResultSrcEH),
        .RdW(RDWH),
        .RS1E(RS1EH),
        .RS2E(RS2EH),
        .RdE(RDEH),
        .Rs1D(RS1DH),
        .Rs2D(RS2DH),
        .RdM(RDMH),
        .ForwardAE(ForwardAE),
        .ForwardBE(ForwardBE),
        .StallF(StallF),
        .StallD(StallD),
        .FlushD(FlushD),
        .FlushE(FlushE)

    );
endmodule
