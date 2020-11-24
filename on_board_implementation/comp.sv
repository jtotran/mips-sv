module comp(
	input logic ALUOpThree, ALUOpOne, z, v, n,
	output logic [31:0] compout
);

	logic [1:0] ALUOpBits;

	assign ALUOpBits = {ALUOpThree, ALUOpOne};

    	always_comb begin
	       	case(ALUOpBits) 
		2'b00:
			compout <= z;	
		2'b01:
			compout <= n ^ v;
		2'b10:
			compout <= z | (n ^ v);
		default: 
			compout <= z;	
	       	endcase
	end

endmodule
