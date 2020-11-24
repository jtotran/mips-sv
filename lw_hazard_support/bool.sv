module bool(input logic [3:0]ALUOp,
	     input logic [31:0]A, B, 
     	     output logic [31:0]boolout);

     always_comb begin
	     case(ALUOp)
		     4'b1010: begin
			     boolout <= A;
		     end
		     4'b1000: begin
			     boolout <= A & B;
		     end
		     4'b0001: begin
			     boolout <= ~(A | B);
		     end
		     4'b1110: begin
			     boolout <= A | B;
		     end
		     4'b1001: begin
			     boolout <= ~(A ^ B);
		     end
		     4'b0110: begin
			     boolout <= A ^ B;
		     end
	     endcase
     end

endmodule 
