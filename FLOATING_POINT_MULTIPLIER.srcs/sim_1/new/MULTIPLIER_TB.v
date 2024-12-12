`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.12.2024 22:02:30
// Design Name: 
// Module Name: MULTIPLIER_TB
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


module FP_Multiplier_tb;

    // Inputs
    reg [31:0] n1;
    reg [31:0] n2;

    // Outputs
    wire [31:0] result;
    wire Overflow, Underflow, Exception;

    // Instantiate the Unit Under Test (UUT)
    FP_Multiplier uut (
        .n1(n1),
        .n2(n2),
        .result(result),
        .Overflow(Overflow),
        .Underflow(Underflow),
        .Exception(Exception)
    );

    initial begin
        // Monitor the signals
        $monitor($time, " n1=%h, n2=%h, result=%h, Overflow=%b, Underflow=%b, Exception=%b", 
                          n1, n2, result, Overflow, Underflow, Exception);

        // Test Case 1: Normal Multiplication
        n1 = 32'h4c109223; // 
        n2 = 32'h101294a2; // 
        #10;

        // Test Case 2: Multiplication resulting in Overflow
        n1 = 32'h7F800000; // Infinity in IEEE-754
        n2 = 32'h40000000; // 2.0 in IEEE-754
        #10;

        // Test Case 3: Multiplication resulting in Underflow
        n1 = 32'h00000001; // Very small subnormal number
        n2 = 32'h00000001; // Very small subnormal number
        #10;

        // Test Case 4: Multiplication resulting in Exception (NaN)
        n1 = 32'h7FC00000; // NaN in IEEE-754
        n2 = 32'h3F800000; // 1.0 in IEEE-754
        #10;

        // Test Case 5: Multiplication with zero
        n1 = 32'h00000000; // 0.0 in IEEE-754
        n2 = 32'h3F800000; // 1.0 in IEEE-754
        #10;

        // Test Case 6: Negative number multiplication
        n1 = 32'hBF835662; // 
        n2 = 32'h3F822444; // 
        #10;

        // End the simulation
        $stop;
    end

endmodule