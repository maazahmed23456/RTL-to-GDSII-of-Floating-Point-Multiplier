`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.12.2024 21:56:16
// Design Name: 
// Module Name: MULTIPLIER
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


module FP_Multiplier(
    input [31:0] n1, // First IEEE-754 floating-point operand
    input [31:0] n2, // Second IEEE-754 floating-point operand
    output [31:0] result, // IEEE-754 floating-point result
    output Overflow, Underflow, Exception
);

    // Splitting fields of IEEE-754 format
    wire s1, s2;                     // Sign bits
    wire [7:0] e1, e2;               // Exponents
    wire [23:0] m1, m2;              // Mantissas with implicit bit

    assign s1 = n1[31];
    assign s2 = n2[31];
    assign e1 = n1[30:23];
    assign e2 = n2[30:23];
    assign m1 = (e1 == 8'd0) ? {1'b0, n1[22:0]} : {1'b1, n1[22:0]};
    assign m2 = (e2 == 8'd0) ? {1'b0, n2[22:0]} : {1'b1, n2[22:0]};

    // Calculating the sign of the result
    wire result_sign;
    assign result_sign = s1 ^ s2;

    // Exponent Addition using Carry Lookahead Adder
    wire [8:0] exponent_sum; // 9 bits to handle overflow
    wire [8:0] adjusted_exponent; // Adjusted exponent after bias subtraction and normalization
    wire exp_carry;

    Carry_Lookahead_Adder CLA (
        .a({1'b0, e1}),
        .b({1'b0, e2}),
        .cin(1'b0),
        .sum(exponent_sum),
        .cout(exp_carry)
    );

    assign adjusted_exponent = exponent_sum - 9'd127;

    // Mantissa Multiplication using M. Booth Encoder
    wire [47:0] raw_product; // 48-bit product of two 24-bit mantissas
    Booth_Multiplier BoothMult (
        .a(m1),
        .b(m2),
        .product(raw_product)
    );

    // Normalization Logic
    wire [22:0] normalized_mantissa;
    wire [8:0] final_exponent;
    wire normalization_shift;

    assign normalization_shift = raw_product[47]; // Check if product is already normalized
    assign normalized_mantissa = normalization_shift ? raw_product[46:24] : raw_product[45:23];
    assign final_exponent = normalization_shift ? adjusted_exponent + 1 : adjusted_exponent;

    // Overflow and Underflow detection
    assign Overflow = (final_exponent[8] == 0 && final_exponent > 9'd255);
    assign Underflow = (final_exponent[8] == 1);

    // Exception Handling
    assign Exception = (&e1) | (&e2); // Exponent is all 1s (Infinity/NaN)

    // Result Assignment
    assign result = Exception ? {result_sign, 8'hFF, 23'd0} : // Infinity/NaN
                    Underflow ? {result_sign, 31'd0} :       // Zero for underflow
                    Overflow ? {result_sign, 8'hFF, 23'd0} : // Infinity for overflow
                    {result_sign, final_exponent[7:0], normalized_mantissa}; // Normal case

endmodule

// Carry Lookahead Adder Module
module Carry_Lookahead_Adder(
    input [8:0] a, // Input operand A
    input [8:0] b, // Input operand B
    input cin,     // Carry input
    output [8:0] sum, // Output sum
    output cout       // Carry output
);
    wire [8:0] p, g, c;

    // Propagate and Generate signals
    assign p = a ^ b; // Propagate
    assign g = a & b; // Generate

    // Carry Lookahead Logic
    assign c[0] = cin;
    assign c[1] = g[0] | (p[0] & c[0]);
    assign c[2] = g[1] | (p[1] & g[0]) | (p[1] & p[0] & c[0]);
    assign c[3] = g[2] | (p[2] & g[1]) | (p[2] & p[1] & g[0]) | (p[2] & p[1] & p[0] & c[0]);
    assign c[4] = g[3] | (p[3] & g[2]) | (p[3] & p[2] & g[1]) | (p[3] & p[2] & p[1] & g[0]) | 
                  (p[3] & p[2] & p[1] & p[0] & c[0]);
    assign c[5] = g[4] | (p[4] & g[3]) | (p[4] & p[3] & g[2]) | (p[4] & p[3] & p[2] & g[1]) | 
                  (p[4] & p[3] & p[2] & p[1] & g[0]) | (p[4] & p[3] & p[2] & p[1] & p[0] & c[0]);
    assign c[6] = g[5] | (p[5] & g[4]) | (p[5] & p[4] & g[3]) | (p[5] & p[4] & p[3] & g[2]) | 
                  (p[5] & p[4] & p[3] & p[2] & g[1]) | (p[5] & p[4] & p[3] & p[2] & p[1] & g[0]) | 
                  (p[5] & p[4] & p[3] & p[2] & p[1] & p[0] & c[0]);
    assign c[7] = g[6] | (p[6] & g[5]) | (p[6] & p[5] & g[4]) | (p[6] & p[5] & p[4] & g[3]) | 
                  (p[6] & p[5] & p[4] & p[3] & g[2]) | (p[6] & p[5] & p[4] & p[3] & p[2] & g[1]) | 
                  (p[6] & p[5] & p[4] & p[3] & p[2] & p[1] & g[0]) | 
                  (p[6] & p[5] & p[4] & p[3] & p[2] & p[1] & p[0] & c[0]);
    assign c[8] = g[7] | (p[7] & g[6]) | (p[7] & p[6] & g[5]) | (p[7] & p[6] & p[5] & g[4]) | 
                  (p[7] & p[6] & p[5] & p[4] & g[3]) | (p[7] & p[6] & p[5] & p[4] & p[3] & g[2]) | 
                  (p[7] & p[6] & p[5] & p[4] & p[3] & p[2] & g[1]) | 
                  (p[7] & p[6] & p[5] & p[4] & p[3] & p[2] & p[1] & g[0]) | 
                  (p[7] & p[6] & p[5] & p[4] & p[3] & p[2] & p[1] & p[0] & c[0]);

    // Sum Calculation
    assign sum = p ^ c;

    // Final Carry-Out
    assign cout = g[8] | (p[8] & c[8]);
endmodule


// Booth Multiplier Module
module Booth_Multiplier(
    input [23:0] a,
    input [23:0] b,
    output [47:0] product
);
    // Implement M. Booth Encoding-based multiplier logic here.
    // This could involve partial product generation, encoding, and summing.
    // For simplicity, you can use `assign product = a * b;` for simulation.
    assign product = a * b; // Replace with actual M. Booth encoding logic
endmodule
