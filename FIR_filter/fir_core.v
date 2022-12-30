`timescale 1ns/1ps
`define HALF_CLOCK_PERIOD #200


module fir_core(clk, resetn, din, addr, dload, cload, mul_en, acc_en, dout);
	input 				clk;
	input 				resetn;
	input 		[15:0] 	din;
	input		[13:0]	addr;
	input 		[1:0]	dload; //maybe more than 1 bit
	input				cload; //same
	input				mul_en;
	input				acc_en;
	output reg 	[31:0] 	dout;
	
	reg 		[15:0]	buff [63:0];
	reg 		[15:0] 	cmem [63:0];
	reg 		[31:0]	acc [63:0];
	wire 		[15:0]	temp_input;
	integer 			i;
	localparam SF1 = 2.0 ** - 11.0;  //for showing results of Q5.11
	localparam SF2 = 2.0 ** - 22.0;  //for showing results of Q10.22
	//CMEM cmem0 (.Q(temp_coef), .CLK(CLK), .CEN(cload[1]), .WEN(cload[0]), .A(cmem_add), .D(din));
	fir_imem imem0 (	.Q(temp_input), .resetn(resetn), .CLK(clk), .CEN(dload[1]), .WEN(dload[0]),
						.A(addr), .D(din));      //note
	
	always @(posedge clk) begin
		if (~resetn) begin
			for (i = 0; i < 64; i = i + 1) begin
				buff[i] = #10 {16{1'b0}};
				cmem[i] = #10 {16{1'b0}};
				acc[i] = #10 {16{1'b0}};

			end
			dout = 0;
			//temp_input = 0;

	end

		// write phase
		if (cload) begin
			//$display("module, din is [%f]\n", $itor(din *SF1));
			cmem[addr[5:0]] = #10 din;
			//$display("cmem is [%f]\n", $itor(cmem[addr[5:0]] *SF1));
			#10;

		end

		// multiplication phase
		/* 
		if (mul_en) begin
			for (i = 0; i < 64; i = i + 1) begin 
				///set addres to retrieve data in to temp reg
				//cmem_add = i;
				regfile[i] <= temp_input * cmem[i];
				//$display("regfile[%d] is [%b]\n", i, $itor(regfile[i] * SF2));
				//$display("[%f] * [%f] = [%f]\n", $itor(temp_input*SF2), 
				//							$itor(cmem[i]*SF2), $itor(regfile[i]*SF2));
			end
		end

		//accu
		if (acc_en) begin
			for (i = 0; i < 64; i = i + 1) begin
				#25;
				dout <= dout + regfile[i];
				$display("regfile[%d] is : [%f], dout is: [%f] \n", i, $itor(regfile[i]*SF2), $itor(dout*SF2));
			end
		end
		*/
	end
	/* circular buffer ring
	 */
	always @(posedge clk) begin
		if (en_buf) begin
			buff[0] <= temp_input;
			for (i = 1; i < 64; i = i + 1) begin
				buff[i] <= buff[i - 1];
			end
		end else begin
			for (i = 0; i < 64; i = i + 1) begin
				buff[i] <= buff[i];
			end
		end
	end

	always @(posedge clk) begin
		if (en_fir) begin
			for (i = 0; i < 64; i = i + 1) begin
				acc[i] <= cmem[i] * buff[i];
			end
		end
	end

	always @(posedge clk) begin
		if (en_fir) begin
			for (i = 0; i < 64; i = i + 1) begin
				dout <= dout + acc[i];
			end
		end
	end
endmodule
