module arith(input logic [1:0]ALUOp,
	     input logic [31:0]A, B, 
	     output logic [31:0]arithout,
	     output logic z, v, n);

	logic [32:0]arithout_carry;

    assign z = ~(|arithout);
	assign n = arithout[31];
	assign v = arithout[31] ^ A[31] ^ B[31] ^ arithout_carry[32];
	assign arithout = arithout_carry[31:0];

	always_comb begin
		case(ALUOp[0])
			1'b0: begin
				arithout_carry <= A + B;
			end
			1'b1: begin 
				arithout_carry <= A - B;
			end
			default: begin
				arithout_carry <= A - B;
			end
		endcase
	end

endmodule
