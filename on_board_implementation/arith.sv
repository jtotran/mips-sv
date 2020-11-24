module arith(
	input logic [1:0] ALUOp,
	input logic [31:0] A, B, 
	output logic [31:0] arithout,
	output logic z, v, n
);

	logic [32:0] arithoutCarry;

    	assign z = ~(|arithout);
	assign n = arithout[31];
	assign v = arithout[31] ^ A[31] ^ B[31] ^ arithoutCarry[32];
	assign arithout = arithoutCarry[31:0];

	always_comb begin
		case(ALUOp[0])
		1'b0: 
			arithoutCarry <= A + B;
		1'b1:
			arithoutCarry <= A - B;
		default: 
			arithoutCarry <= A - B;
		endcase
	end

endmodule
