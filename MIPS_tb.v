`timescale 1ns/1ps
module MIPS_tb();

reg         clk_tb;
reg         rst_n_tb;

wire [31:0] Mem_Addr_tb;
wire [31:0] Mem_RD_tb;

parameter CLK_PERIOD = 10;
parameter INSTRUCTIONS_COUNT = 18; //number of instructions in the program

//note that first "INSTRUCTIONS_COUNT" words for the memory will be for instructions, remaining words will be for data.

top_module DUT(
.clk(clk_tb),
.rst_n(rst_n_tb),
.Mem_Addr(Mem_Addr_tb),
.Mem_RD(Mem_RD_tb)
);


always #(CLK_PERIOD/2) clk_tb = ~clk_tb;

initial begin
	$dumpfile("MIPS.vcd");
	$dumpvars;
	initialize();
	reset();
	run();
	$stop;
end

task initialize ;
begin
	clk_tb   = 1'b0;
	rst_n_tb = 1'b1;
	$readmemh("instructions.dat", DUT.mem_u0.mem);
end
endtask

task reset ;
begin
	rst_n_tb = 1'b1;
	#(CLK_PERIOD);
	rst_n_tb = 1'b0;
	#(CLK_PERIOD);
	rst_n_tb = 1'b1;
end
endtask


task run ;
begin
	$display("********** Program starts **********");
	#(INSTRUCTIONS_COUNT * CLK_PERIOD * 5);
	$display("********** Program ends   **********");
end
endtask

endmodule