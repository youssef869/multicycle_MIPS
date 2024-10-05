onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group {TB SIGNALS} /MIPS_tb/clk_tb
add wave -noupdate -expand -group {TB SIGNALS} /MIPS_tb/rst_n_tb
add wave -noupdate -color Magenta /MIPS_tb/DUT/cu_u0/main_controller_u0/cs
add wave -noupdate -color Magenta /MIPS_tb/DUT/cu_u0/main_controller_u0/ns
add wave -noupdate -expand -group PC /MIPS_tb/DUT/dp_u0/PC
add wave -noupdate -expand -group PC /MIPS_tb/DUT/dp_u0/PC_bar
add wave -noupdate -expand -group PC /MIPS_tb/DUT/dp_u0/PCEn
add wave -noupdate -expand -group PC /MIPS_tb/DUT/dp_u0/PCJump
add wave -noupdate -expand -group PC /MIPS_tb/DUT/dp_u0/PCSrc
add wave -noupdate -expand -group IR /MIPS_tb/DUT/dp_u0/IRwrite
add wave -noupdate -expand -group IR /MIPS_tb/DUT/dp_u0/Mem_RD
add wave -noupdate -expand -group IR /MIPS_tb/DUT/dp_u0/instr
add wave -noupdate -expand -group MEMORY /MIPS_tb/DUT/mem_u0/A
add wave -noupdate -expand -group MEMORY /MIPS_tb/DUT/mem_u0/mem
add wave -noupdate -expand -group MEMORY /MIPS_tb/DUT/mem_u0/RD
add wave -noupdate -expand -group MEMORY /MIPS_tb/DUT/mem_u0/WD
add wave -noupdate -expand -group MEMORY /MIPS_tb/DUT/mem_u0/WE
add wave -noupdate -expand -group {REG FILE} /MIPS_tb/DUT/dp_u0/regfile_u0/A1
add wave -noupdate -expand -group {REG FILE} /MIPS_tb/DUT/dp_u0/regfile_u0/A2
add wave -noupdate -expand -group {REG FILE} /MIPS_tb/DUT/dp_u0/regfile_u0/A3
add wave -noupdate -expand -group {REG FILE} /MIPS_tb/DUT/dp_u0/regfile_u0/RD1
add wave -noupdate -expand -group {REG FILE} /MIPS_tb/DUT/dp_u0/regfile_u0/RD2
add wave -noupdate -expand -group {REG FILE} /MIPS_tb/DUT/dp_u0/regfile_u0/Reg_File
add wave -noupdate -expand -group {REG FILE} /MIPS_tb/DUT/dp_u0/regfile_u0/WD3
add wave -noupdate -expand -group {REG FILE} /MIPS_tb/DUT/dp_u0/regfile_u0/WE3
add wave -noupdate -expand -group ALU /MIPS_tb/DUT/dp_u0/ALUControl
add wave -noupdate -expand -group ALU /MIPS_tb/DUT/dp_u0/ALUOut
add wave -noupdate -expand -group ALU /MIPS_tb/DUT/dp_u0/ALUResult
add wave -noupdate -expand -group ALU /MIPS_tb/DUT/dp_u0/ALUSrcA
add wave -noupdate -expand -group ALU /MIPS_tb/DUT/dp_u0/ALUSrcB
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {408920 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {487608 ps} {566117 ps}
