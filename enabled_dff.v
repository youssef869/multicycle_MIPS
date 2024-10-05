module enabled_dff #(parameter WIDTH = 32)(
input  wire              clk,
input  wire              rst_n,
input  wire [WIDTH-1: 0] in,
input  wire              en,
output reg  [WIDTH-1: 0] out
);

always @(posedge clk, negedge rst_n) begin
	if(!rst_n) begin
		out <= 'd0;
	end
	else if(en) begin
		out <= in;
	end
end
endmodule