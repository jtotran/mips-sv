module hazardDetection(
	input logic clock,

	input logic [5:0] opcode_pipe_if,
	input logic [5:0] opcode_pipe_id,
	
	input logic [4:0] ifid_reg_rs,
	input logic [4:0] ifid_reg_rt,

	input logic [4:0] idex_reg_rt,

	output logic idex_write_en,
	output logic ifid_write_en,
	output logic pc_stall
);

	always @(posedge clock) begin
		if((opcode_pipe_id == 6'b100011) && (opcode_pipe_id != opcode_pipe_if) && ((idex_reg_rt == ifid_reg_rs) || (idex_reg_rt == ifid_reg_rt))) begin
			idex_write_en <= 1'b0;
			ifid_write_en <= 1'b0;
			pc_stall <= 1'b0;
		end
		else begin
			idex_write_en <= 1'b1;
			ifid_write_en <= 1'b1;
			pc_stall <= 1'b1;
		end
	end

endmodule 
