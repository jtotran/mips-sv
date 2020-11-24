module forwardUnit(
	input logic clock,

	input logic [4:0] ra_pipe_id, rb_pipe_id,
	
	input logic MemToReg_pipe_ex, RegWrite_pipe_ex,
	input logic [4:0] RegWriteDst_pipe_ex,

	input logic MemToReg_pipe_mem, RegWrite_pipe_mem,
	input logic [4:0] RegWriteDst_pipe_mem,

	output logic [1:0] ASel, 
	output logic [1:0] forwardControl
);

	
	always_comb begin
	       if((rb_pipe_id == RegWriteDst_pipe_ex) && (RegWrite_pipe_ex == 1'b1)) begin
		       if(MemToReg_pipe_ex == 1'b0) 
			       forwardControl <= 2'b01;
		       else 
			       forwardControl <= 2'b00;
	       end
	       else if((rb_pipe_id == RegWriteDst_pipe_mem) && (RegWrite_pipe_mem == 1'b1))
		       forwardControl <= 2'b10;
	       else 
		       forwardControl <= 2'b00;
	end
	
	always_comb begin
	       if((ra_pipe_id == RegWriteDst_pipe_ex) && (RegWrite_pipe_ex == 1'b1)) begin
		       if(MemToReg_pipe_ex == 1'b0) 
			       ASel <= 2'b01;
		       else 
			       ASel <= 2'b00;
	       end
	       else if((ra_pipe_id == RegWriteDst_pipe_mem) && (RegWrite_pipe_mem == 1'b1))
		       ASel <= 2'b10;
	       else 
		       ASel <= 2'b00;
	end

endmodule
