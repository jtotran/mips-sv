# MIPS System Verilog 
Contents
--------

* Initial Pipelining
* Load Word Hazard Support
* On Board Implementation

Description
-----------

The following project is my implementation of the MIPS architecture. The initial implementation added pipelining and
load word hazard support. Both of these were tested and verified using a ModelSim testbench. The initial pipelining
required the construction of pipeline registers for each stage: Instruction Fetch, Instruction Decode, Instruction
Execute, Memory Access and Write Back. A forwarding unit was then created to select the proper ALU inputs for the
Execute stage. The load word hazard support utilized a hazard detection module in order to stall the processor when
the execute stage requires a value read from memory. I then modified my project so that it can be easily synthesized
into hardware. It is important to note that the on board implementation does not include the pipelining and load word
hazard support.
