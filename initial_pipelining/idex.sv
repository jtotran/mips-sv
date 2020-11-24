module idex(
	input logic clock,

	input logic MemToReg, RegWrite,
	
	input logic MemRead, MemWrite, 

	input logic [1:0] iControl,
	input logic ALUSrc,
	input logic [1:0] RegDst, 

	input logic [4:0] ALUOp,

	input logic Branch, BranchControl,
	input logic [1:0] Jump, 

	input logic [31:0] ia, id,
	input logic [31:0] radata, memWriteData,
	input logic [31:0] zeroPadShamt, signExtend, zeroPadI,

	output logic MemToReg_pipe_id, RegWrite_pipe_id,
	
	output logic MemRead_pipe_id, MemWrite_pipe_id,

	output logic [1:0] iControl_pipe_id,
	output logic ALUSrc_pipe_id,
	output logic RegDst_pipe_id,

	output logic [4:0] ALUOp_pipe_id,

	output logic Branch_pipe_id, BranchControl_pipe_id,
	output logic [1:0] Jump_pipe_id,

	output logic [31:0] ia_pipe_id, id_pipe_id,
	output logic [31:0] radata_pipe_id, memWriteData_pipe_id,
	output logic [31:0] zeroPadShamt_pipe_id, signExtend_pipe_id, zeroPadI_pipe_id

);

	logic MemToReg_pipe_reg, RegWrite_pipe_reg;

	logic MemRead_pipe_reg, MemWrite_pipe_reg;

	logic [1:0] iControl_pipe_reg;
	logic ALUSrc_pipe_reg;
	logic RegDst_pipe_reg;

	logic [4:0] ALUOp_pipe_reg;

	logic Branch_pipe_reg, BranchControl_pipe_reg;
	logic [1:0] Jump_pipe_reg;

	logic [31:0] ia_pipe_reg, id_pipe_reg;
	logic [31:0] radata_pipe_reg, memWriteData_pipe_reg;
	logic [31:0] zeroPadShamt_pipe_reg, signExtend_pipe_reg, zeroPadI_pipe_reg;

	always_ff @(negedge clock) begin
		MemToReg_pipe_reg <= MemToReg;
		RegWrite_pipe_reg <= RegWrite;
		MemRead_pipe_reg <= MemRead;
		MemWrite_pipe_reg <= MemWrite;
		iControl_pipe_reg <= iControl;
		ALUSrc_pipe_reg <= ALUSrc;
		RegDst_pipe_reg <= RegDst;
		ALUOp_pipe_reg <= ALUOp;
		Branch_pipe_reg <= Branch;
		BranchControl_pipe_reg <= BranchControl;
		Jump_pipe_reg <= Jump;
		ia_pipe_reg <= ia;
		id_pipe_reg <= id;
		radata_pipe_reg <= radata;
		memWriteData_pipe_reg <= memWriteData;
		zeroPadShamt_pipe_reg <= zeroPadShamt;
		signExtend_pipe_reg <= signExtend;
		zeroPadI_pipe_reg <= zeroPadI;
	end

	always_comb begin
		MemToReg_pipe_id <= MemToReg_pipe_reg;
		RegWrite_pipe_id <= RegWrite_pipe_reg;
		MemRead_pipe_id <= MemRead_pipe_reg;
		MemWrite_pipe_id <= MemWrite_pipe_reg;
		iControl_pipe_id <= iControl_pipe_reg;
		ALUSrc_pipe_id <= ALUSrc_pipe_reg;
		RegDst_pipe_id <= RegDst_pipe_reg;
		ALUOp_pipe_id <= ALUOp_pipe_reg;
		Branch_pipe_id <= Branch_pipe_reg;
		BranchControl_pipe_id <= BranchControl_pipe_reg;
		Jump_pipe_id <= Jump_pipe_reg;
		ia_pipe_id <= ia_pipe_reg;
		id_pipe_id <= id_pipe_reg;
		radata_pipe_id <= radata_pipe_reg;
		memWriteData_pipe_id <= memWriteData_pipe_reg;
		zeroPadShamt_pipe_id <= zeroPadShamt_pipe_reg;
		signExtend_pipe_id <= signExtend_pipe_reg;
		zeroPadI_pipe_id <= zeroPadI_pipe_reg;
	end
	
endmodule
