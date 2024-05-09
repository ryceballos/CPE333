`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/02/2024 07:11:38 PM
// Design Name: 
// Module Name: ArithmeticLogicUnit
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments: Logic found at MariaImplementations_Ch7.pdf pg. 10
// 
//////////////////////////////////////////////////////////////////////////////////


module ArithmeticLogicUnit(
    input [31:0] ALU_SRC_A,
    input [31:0] ALU_SRC_B,
    input [2:0] ALU_FUN,                                                        //Originally 4 bits now it's 3
    output ALU_zero,
    output logic [31:0] ALU_result
    );
    
    always_comb begin
        case (ALU_FUN)
            3'b000: ALU_result = $signed(ALU_SRC_A) + $signed(ALU_SRC_B);      //Add
            3'b001: ALU_result = $signed(ALU_SRC_A) - $signed(ALU_SRC_B);      //Subtract
            3'b011: ALU_result = ALU_SRC_A | ALU_SRC_B;                        //Or
            3'b010: ALU_result = ALU_SRC_A & ALU_SRC_B;                        //And
            /*4'b0100: ALU_result = ALU_SRC_A ^ ALU_SRC_B;                        //Xor
            4'b0101: ALU_result = ALU_SRC_A >> ALU_SRC_B[4:0];                  //Srl
            4'b0001: ALU_result = ALU_SRC_A << ALU_SRC_B[4:0];                  //Sll
            4'b1101: ALU_result = $signed(ALU_SRC_A) >>> ALU_SRC_B[4:0];        //Sra*/
            3'b101: ALU_result = $signed(ALU_SRC_A) < $signed(ALU_SRC_B);      //Slt
            /*4'b0011: ALU_result = ALU_SRC_A < ALU_SRC_B;                        //Sltu
            4'b1001: ALU_result = {ALU_SRC_A[31:12], {12{1'b0}}};               //Lui-Copy*/
            default: ALU_result = 32'hbad00bad;
        endcase
    end
    
    assign ALU_zero = (ALU_result == 32'b0);
endmodule
