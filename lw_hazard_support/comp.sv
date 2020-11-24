module comp(input logic ALUOp_three, ALUOp_one, z, v, n,
	    output logic [31:0]compout);

    	always_comb begin
		case(ALUOp_three) 
			1'b0: begin
				case(ALUOp_one)
					1'b0: begin
						compout <= z;	
					end
					1'b1: begin
						compout <= n ^ v;
					end
				endcase
			end
			1'b1: begin
				case(ALUOp_one) 
					1'b0: begin
						compout <= z | (n ^ v);
					end
				endcase
			end
		endcase
	end

endmodule
