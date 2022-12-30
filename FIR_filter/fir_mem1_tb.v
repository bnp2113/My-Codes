`timescale 1ns/1ps
`define HALF_CLOCK_PERIOD #500

module fir_mem1_tb;
	wire [15:0]	Q;
	reg			CLK;
	reg			CEN;
	reg			WEN;
	reg [5:0]	A;
	reg [15:0]	D;
	
	integer i, read_d;
	
	fir_mem1 dut(Q, CLK, CEN, WEN, A, D);
	
	always begin
		`HALF_CLOCK_PERIOD;
		CLK = ~CLK;
	end
	
	initial begin
		CLK <= 0;
		CEN = #2 1;
		WEN = #2 1;
		@(negedge CLK);
		@(posedge CLK);
		
		@(posedge CLK);
		
		WEN = 0;
		CEN = 0;
		
		for (i = 0; i < 5; i = i + 1) begin
			A = #5 i * 3;
			@(negedge CLK);
			D = #7 $urandom % 1000;
			@(posedge CLK);
		end
		repeat (2) @(posedge CLK);
		
		WEN = 1;
		@(posedge CLK);
		
		for (i = 0; i < 5; i = i + 1) begin
			A = #5 i * 3;
			@(posedge CLK);
			read_d = #20 Q;
			$display("read_d is [%d]\n", read_d);
			@(posedge CLK);
			
		end
		
		repeat (2) @(posedge CLK);
		$finish;
	end
endmodule
		
		
		
		
		
		
		
	
