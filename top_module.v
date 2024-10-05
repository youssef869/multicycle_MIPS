module top_module(
input wire clk,
input wire rst_n,

output wire [31:0] Mem_Addr,
output wire [31:0] Mem_RD
);

wire [31:0] instr, Mem_WD;
wire zero, RegWrite, RegDst, MemtoReg, PCEn, ALUSrcA, Branch, MemWrite, IorD, IRwrite;
wire [1:0] PCSrc, ALUSrcB;
wire [2:0] ALUControl;


data_path dp_u0(
.clk(clk),
.rst_n(rst_n),
.MemtoReg(MemtoReg),
.PCSrc(PCSrc),
.PCEn(PCEn),
.IorD(IorD),
.IRwrite(IRwrite),
.ALUSrcA(ALUSrcA),
.ALUSrcB(ALUSrcB),
.ALUControl(ALUControl),
.RegDst(RegDst),
.RegWrite(RegWrite),
.instr(instr),
.Mem_RD(Mem_RD),
.Mem_Addr(Mem_Addr),
.Mem_WD(Mem_WD),
.zero(zero)
);


Control_Unit cu_u0(
.clk(clk),
.rst_n(rst_n),
.Opcode(instr[31:26]),
.Funct(instr[5:0]),
.zero(zero),
.RegWrite(RegWrite),
.RegDst(RegDst),
.MemtoReg(MemtoReg),
.PCEn(PCEn),
.PCSrc(PCSrc),
.ALUSrcA(ALUSrcA),
.ALUSrcB(ALUSrcB),
.ALUControl(ALUControl),
.Branch(Branch),
.MemWrite(MemWrite),
.IorD(IorD),
.IRWrite(IRwrite)
);


Memory mem_u0(
.A({Mem_Addr[6:2] ,2'b00}),//word aligned
.clk(clk),
.WE(MemWrite),
.WD(Mem_WD),
.RD(Mem_RD)
);

endmodule