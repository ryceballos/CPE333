`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/25/2024 04:18:36 PM
// Design Name: 
// Module Name: Register
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


module Register(
    input REG_EN,
    input CLK,
    input [31:0] REG_Instruction,
    input [4:0] REG_ADR1,                
    input [4:0] REG_ADR2,
    input [4:0] REG_W_ADR,
    input [31:0] REG_W_DATA,
    output [31:0] REG_RS1,
    output [31:0] REG_RS2
    );
    
    logic [31:0] address [0:31];
    
    //Initialize 32 empty addresses while keeping address 0, 0
    initial begin
        int i;
        address[0] = 0;
        for (i = 1; i < 32; i = i+1) begin
            address[i] = 0;                     //Empty values
        end
    end
    
    assign REG_ADR1 = REG_Instruction[19:15];
    assign REG_ADR2 = REG_Instruction[24:20];
    
    assign REG_RS1 = address[REG_ADR1];
    assign REG_RS2 = address[REG_ADR2];
    
    //Synchronously save data
    always_ff@ (posedge CLK) begin
        if (REG_EN) begin
            if (REG_W_ADR != 0) begin           //If address is not x0, save data in specified location
                address[REG_W_ADR] = REG_W_DATA;
            end else begin                      //If address is x0, value remains 0
                address[REG_W_ADR] = 0;
            end
        end
    end
    
endmodule