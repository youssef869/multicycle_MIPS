module data_path(
input  wire        clk,
input  wire        rst_n,

input  wire        MemtoReg,

input  wire [1:0]  PCSrc,
input  wire        PCEn,
input  wire        IorD,
input  wire        IRwrite,

input  wire        ALUSrcA,
input  wire [1:0]  ALUSrcB,
input  wire [2:0]  ALUControl,

input  wire        RegDst,
input  wire        RegWrite,

output wire [31:0] instr,

input  wire [31:0] Mem_RD,
output wire [31:0] Mem_Addr,
output wire [31:0] Mem_WD,

output wire        zero
);


wire [31:0] PC, PC_bar;
wire [31:0] Data;
wire [4:0] write_addr;
wire [31:0] A_bar, B_bar, write_data;
wire [31:0] A;
wire [31:0] B;
wire [31:0] SrcA, SrcB, ALUResult;
wire [31:0] ALUOut;
wire [31:0] SignImm;
wire [31:0] imm_times_4;
wire [27:0] j_shifter_out;
wire [31:0] PCJump;



enabled_dff #(.WIDTH(32)) PC_reg(
.clk(clk),
.rst_n(rst_n),
.in(PC_bar),
.en(PCEn),
.out(PC)
);



MUX_2x1 #(.WIDTH(32)) Mem_Addr_mux(
.in0(PC),
.in1(ALUOut),
.s(IorD),
.out(Mem_Addr)
);


MUX_4x1 #(.WIDTH(32)) PC_mux(
.in0(ALUResult),
.in1(ALUOut),
.in2(PCJump),
.in3(32'd0),//arbitary value
.sel(PCSrc),
.out(PC_bar)
);

enabled_dff #(.WIDTH(32)) IR(
.clk(clk),
.rst_n(rst_n),
.in(Mem_RD),
.en(IRwrite),
.out(instr)
);


dff #(.WIDTH(32)) Data_reg(
.clk(clk),
.rst_n(rst_n),
.in(Mem_RD),
.out(Data)
);



MUX_2x1 #(.WIDTH(5)) WriteReg_mux (
.in0(instr[20:16]),
.in1(instr[15:11]),
.s(RegDst),
.out(write_addr)
);


MUX_2x1 #(.WIDTH(32)) MemtoReg_mux(
.in0(ALUOut),
.in1(Data),
.s(MemtoReg),
.out(write_data)
);


REG_FILE regfile_u0(
.A1(instr[25:21]),
.A2(instr[20:16]),
.A3(write_addr),
.WE3(RegWrite),
.WD3(write_data),
.CLK(clk),
.RD1(A_bar),
.RD2(B_bar)
);



dff #(.WIDTH(32)) regfile_RDA(
.clk(clk),
.rst_n(rst_n),
.in(A_bar),
.out(A)
);



dff #(.WIDTH(32)) regfile_RDB(
.clk(clk),
.rst_n(rst_n),
.in(B_bar),
.out(B)
);


MUX_2x1 #(.WIDTH(32)) SrcA_mux(
.in0(PC),
.in1(A),
.s(ALUSrcA),
.out(SrcA)
);

MUX_4x1 #(.WIDTH(32)) SrcB_mux(
.in0(B),
.in1(32'd4),
.in2(SignImm),
.in3(imm_times_4),
.sel(ALUSrcB),
.out(SrcB)
);



ALU alu_u0(
.ALU_Control(ALUControl),
.A(SrcA),
.B(SrcB),
.out(ALUResult),
.zero(zero)
);



dff #(.WIDTH(32)) alu_out(
.clk(clk),
.rst_n(rst_n),
.in(ALUResult),
.out(ALUOut)
);


Sign_Extend sign_extend_u0(
.in(instr[15:0]),
.out(SignImm)
);



Shift_Left_2 shifter_u0(
.in(SignImm),
.out(imm_times_4)
);


Shift_Left_2_J shifter_u1(
.in(instr[25:0]),
.out(j_shifter_out)
);


assign PCJump = {PC[31:28],j_shifter_out};
assign Mem_WD = B;

endmodule