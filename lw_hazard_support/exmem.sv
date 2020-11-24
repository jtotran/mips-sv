module exmem(
	input logic clock,

	input logic MemToReg, RegWrite,
	input logic MemRead, MemWrite,

	input logic [31:0] JumpSel,
	input logic [31:0] memAddr,
	input logic [31:0] memWriteData,
	input logic [4:0] regWriteDst,

	input logic [31:0] id, 

	output logic MemToReg_pipe_ex, RegWrite_pipe_ex,
	output logic MemRead_pipe_ex, MemWrite_pipe_ex,

	output logic [31:0] JumpSel_pipe_ex,
	output logic [31:0] memAddr_pipe_ex,
	output logic [31:0] memWriteData_pipe_ex,
	output logic [4:0] regWriteDst_pipe_ex,

	output logic [31:0] id_pipe_ex
);


	logic MemToReg_pipe_reg, RegWrite_pipe_reg;
	logic MemRead_pipe_reg, MemWrite_pipe_reg;
	
	logic [31:0] JumpSel_pipe_reg;
	logic [31:0] memAddr_pipe_reg;
	logic [31:0] memWriteData_pipe_reg;
	logic [4:0] regWriteDst_pipe_reg;

	logic [31:0] id_pipe_reg;

	always_ff @(negedge clock) begin
		MemToReg_pipe_reg <= MemToReg;
		RegWrite_pipe_reg <= RegWrite;
		MemRead_pipe_reg <= MemRead;
		MemWrite_pipe_reg <= MemWrite;
		JumpSel_pipe_reg <= JumpSel;
		memAddr_pipe_reg <= memAddr;
		memWriteData_pipe_reg <= memWriteData;
		regWriteDst_pipe_reg <= regWriteDst;
		id_pipe_reg <= id;
	end

	always_comb begin
		MemToReg_pipe_ex <= MemToReg_pipe_reg;
		RegWrite_pipe_ex <= RegWrite_pipe_reg;
		MemRead_pipe_ex <= MemRead_pipe_reg;
		MemWrite_pipe_ex <= MemWrite_pipe_reg;
		JumpSel_pipe_ex <= JumpSel_pipe_reg;
		memAddr_pipe_ex <= memAddr_pipe_reg;
		memWriteData_pipe_ex <= memWriteData_pipe_reg;
		regWriteDst_pipe_ex <= regWriteDst_pipe_reg;
		id_pipe_ex <= id_pipe_reg;
	end

endmodule
