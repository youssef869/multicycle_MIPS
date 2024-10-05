module Control_Unit(
input wire        clk,
input wire        rst_n,

input  wire [5:0] Opcode,
input  wire [5:0] Funct,

input  wire       zero,

output wire        RegWrite,
output wire        RegDst,
output wire        MemtoReg,

output wire       PCEn,
output wire  [1:0] PCSrc,

output wire        ALUSrcA,
output wire  [1:0] ALUSrcB,
output wire [2:0] ALUControl,

output wire        Branch,

output wire        MemWrite,
output wire        IorD,
output wire        IRWrite
);

wire [1:0] ALUOp;

ALU_Decoder alu_decoder_u0(
.funct(Funct),
.ALUOp(ALUOp),
.ALUControl(ALUControl)
);

main_controller main_controller_u0(
.clk(clk),
.rst_n(rst_n),
.Opcode(Opcode),
.RegWrite(RegWrite),
.RegDst(RegDst),
.MemtoReg(MemtoReg),
.PCWrite(PCWrite),
.PCSrc(PCSrc),
.ALUSrcA(ALUSrcA),
.ALUSrcB(ALUSrcB),
.ALUOp(ALUOp),
.Branch(Branch),
.MemWrite(MemWrite),
.IorD(IorD),
.IRWrite(IRWrite)
);


assign PCEn = PCWrite || (Branch & zero);

endmodule