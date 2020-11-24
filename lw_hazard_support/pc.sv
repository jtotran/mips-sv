module pc(input logic clk, reset,
	  // input logic [1:0] Jump, PCControl,
	  // input logic [31:0] inputAddr, 
	  input logic pc_stall,
	  output logic [31:0] ia
);

	logic [31:0] pc;
	assign ia = pc;

	always_ff @(posedge clk or posedge reset) begin
		$display("PC: %h", pc);
		if (reset) begin
			pc <= 32'h80000000;
		end


		// NOTE: Logic was previously used for Jump and Branch
		// operations
		/* 
		else if (Jump == 2'b01 || Jump == 2'b10 || PCControl == 2'b01 || PCControl == 2'b10) begin
			pc <= inputAddr;
			i = i + 1;
		end
		else begin
			pc <= inputAddr + 32'h00000004;
		end
		*/


	       else if(pc_stall == 1'b1) 
		       pc <= pc + 32'h00000004;
	end


endmodule
