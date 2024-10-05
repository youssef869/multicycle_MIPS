module REG_FILE (
input  wire [4:0]   A1,
input  wire [4:0]   A2,
input  wire [4:0]   A3,

input  wire         WE3,
input  wire [31:0]  WD3,

input  wire         CLK,

output  wire [31:0]  RD1,
output  wire [31:0]  RD2
);


reg [31:0] Reg_File [0: 31];

assign RD1 = (A1 == 0) ? 0: Reg_File[A1];
assign RD2 = (A2 == 0) ? 0: Reg_File[A2];

integer i;
always @(posedge CLK) begin

	if (WE3) begin
		Reg_File[A3] <= WD3;
	end 

end
endmodule