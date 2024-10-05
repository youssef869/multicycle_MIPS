vlib work
vlog *.v
vsim -voptargs=+acc work.MIPS_tb
do wave.do
run -all