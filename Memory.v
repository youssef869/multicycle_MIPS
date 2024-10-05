module Memory(
input  wire [6:0] A,

input  wire clk,
input  wire WE,

input  wire [31:0] WD,

output wire [31:0] RD
);

parameter DEPTH = 128*4;

reg [7:0] mem [0: DEPTH - 1];

assign RD = {mem[A+3],mem[A+2],mem[A+1],mem[A]};//byte addressable

always @(posedge clk) begin
	if(WE) begin
		{mem[A+3],mem[A+2],mem[A+1],mem[A]} <= WD;//byte addressable
	end
end
endmodule