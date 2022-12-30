`timescale 1ns/1ps
`define HALF_CLOCK_PERIOD #100

module fir_mem1 (Q, CLK, CEN, WEN, A, D);
	output [15:0]            Q;
	input                    CLK;
	input                    CEN;
	input                    WEN;
	input [5:0]              A;
	input [15:0]             D;
	
	CMEM imem0 (.Q(Q), .CLK(CLK), .CEN(CEN), .WEN(WEN), .A(A), .D(D));

endmodule
