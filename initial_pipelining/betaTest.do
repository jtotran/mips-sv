# Script to run testbench

# Compile Design
vlog -sv -work work bool.sv
vlog -sv -work work arith.sv
vlog -sv -work work comp.sv
vlog -sv -work work shift.sv
vlog -sv -work work alu.sv
vlog -sv -work work pc.sv
vlog -sv -work work -suppress 7061 regfile.sv
vlog -sv -work work ctl.sv
vlog -sv -work work beta.sv
	
### ADD YOUR DESIGN FILES HERE FOR COMPILATION ###
# vlog -sv -work work branchJump.sv
vlog -sv -work work ifid.sv
vlog -sv -work work idex.sv
vlog -sv -work work exmem.sv
vlog -sv -work work memwb.sv
vlog -sv -work work forwardUnit.sv

# Compile Testbench
vlog -sv -reportprogress 300 -work work tests/imem.sv
vlog -sv -reportprogress 300 -work work tests/dmem.sv
vlog -sv -reportprogress 300 -work work tests/testBeta.sv

# Simulate
vsim -t 1ps -L work -voptargs="+acc" -gtestFileName="tests/testData.txt" -gnumTests=20 testBeta

do tests/opRadix.txt
do tests/funcRadix.txt
do tests/regRadix.txt

# Add waves
add wave -label Clk clk
add wave -label Reset reset
add wave -label IRQ irq
#add wave -radix hex -label ID dutBeta/id
add wave -divider Stage=IF
# Look at signals in IF
add wave -radix hex -label IA_IF ia
add wave -radix OP_LABELS -label OpCodeIF {dutBeta/id[31:26]}
# Look at signals in ID
add wave -divider Stage=ID
add wave -radix OP_LABELS -label OpCodeID {dutBeta/id_pipe_if[31:26]}
add wave -radix FUNC_LABELS -label FunctID {dutBeta/id_pipe_if[5:0]}
add wave -radix REG_LABELS -label RsID {dutBeta/id_pipe_if[25:21]}
add wave -radix REG_LABELS -label RtID {dutBeta/id_pipe_if[20:16]}
add wave -radix REG_LABELS -label RdID {dutBeta/id_pipe_if[15:11]}
# Look at signals in EX
add wave -divider Stage=EX
add wave -radix OP_LABELS -label OpCodeEX {dutBeta/id_pipe_id[31:26]}
add wave -radix FUNC_LABELS -label FunctEX {dutBeta/id_pipe_id[5:0]}
add wave -radix REG_LABELS -label RsEX {dutBeta/id_pipe_id[25:21]}
add wave -radix REG_LABELS -label RtEX {dutBeta/id_pipe_id[20:16]}
add wave -radix REG_LABELS -label RdEX {dutBeta/id_pipe_id[15:11]}
add wave -radix hex -label MemAddrEX memAddr
# Look at signals in MEM
add wave -divider Stage=MEM
add wave -radix OP_LABELS -label OpCodeMEM {dutBeta/id_pipe_ex[31:26]}
add wave -radix FUNC_LABELS -label FunctMEM {dutBeta/id_pipe_ex[5:0]}
add wave -radix REG_LABELS -label RsMEM {dutBeta/id_pipe_ex[25:21]}
add wave -radix REG_LABELS -label RtMEM {dutBeta/id_pipe_ex[20:16]}
add wave -radix REG_LABELS -label RdMEM {dutBeta/id_pipe_ex[15:11]}
#add wave -radix hex -label MemReadData dutBeta/memReadData
#add wave -radix hex -label MemWriteData dutBeta/memWriteData
#add wave -label MemWrite MemWrite
#add wave -label MemRead MemRead

add wave -divider Debug_Signals
add wave -radix hex *
# add wave -radix hex {testVector[30:0]}
# add wave -radix hex dutBeta/*
# add wave -radix hex dutBeta/buildReg/registerFile


#### Add your debug signals here ####
add wave dutBeta/*

# Plot signal values
view structure
view signals
run 10 ns
