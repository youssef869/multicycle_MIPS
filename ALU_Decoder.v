module ALU_Decoder(
input  wire [5:0] funct,
input  wire [1:0] ALUOp,
output reg  [2:0] ALUControl
);


always @(*) begin
	case(ALUOp)
		2'b00: ALUControl = 3'b010;
		2'b01: ALUControl = 3'b110;
		2'b10: begin 
			case(funct[3:0])
				4'b0000: ALUControl = 3'b010;
				4'b0010: ALUControl = 3'b110;
				4'b0100: ALUControl = 3'b000;
				4'b0101: ALUControl = 3'b001;
				4'b1010: ALUControl = 3'b111;
				default: ALUControl = 3'b011; //not used in ALU
			endcase
		end

		default: ALUControl = 3'b011; //not used in ALU
	endcase
end
endmodule