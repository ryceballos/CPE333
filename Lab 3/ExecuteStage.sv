`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/30/2024 02:46:40 PM
// Design Name: 
// Module Name: Execute
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


module ExecuteStage(
    input CLK,
    input RESET,
    input JumpE, BranchE, ALUSrcE, MemWriteE, RegWriteE,            
    input [1:0] ResultSrcE,
    input [2:0] ALUControlE,
    input [31:0] RD1E,                                              
    input [31:0] RD2E,                                              
    input [31:0] PCE, ImmExtE,                                      
    input [4:0] RdE,                                                
    input [31:0] PCPlus4E, 
    output RegWriteM, MemWriteM,                                    
    output [1:0] ResultSrcM,
    input [31:0] ResultW;
    input [1:0] ForwardAE, ForwardBE;
    output PCSrcE, 
    output [4:0] RdM,
    output [31:0] PCPlus4M, PCTargetE, WriteDataM, ALUResultM
    );
    
    //Declaring Wires 
    logic ZeroE;                                         //--For Execute -> Fetch
    logic [31:0] SrcBE, ALUResultE;                       //--For Algorithmic Logic Unit
    
    //Pipeline Registers                                       
    reg MemWriteE_reg, RegWriteE_reg;                   //--For Control Unit
    reg [1:0] ResultSrcE_reg;
    
    reg [31:0] ALUResult_reg, WriteDataE_reg;           //--For Algorithmic Logic Unit
    
    reg [4:0] RdE_reg;                                  //--For Execute -> Memory

    reg [31:0] PCPlus4E_reg;                            //--For Execute -> Fetch
    
    //Initialization of Modules
    ArithmeticLogicUnit ALU (                           //Algorithmic Logic Unit
        .ALU_SRC_A(RD1E),
        .ALU_SRC_B(SrcBE),
        .ALU_FUN(ALUControlE),
        .ALU_result(ALUResultE),
        .ALU_zero(ZeroE)
    );
    
    srcBMUX BMUX (                                      //SrcB Mux
        .srcB_SEL(ALUSrcE),
        .Zero(RD2E),
        .One(ImmExtE),
        .Two(),
        .Three(),
        .ALU_srcB(SrcBE)
    );
    
    PCTarget PCT (                                      //PC Target
        .PCE(PCE),
        .ImmExtE(ImmExtE),
        .PCTargetE(PCTargetE)
    );
    
    //Pipeline Logic
    /*always_comb begin
        MemWriteE_reg <= MemWriteE;
        RegWriteE_reg <= RegWriteE;
        ResultSrcE_reg <= ResultSrcE;
        RdE_reg <= RdE;
        PCPlus4E_reg <= PCPlus4E;
        ALUResult_reg <= ALUResultE;
        WriteDataE_reg <= RD2E;
    end*/
    
    always_ff@ (posedge CLK) begin
        if (RESET) begin
            MemWriteE_reg <= 0;
            RegWriteE_reg <= 0;
            ResultSrcE_reg <= 0;
            RdE_reg <= 0;
            PCPlus4E_reg <= 0;
            ALUResult_reg <= 0;
            WriteDataE_reg <= 0;
        end else begin
            MemWriteE_reg <= MemWriteE;
            RegWriteE_reg <= RegWriteE;
            ResultSrcE_reg <= ResultSrcE;
            RdE_reg <= RdE;
            PCPlus4E_reg <= PCPlus4E;
            ALUResult_reg <= ALUResultE;
            WriteDataE_reg <= RD2E;
        end
    end
    
    //Pipeline Registers to Output
    assign PCSrcE = JumpE | (ZeroE & BranchE);
    
    assign RegWriteM = RegWriteE_reg;
    assign MemWriteM = MemWriteE_reg;
    assign ResultSrcM = ResultSrcE_reg; 
    assign RdM = RdE_reg;
    assign PCPlus4M = PCPlus4E_reg;
    assign WriteDataM = WriteDataE_reg;
    assign ALUResultM = ALUResult_reg;
    
endmodule
