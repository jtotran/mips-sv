module memwb(
	input logic clock,

	input logic MemToReg,
	input logic RegWrite,

	input logic [31:0] memReadData,
	input logic [31:0] memAddr,
	
	input logic [4:0] regWriteDst,

	input logic [31:0] id,

	output logic MemToReg_pipe_mem,
	output logic RegWrite_pipe_mem,

	output logic [31:0] memReadData_pipe_mem,
	output logic [31:0] memAddr_pipe_mem,

	output logic [4:0] regWriteDst_pipe_mem,
	
	output logic [31:0] id_pipe_mem
);

	logic MemToReg_pipe_reg;
	logic RegWrite_pipe_reg;

	logic [31:0] memReadData_pipe_reg;
	logic [31:0] memAddr_pipe_reg;

	logic [4:0] regWriteDst_pipe_reg;

	logic [31:0] id_pipe_reg;

	always_ff @(negedge clock) begin
		MemToReg_pipe_reg <= MemToReg;
		RegWrite_pipe_reg <= RegWrite;
		memReadData_pipe_reg <= memReadData;
		memAddr_pipe_reg <= memAddr;
		regWriteDst_pipe_reg <= regWriteDst;
		id_pipe_reg <= id;
	end

	always_comb begin
		MemToReg_pipe_mem <= MemToReg_pipe_reg;
		RegWrite_pipe_mem <= RegWrite_pipe_reg;
		memReadData_pipe_mem <= memReadData_pipe_reg;
		memAddr_pipe_mem <= memAddr_pipe_reg;
		regWriteDst_pipe_mem <= regWriteDst_pipe_reg;
		id_pipe_mem <= id_pipe_reg;
	end

endmodule 
