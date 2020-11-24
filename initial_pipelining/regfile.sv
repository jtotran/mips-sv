module regfile(input logic clk, RegWrite, 
	// input logic [1:0] RegDst,
	input logic [4:0] ra, rb, // rc,
	input logic [4:0] regWriteDst,
	input logic [31:0] wdata, 
	output logic [31:0] radata, rbdata
);
	logic [31:0] memory [31:0] = {
	32'h00000000,	
	32'h00000000,
	32'h00000000,
	32'h00000000,
	32'h00000000,
	32'h00000000,
	32'h00000000,
	32'h00000000,
	32'h00000000,
	32'h00000000,
	32'h00000000,
	32'h00000000,
	32'h00000000,
	32'h00000000,
	32'h00000000,
	32'h00000000,
	32'h00000000,
	32'h00000000,
	32'h00000000,
	32'h00000000,
	32'h00000000,
	32'h00000000,
	32'h00000000,
	32'h00000000,
	32'h00000000,
	32'h00000000,
	32'h00000000,
	32'h00000000,
	32'h00000000,
	32'h00000000,
	32'h00000000,
	32'h00000000
	};

	// NOTE: May need to change clock edge to negedge
	always_ff @(posedge clk) begin
	       if(RegWrite) begin 
		       /*
		       case(RegDst) 
			       2'b00: begin
				       memory[rc] <= wdata;
			       end
			       2'b01: begin
				       memory[rb] <= wdata;
			       end
			       2'b10: begin
				       memory[5'b00001] <= wdata; 
			       end
			       2'b11: begin
				       memory[5'b11111] <= wdata; 
			       end
			       default:
				       memory[rc] <= wdata;
		       endcase
		       */
		      memory[regWriteDst] <= wdata;
	       end
	end

	always_comb begin
		if(ra==5'd0) 
			radata <= 32'h00000000;
		else 
			radata <= memory[ra]; 
		if(rb==5'd0) 
			rbdata <= 32'h00000000;
		else
			rbdata <= memory[rb];
	end

endmodule
