`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/30/2024 07:43:17 AM
// Design Name: 
// Module Name: Decode
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


module DecodeStage(
    input CLK,
    input RESET,
    input RegWriteW,
    input [4:0] RdW,
    input [31:0] PCD, InstrD, ResultW, PCPlus4D,
    output JumpE, BranchE, ALUSrcE, MemWriteE, RegWriteE,                                  
    output [1:0] ResultSrcE,
    output [2:0] ALUControlE,
    output [31:0] RD1E, RD2E,           
    output [31:0] ImmExtE,     
    output [4:0] RdE,
    output [31:0] PCE, PCPlus4E
    );
    
    logic [31:0] Instruction;
    
    //Declaring Wires
    logic RegWriteD, MemWriteD, JumpD, BranchD, ALUSrcD;                 //--For Control Unit 
    logic [1:0] ImmSrcD, ResultSrcD;
    logic [2:0] ALUControlD;
    
    logic [31:0] RD1D, RD2D;                                             //--For Register File
    
    logic [31:0] ImmExtD;                                                //--For Sign Extender
    
    //Pipeline Registers                   
    reg RegWriteD_reg, MemWriteD_reg, JumpD_reg, BranchD_reg, ALUSrcD_reg;  //-- For Control Unit
    reg [1:0] ImmSrcD_reg, ResultSrcD_reg;
    reg [2:0] ALUControlD_reg;
    
    reg [31:0] RD1D_reg, RD2D_reg;                                      //--For Register File
    
    reg [31:0] ImmExtD_reg;                                             //--For Sign Extender
    
    reg [4:0] RdD_reg;                                                  //--For Fetch -> Decode
    reg [31:0] PCD_reg, PCPlus4D_reg;
    
    //Initialization of Modules
    ControlUnit CU (                                    //Control Unit
        .CU_Instruction(InstrD),
        .CU_opCode(),
        .CU_funct3(),
        .CU_funct7(),
        .Jump(JumpD),
        .Branch(BranchD),
        .ALUSrc(ALUSrcD),
        .RegWrite(RegWriteD),
        .MemWrite(MemWriteD),
        .ImmSrc(ImmSrcD),
        .ResultSrc(ResultSrcD),
        .ALUControl(ALUControlD)
    );
    
    Register RF (                                       //Register File
        .CLK(CLK),
        .REG_EN(RegWriteW),                     //WE3
        .REG_Instruction(InstrD),
        .REG_ADR1(),                            //A1         
        .REG_ADR2(),                            //A2
        .REG_W_ADR(RdW),                        //A3
        .REG_W_DATA(ResultW),                   //WD3
        .REG_RS1(RD1D),                         //RD1
        .REG_RS2(RD2D)                          //RD2
    );
    
    SignExtend SE (                                     //Sign Extender
        .SE_Instruction(InstrD),
        .Instr(),
        .ImmSrc(ImmSrcD),
        .Imm_Ext(ImmExtD)
    );
    
    //Pipeline Logic
    /*always_comb begin
        RegWriteD_reg = RegWriteD;
        ResultSrcD_reg = ResultSrcD;
        MemWriteD_reg = MemWriteD;
        JumpD_reg = JumpD;
        BranchD_reg = BranchD;
        ALUSrcD_reg = ALUSrcD;
        ALUControlD_reg = ALUControlD;
        RD1D_reg = RD1D;
        RD2D_reg = RD2D;
        ImmExtD_reg = ImmExtD;
        RdD_reg = InstrD[11:7];
        PCD_reg = PCD;
        PCPlus4D_reg = PCPlus4D;
    end*/
    
    always_ff@ (posedge CLK) begin
        if (RESET) begin
            RegWriteD_reg = 0;
            ResultSrcD_reg = 0;
            MemWriteD_reg = 0;
            JumpD_reg = 0;
            BranchD_reg = 0;
            ALUSrcD_reg = 0;
            ALUControlD_reg = 0;
            RD1D_reg = 0;
            RD2D_reg = 0;
            ImmExtD_reg = 0;
            RdD_reg = 0;
            PCD_reg = 0;
            PCPlus4D_reg = 0;
        end else begin
            RegWriteD_reg = RegWriteD;
            ResultSrcD_reg = ResultSrcD;
            MemWriteD_reg = MemWriteD;
            JumpD_reg = JumpD;
            BranchD_reg = BranchD;
            ALUSrcD_reg = ALUSrcD;
            ALUControlD_reg = ALUControlD;
            RD1D_reg = RD1D;
            RD2D_reg = RD2D;
            ImmExtD_reg = ImmExtD;
            RdD_reg = InstrD[11:7];
            PCD_reg = PCD;
            PCPlus4D_reg = PCPlus4D;
        end
    end
    
    //Pipeline Registers to Output                                      //--Pt.1: Control Unit
    assign JumpE = JumpD_reg;
    assign BranchE = BranchD_reg;
    assign ALUSrcE = ALUSrcD_reg;
    assign MemWriteE = MemWriteD_reg;
    assign RegWriteE = RegWriteD_reg;
    assign ResultSrcE = ResultSrcD_reg;                      
    assign ALUControlE = ALUControlD_reg; 
    assign RD1E = RD1D_reg;
    assign RD2E = RD2D_reg;                                             //--Pt.2: Register File
    assign ImmExtE = ImmExtD_reg;                                       //--Pt.3: Sign Extender
    assign RdE = RdD_reg;                                               //--Pt.4: Fetch -> Decode
    assign PCE = PCD_reg;
    assign PCPlus4E = PCPlus4D_reg; 

endmodule
