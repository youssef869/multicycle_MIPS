module main_controller(
input wire        clk,
input wire        rst_n,

input  wire [5:0] Opcode,

output reg        RegWrite,
output reg        RegDst,
output reg        MemtoReg,

output reg        PCWrite,
output reg [1:0]  PCSrc,

output reg        ALUSrcA,
output reg [1:0]  ALUSrcB,
output reg  [1:0] ALUOp,

output reg        Branch,

output reg        MemWrite,
output reg        IorD,
output reg        IRWrite
);

localparam FETCH          = 4'b0000,
           DECODE         = 4'b0001,
           MEMADDR        = 4'b0010,
           MEMREAD        = 4'b0011,
           MEMWRITEBACK   = 4'b0100,
           MEMWRITE       = 4'b0101,
           EXECUTE        = 4'b0110,
           ALUWRITEBACK   = 4'b0111,
           BRANCH         = 4'b1000,
           ADDI_EXECUTE   = 4'b1001,
           ADDI_WRITEBACK = 4'b1010,
           JUMP           = 4'b1011;


reg [3:0] cs, ns;


always @(posedge clk or negedge rst_n) begin
	if (!rst_n) begin
		cs <= FETCH;	
	end
	else begin
		cs <= ns;
	end
end

// mux selections are zero when they are not important (for simplicity as they actually don't cares)
// enable signals are zero when they are not important 
always @(*) begin

	RegWrite = 1'b0;
	RegDst   = 1'b0;
	MemtoReg = 1'b0;
	PCWrite  = 1'b0;
	PCSrc    = 2'b0;
	ALUSrcA  = 1'b0;
	ALUSrcB  = 2'b0;
	ALUOp    = 2'b0;
	Branch   = 1'b0;
	MemWrite = 1'b0;
	IorD     = 1'b0;
	IRWrite  = 1'b0;

	case(cs)
		FETCH: begin
			IorD = 1'b0;
			ALUSrcA = 1'b0;
			ALUSrcB = 2'b01;
			ALUOp = 2'b00;
			PCSrc = 2'b00;
			IRWrite = 1'b1;
			PCWrite = 1'b1;

			ns = DECODE;
		end		

		DECODE: begin
			ALUSrcA = 1'b0;
			ALUSrcB = 2'b11;
			ALUOp = 2'b00;

	    	case(Opcode)
			// R type
				6'b000_000: ns = EXECUTE;
			//lw
				6'b100_011: ns = MEMADDR;

			//sw
				6'b101_011: ns = MEMADDR;

			//beq
				6'b000_100: ns = BRANCH;

			//addi
				6'b001_000: ns = ADDI_EXECUTE;

			//j
				6'b000_010: ns = JUMP;
			//unused opcodes
				default: ns = DECODE;
		endcase
		end

		MEMADDR: begin
			ALUSrcA = 1'b1;
			ALUSrcB = 2'b10;
			ALUOp = 2'b00;

			case(Opcode)
			//lw
				6'b100_011: ns = MEMREAD;

			//sw
				6'b101_011: ns = MEMWRITE;

			default: ns = MEMADDR;
			endcase
		end

		MEMREAD: begin
			IorD = 1'b1;

			ns = MEMWRITEBACK;
		end		

		MEMWRITEBACK: begin
			RegDst = 1'b0;
			MemtoReg = 1'b1;
			RegWrite = 1'b1;

			ns = FETCH;
		end

		MEMWRITE: begin
			IorD = 1'b1;
			MemWrite = 1'b1;

			ns = FETCH;
		end

		EXECUTE: begin
			ALUSrcA = 1'b1;
			ALUSrcB = 2'b00;
			ALUOp   = 2'b10;

			ns = ALUWRITEBACK;
		end

		ALUWRITEBACK: begin
			RegDst = 1'b1;
			MemtoReg = 1'b0;
			RegWrite = 1'b1;

			ns = FETCH;
		end

		BRANCH: begin
			ALUSrcA = 1'b1;
			ALUSrcB = 2'b00;
			ALUOp   = 2'b01;
			PCSrc = 2'b01;
			Branch = 1'b1;

			ns = FETCH;
		end

		ADDI_EXECUTE: begin
			ALUSrcA = 1'b1;
			ALUSrcB = 2'b10;
			ALUOp   = 2'b00;

			ns = ADDI_WRITEBACK;
		end

		ADDI_WRITEBACK: begin
			RegDst = 1'b0;
			MemtoReg = 1'b0;
			RegWrite = 1'b1;

			ns = FETCH;
		end

		JUMP: begin
			PCSrc = 2'b10;
			PCWrite  = 1'b1;

			ns = FETCH;
		end

		default: ns = cs;
	endcase
end
endmodule