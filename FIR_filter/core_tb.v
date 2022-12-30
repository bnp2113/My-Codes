`timescale 1ns/1ps
`define HALF_CLOCK_PERIOD #100
`define MATLAB_INPUTS "../../matlab/matlab_fir_input.txt"
`define MATLAB_COEFS "../../matlab/matlab_fir_coefs.txt"

module core_tb();
	reg clk;
	reg resetn;
	reg [15:0] 	din;
	reg	[13:0]	addr;
	reg [1:0]	dload; //maybe more than 1 bit
	reg			cload; //same
	reg			mul_en;
	reg			acc_en;
	wire [31:0] dout;
	integer 	matlab_inputs, matlab_coefs, i, j, retval;
	
	//wire unsigned [15:0] a;
	reg [4:0] block_sel;
	reg [8:0] block_add;
	localparam SF1 = 2.0 ** - 11.0;  //for showing results of Q5.11
	localparam SF2 = 2.0 ** - 22.0;  //for showing results of Q10.22
	
	
	fir_core dut(clk, resetn, din, addr, dload, cload, mul_en, acc_en, dout);
	
	always begin
		`HALF_CLOCK_PERIOD;
		clk = ~clk;
	end
	
	initial begin
		// I/O
		matlab_inputs = $fopen(`MATLAB_INPUTS, "rb");
		if (!matlab_inputs) begin
			$display("Couldn't open the matlab input file.");
			$finish;
		end

		matlab_coefs = $fopen(`MATLAB_COEFS, "rb");
		if (!matlab_coefs) begin
			$display("Couldn't open the matlab coefs file.");
			$finish;
		end
		
		{clk, din, addr, mul_en, cload, acc_en} = {34{1'b0}};
		dload = 2'b11;
		resetn = 0;
		@(posedge clk);
		@(negedge clk);
		resetn = 1;
		
		@(posedge clk);
		
		/* done with set up
		 * start writing input data into IMEM
		 */
		dload = 2'b00;
		#25;
		for (i = 0; i < 19; i = i + 1) begin
			block_sel = i;
			for (j = 0; j < 512; j = j + 1) begin
				block_add = j;
				#25;
				@(posedge clk);
				#25;
				addr = {block_sel, block_add};
				@(negedge clk);
				#25;
				retval = $fscanf(matlab_inputs, "%b\n", din);
				@(posedge clk);
				#100;
			end
		end
		#25;
		block_add = 19;
		for (j = 0; j < 272; j = j + 1) begin
			#25;
			block_add = j;
			@(posedge clk);
			#25;
			addr = {block_sel, block_add};
			@(negedge clk);
			#25;
			retval = $fscanf(matlab_inputs, "%b\n", din);
			@(posedge clk);
			#100;
		end
		
		@(posedge clk);
		dload = 2'b11;
		cload = 1;
		#25;
		//@(posedge clk);
		
		/* write to "cmem" */
		for (i = 0; i < 64; i = i + 1) begin
			addr = i;
			#10;
			retval = $fscanf(matlab_coefs, "%b\n", din);
			#10
			//$display("tb [%d], din : [%f]\n", i, $itor(din * SF1));
			#10;
			@(posedge clk);
		end
		
		
		/* done with loading, start multiplication now 
		 * set IMEM to output is available
		 * enable mul_en
		 */
		@(posedge clk);
		cload = 0;
		#25;
		dload = 2'b01;
		block_sel = 0;
		block_add = 65;
		addr = {block_sel, block_add};
		#25;
		
		
		@(posedge clk);
		mul_en = 1;
		//@(posedge clk);
		#25;
		
		
		@(posedge clk);
		mul_en = 0;
		#25
		dload = 2'b11;
		acc_en = 1;
		@(posedge clk);
		#25;
		repeat(8) @(posedge clk);
		$display("result is [%f]\n", $itor(dout*SF2));

		
		$fclose(matlab_inputs);
		$fclose(matlab_coefs);
		$finish;
	end
endmodule

	
	
	
