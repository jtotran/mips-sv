module alu(input logic [31:0]A, B,
	   input logic [4:0]ALUOp,
	   output logic [31:0]Y,
	   output logic z, v, n);

   	// Signal declarations
	logic [31:0] boolout, shiftout, arithout, compout;

	
	// Module declarations
	bool xbool(ALUOp[3:0], A, B, boolout);
	arith xarith(ALUOp[1:0], A, B, arithout, z, v, n);
	comp xcomp(ALUOp[3], ALUOp[1], z, v, n, compout);
	shift xshift(ALUOp[1:0], A, B, shiftout);
	
	always_comb begin
		casex(ALUOp)
		   	5'b0000x: begin
				Y <= arithout;
			end
			5'b00101: begin
				Y <= compout;
			end
			5'b00111: begin
				Y <= compout;
			end
			5'b01101: begin
				Y <= compout;
			end
			5'b01000: begin
				Y <= shiftout;
			end
			5'b01001: begin
				Y <= shiftout;
			end
			5'b01011: begin
				Y <= shiftout;
			end
			5'b1xxxx: begin
				Y <= boolout;
			end
			default: begin
			end
		endcase
	end
	
	// Output assignment
	// assign Y = boolout;
	// assign Y = arithout;
	// assign Y = compout; 
	// assign Y = shiftout;
	// assign Y = A;
	// assign z = z;
	// assign v = v;
	// assign n = n;
	
endmodule
