`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/01/2024 03:50:35 PM
// Design Name: 
// Module Name: MemoryStage
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


module MemoryStage(
    input CLK,
    input RESET,
    input RegWriteM, MemWriteM,
    input [1:0] ResultSrcM,
    input [4:0] RdM,
    input [31:0] PCPlus4M, WriteDataM, ALUResultM,
    output RegWriteH, RegWriteW,
    output [1:0] ResultSrcW,
    output [4:0] RdH, RdW,
    output [31:0] PCPlus4W, ReadDataW, ALUResultM2, ALUResultW
    );
    
    //Declaring Wires   
    logic [31:0] ReadDataM;
    
    //Pipeline Registers 
    reg RegWriteM_reg;
    reg [1:0] ResultSrcM_reg;
    
    reg [4:0] RdM_reg;
    reg [31:0] PCPlus4M_reg, ReadDataM_reg, ALUResultM_reg;
    
    //Initialization of Modules
    DataMemory DM (
        .CLK(CLK), 
        .DM_reset(RESET),
        .WE(MemWriteM),
        .A(ALUResultM), 
        .WD(WriteDataM), 
        .RD(ReadDataM)
    );
    
    //Pipeline Logic 
    /*always_comb begin
        RegWriteM_reg <= RegWriteM;
        ResultSrcM_reg <= ResultSrcM;
        RdM_reg <= RdM;
        PCPlus4M_reg <= PCPlus4M; 
        ReadDataM_reg <= ReadDataM; 
        ALUResultM_reg <= ALUResultM;
    end*/
    
    always_ff@ (posedge CLK) begin
        if (RESET) begin
            RegWriteM_reg <= 0;
            ResultSrcM_reg <= 0;
            RdM_reg <= 0;
            PCPlus4M_reg <= 0; 
            ReadDataM_reg <= 0; 
            ALUResultM_reg <= 0;
        end else begin
            RegWriteM_reg <= RegWriteM;
            ResultSrcM_reg <= ResultSrcM;
            RdM_reg <= RdM;
            PCPlus4M_reg <= PCPlus4M; 
            ReadDataM_reg <= ReadDataM; 
            ALUResultM_reg <= ALUResultM;
        end
    end
   
    //Pipeline Registers to Output
    assign RegWriteW = RegWriteM_reg;
    assign ResultSrcW = ResultSrcM_reg;
    assign RdW = RdM_reg; 
    assign PCPlus4W = PCPlus4M_reg; 
    assign ReadDataW = ReadDataM_reg;
    assign ALUResultW = ALUResultM_reg;
    
endmodule
