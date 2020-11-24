module pcctl(
	input logic irq, illOp, iaBit,
	output logic [1:0] PCControl
);

	logic [2:0] PCControlSel;

	assign PCControlSel = {illOp, irq, iaBit};

	always_comb begin 
		case(PCControlSel) 
		3'b000:
			PCControl <= 2'b00;
		3'b001:
			PCControl <= 2'b00;
		3'b010:
			PCControl <= 2'b01;
		3'b011:
			PCControl <= 2'b00;
		3'b100:
			PCControl <= 2'b10;
		3'b101:
			PCControl <= 2'b10;
		3'b110:
			PCControl <= 2'b10;
		3'b111:
			PCControl <= 2'b10;
		default:
			PCControl <= 2'b00;
		endcase
	end

endmodule
