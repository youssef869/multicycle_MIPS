module ALU(
input  wire [2:0] ALU_Control,

input  wire [31:0] A,
input  wire [31:0] B,

output reg  [31:0] out,
output wire        zero       
);


assign zero = (out == 32'b0);

always @(*) begin
	case(ALU_Control)
		3'b000:  out = A & B;
		3'b001:  out = A | B;
		3'b010:  out = A + B;
		3'b110:  out = A - B;
		3'b111:  out = A < B;
		default: out = 32'b0;
	endcase
end
endmodule