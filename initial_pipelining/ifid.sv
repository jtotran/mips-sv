module ifid(
	input logic clock,
	input logic [31:0] ia, id, 
	output logic [31:0] ia_pipe_if, id_pipe_if
);

	logic [31:0] ia_pipe_reg;
	logic [31:0] id_pipe_reg;

	always_ff @(negedge clock) begin
		ia_pipe_reg <= ia;
		id_pipe_reg <= id;
	end

	always_comb begin
		ia_pipe_if <= ia_pipe_reg;
		id_pipe_if <= id_pipe_reg;
	end

endmodule
