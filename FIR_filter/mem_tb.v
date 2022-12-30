`timescale 1ns/100ps
`define HALF_CLOCK_PERIOD #100

module mem_tb;
	reg 		CLK;
	reg			CEN;
	reg			WEN;
	reg			resetn;
	reg [4:0] 	block_sel;
	reg [8:0] 	block_add;
	reg [15:0] 	D;
	reg [13:0] 	A;
	wire [15:0]	Q;
	
	integer read_from, i;
	
	fir_imem dut(Q, resetn, CLK, CEN, WEN, A, D);
	
	always begin
		`HALF_CLOCK_PERIOD;
		CLK = ~CLK;
	end
	
	initial begin
		{CLK, D} = {17{1'b0}};
		{CEN, WEN} = {2{1'b1}};
		resetn = 0;
		repeat(2) @(posedge CLK);	
		resetn = 1;
		
		/*@(posedge CLK);
		//begins here
		// write 45 to address 7 @ block 0
		WEN 	<= 0;
		CEN 	<= 0;
		A 		<= 14'b00000000000111;
		D 		<= 45;
		
		// read from address 7 @ block 0
		repeat(2) @(posedge CLK);
		WEN 	<= 1;		
		A 		<= 14'b00000000000111;
		repeat(2) @(posedge CLK);
		read_from = Q;
		$display("read_from is [%h]", read_from);
		
		
		
		@(posedge CLK);
		//begins here
		// write 69 to address 7 @ block 5
		WEN 	<= 0;
		A 		<= 14'b00101000000111;
		D 		<= 69;
		
		// read from address 7 @ block 5
		repeat(2) @(posedge CLK);
		WEN 		<= 1;		
		A 			<= 14'b00101000000111;
		@(posedge CLK);
		read_from = Q;
		$display("read_from is [%h]", read_from); */
		@(posedge CLK);
		
		#25;
		CEN = 0;
		#25;
		WEN = 0;
		for (i = 0; i < 10; i = i + 1) begin
			@(negedge CLK);
			block_sel 	= i;
			block_add	= i * 3;
			#25;
			A			= {block_sel, block_add};
			#25;
			D 			= 30 + i * 4;
			@(posedge CLK);
			#100;
		end
		@(posedge CLK);
		WEN = 1;
		#25;
		for (i = 0; i < 10; i = i +1) begin
			@(posedge CLK);
			block_sel 	= i;
			block_add	= i * 3;
			#25;
			A			= { block_sel, block_add};
			#25;
			read_from = Q;
			$display("read_from is [%h]", read_from);
		end
		
		repeat(6)@(posedge CLK);
		$finish;
	end
endmodule
