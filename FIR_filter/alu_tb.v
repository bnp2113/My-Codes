`timescale 1ns/1ps
`define N 16
`define MATLAB_INPUTS "../../matlab/matlab_fir_input.txt"
`define MATLAB_COEFS "../../matlab/matlab_fir_coefs.txt"

module alu_tb();
	reg signed [`N-1:0] 	a, b;
	reg 	 				sel;
	wire [31:0] 			out;

	reg signed [31:0]		alu_out;
	integer 				matlab_inputs, matlab_coefs, i, retval;
	localparam SF1 = 2.0 ** - 11.0;
	localparam SF2 = 2.0 ** - 22.0;

	alu dut(.a(a), .b(b), .sel(sel), .out(out));

	initial begin
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
		for (i = 0; i < 64; i = i + 1) begin
			sel = (i % 2) ? 1 : 0;
			retval = $fscanf(matlab_inputs, "%b\n", a);
			retval = $fscanf(matlab_coefs, "%b\n", b);
			#50;
			alu_out = out;
			if (sel) 
				$display("[%f] * [%f] = [%f]\n", $itor(a*SF1), $itor(b*SF1), $itor(alu_out*SF2));
			else 
				$display("[%f] + [%f] = [%f]\n", $itor(a*SF1), $itor(b*SF1), $itor(alu_out*SF1));

		end
		$fclose(matlab_inputs);
		$fclose(matlab_coefs);
		$finish;
	end
endmodule
