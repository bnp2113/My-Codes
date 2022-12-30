`define N 16

module alu(input signed [`N-1:0] a, input signed [`N-1:0] b, input sel, output [31:0] out);
	reg signed [31:0] 	regout;
	//assign out = regout;
	always @(*) begin
		$display("sel is [%h]\n", sel);
		case(sel)
			1'b0: begin
				regout = a + b;
			end
			1'b1: begin
				regout = a * b;
			end
		endcase
	end

	assign out = (sel==0) ? {{14{regout[15]}}, regout[15:0]}:
				 			regout;
			 


endmodule
