module shift(input logic [1:0]ALUOp,
             input logic [31:0] A, B,
     	     output logic [31:0]shiftout);

     always_comb begin
	     case(ALUOp)
		    2'b00: begin
			shiftout <= A << B[4:0];
		    end
	            2'b01: begin
			shiftout <= A >> B[4:0];
		    end
		    2'b11: begin
			shiftout <= $signed(A) >>> B[4:0]; 
		    end
	     endcase
     end

endmodule
