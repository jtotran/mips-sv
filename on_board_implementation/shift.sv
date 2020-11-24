module shift(
	input logic [1:0]ALUOp,
        input logic [31:0] A, B,
     	output logic [31:0]shiftout
);

     	always_comb begin
		case(ALUOp)
		2'b00: 
			shiftout <= A << B[4:0];
	        2'b01:
			shiftout <= A >> B[4:0];
		2'b11: 
			shiftout <= $signed(A) >>> B[4:0]; 
		default: 
			shiftout <= A << B[4:0];
	     endcase
     end

endmodule
