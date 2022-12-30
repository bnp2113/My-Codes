`timescale 1ns/1ps
`define HALF_CLOCK_PERIOD #100

module fir_imem (Q, resetn, CLK, CEN, WEN, A, D);
	output reg [15:0] Q;
	input CLK;
	input CEN;
	input WEN;
	input resetn;
	input [15:0] D;
	input [13:0] A;
	
	reg [19:0] subCEN;
	reg [19:0] subWEN;
	
	wire [15:0] subQ [19:0];
	reg [15:0] subD [19:0];
	
	IMEM imem0 (.Q(subQ[0]), .CLK(CLK), .CEN(subCEN[0]), .WEN(subWEN[0]), .A(A[8:0]), .D(subD[0]));
	IMEM imem1 (.Q(subQ[1]), .CLK(CLK), .CEN(subCEN[1]), .WEN(subWEN[1]), .A(A[8:0]), .D(subD[1]));
	IMEM imem2 (.Q(subQ[2]), .CLK(CLK), .CEN(subCEN[2]), .WEN(subWEN[2]), .A(A[8:0]), .D(subD[2]));
	IMEM imem3 (.Q(subQ[3]), .CLK(CLK), .CEN(subCEN[3]), .WEN(subWEN[3]), .A(A[8:0]), .D(subD[3]));
	IMEM imem4 (.Q(subQ[4]), .CLK(CLK), .CEN(subCEN[4]), .WEN(subWEN[4]), .A(A[8:0]), .D(subD[4]));
	IMEM imem5 (.Q(subQ[5]), .CLK(CLK), .CEN(subCEN[5]), .WEN(subWEN[5]), .A(A[8:0]), .D(subD[5]));
	IMEM imem6 (.Q(subQ[6]), .CLK(CLK), .CEN(subCEN[6]), .WEN(subWEN[6]), .A(A[8:0]), .D(subD[6]));
	IMEM imem7 (.Q(subQ[7]), .CLK(CLK), .CEN(subCEN[7]), .WEN(subWEN[7]), .A(A[8:0]), .D(subD[7]));
	IMEM imem8 (.Q(subQ[8]), .CLK(CLK), .CEN(subCEN[8]), .WEN(subWEN[8]), .A(A[8:0]), .D(subD[8]));
	IMEM imem9 (.Q(subQ[9]), .CLK(CLK), .CEN(subCEN[9]), .WEN(subWEN[9]), .A(A[8:0]), .D(subD[9]));
	
	IMEM imem10 (.Q(subQ[10]), .CLK(CLK), .CEN(subCEN[10]), .WEN(subWEN[10]), .A(A[8:0]), .D(subD[10]));
	IMEM imem11 (.Q(subQ[11]), .CLK(CLK), .CEN(subCEN[11]), .WEN(subWEN[11]), .A(A[8:0]), .D(subD[11]));
	IMEM imem12 (.Q(subQ[12]), .CLK(CLK), .CEN(subCEN[12]), .WEN(subWEN[12]), .A(A[8:0]), .D(subD[12]));
	IMEM imem13 (.Q(subQ[13]), .CLK(CLK), .CEN(subCEN[13]), .WEN(subWEN[13]), .A(A[8:0]), .D(subD[13]));
	IMEM imem14 (.Q(subQ[14]), .CLK(CLK), .CEN(subCEN[14]), .WEN(subWEN[14]), .A(A[8:0]), .D(subD[14]));
	IMEM imem15 (.Q(subQ[15]), .CLK(CLK), .CEN(subCEN[15]), .WEN(subWEN[15]), .A(A[8:0]), .D(subD[15]));
	IMEM imem16 (.Q(subQ[16]), .CLK(CLK), .CEN(subCEN[16]), .WEN(subWEN[16]), .A(A[8:0]), .D(subD[16]));
	IMEM imem17 (.Q(subQ[17]), .CLK(CLK), .CEN(subCEN[17]), .WEN(subWEN[17]), .A(A[8:0]), .D(subD[17]));
	IMEM imem18 (.Q(subQ[18]), .CLK(CLK), .CEN(subCEN[18]), .WEN(subWEN[18]), .A(A[8:0]), .D(subD[18]));
	IMEM imem19 (.Q(subQ[19]), .CLK(CLK), .CEN(subCEN[19]), .WEN(subWEN[19]), .A(A[8:0]), .D(subD[19]));
	
	
	always @(posedge CLK) begin
		if (~resetn) begin
			subCEN <= {20{1'b1}};
			subWEN <= {20{1'b1}};
		end
		case (A[13:9])
			0: begin
			    #0.5;
				subCEN[0] 	<= CEN;
				subWEN[0] 	<= WEN;
				#0.5;
				subD[0] 	<= D;
				Q			<= subQ[0];
			end
			
			1: begin
				#0.5;
				subCEN[1] 	<= CEN;
				subWEN[1] 	<= WEN;
				#0.5;
				subD[1] 	<= D;
				Q			<= subQ[1];
			end
			2: begin
				#0.5;
				subCEN[2] 	<= CEN;
				subWEN[2] 	<= WEN;
				#0.5;
				subD[2] 	<= D;
				Q			<= subQ[2];
			end
			
			3: begin
				#0.5;
				subCEN[3] 	<= CEN;
				subWEN[3] 	<= WEN;
				#0.5;
				subD[3] 	<= D;
				Q			<= subQ[3];
			end
			
			4: begin
				#0.5;
				subCEN[4] 	<= CEN;
				subWEN[4] 	<= WEN;
				#0.5;
				subD[4] 	<= D;
				Q			<= subQ[4];
			end
			
			5: begin
				#0.5;
				subCEN[5] 	<= CEN;
				subWEN[5] 	<= WEN;
				#0.5;
				subD[5] 	<= D;
				Q			<= subQ[5];
			end
			6: begin
				#0.5;
				subCEN[6] 	<= CEN;
				subWEN[6] 	<= WEN;
				#0.5;
				subD[6] 	<= D;
				Q			<= subQ[6];
			end
			7: begin
				
				#0.5;
				subCEN[7] 	<= CEN;
				subWEN[7] 	<= WEN;
				#0.5;
				subD[7] 	<= D;
				Q			<= subQ[7];
			end
			8: begin
				#0.5;
				subCEN[8] 	<= CEN;
				subWEN[8] 	<= WEN;
				#0.5;
				subD[8] 	<= D;
				Q			<= subQ[8];
			end
			9: begin
				#0.5;
				subCEN[9] 	<= CEN;
				subWEN[9] 	<= WEN;
				#0.5;
				subD[9] 	<= D;
				Q			<= subQ[9];
			end
			10: begin
				#0.5;
				subCEN[10] 	<= CEN;
				subWEN[10] 	<= WEN;
				#0.5;
				subD[10] 	<= D;
				Q			<= subQ[10];
			end
			11: begin
				subCEN[11] 	<= CEN;
				subWEN[11] 	<= WEN;
				subD[11] 	<= D;
				Q			<= subQ[11];
			end
			12: begin
				subCEN[12] 	<= CEN;
				subWEN[12] 	<= WEN;
				subD[12] 	<= D;
				Q			<= subQ[12];
			end
			13: begin
				subCEN[13] 	<= CEN;
				subWEN[13] 	<= WEN;
				subD[13] 	<= D;
				Q			<= subQ[13];
			end
			14: begin
				subCEN[14] 	<= CEN;
				subWEN[14] 	<= WEN;
				subD[14] 	<= D;
				Q			<= subQ[14];
			end
			15: begin
				subCEN[15] 	<= CEN;
				subWEN[15] 	<= WEN;
				subD[15] 	<= D;
				Q			<= subQ[15];
			end
			16: begin
				subCEN[16] 	<= CEN;
				subWEN[16] 	<= WEN;
				subD[16] 	<= D;
				Q			<= subQ[16];
			end
			17: begin
				subCEN[17] 	<= CEN;
				subWEN[17] 	<= WEN;
				subD[17] 	<= D;
				Q			<= subQ[17];
			end
			18: begin
				subCEN[18] 	<= CEN;
				subWEN[18] 	<= WEN;
				subD[18] 	<= D;
				Q			<= subQ[18];
			end
			
			19: begin
				#0.5;
				subCEN[19] 	<= CEN;
				subWEN[19] 	<= WEN;
				#0.5;
				subD[19] 	<= D;
				Q			<= subQ[19];
			end
		endcase
	end
endmodule
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
