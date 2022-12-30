`timescale 1ns/1ps
module regfile(input clock, input resetn, input [5:0] address, input en_write, inout [15:0] data);

// Register file storage
reg [15:0] registers[63:0];
integer i;
reg [15:0] out_val;

// Read and write from register file
always @(posedge clock) begin
	if (~resetn) begin
		for (i = 0; i < 64; i = i + 1) begin
			registers[i] <= #0.1 0;
		end
	end else begin
		if (en_write) begin
		    registers[address] <= #0.1 data;
		    $display("regfile module, write address is [%d]\n", address);
		    $display("regfile module, write data is [%d]\n", registers[address]);
		end else begin
		    out_val <= #0.1 registers[address];
		    $display("out_val is : [%d]\n", out_val);
		   end
	end

// Output data if not writing. If we are writing,
// do not drive output pins. This is denoted
// by assigning 'z' to the output pins.
end

assign data = en_write ? 16'bz : out_val;

endmodule
