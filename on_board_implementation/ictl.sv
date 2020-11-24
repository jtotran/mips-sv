module ictl(
	input logic [5:0] idSegOne, idSegZero,
	output logic [1:0] iControl
);

	logic [11:0] iControlSel;

	assign iControlSel = {idSegOne, idSegZero};

	always_comb begin
		casex(iControlSel) 
		12'b000000000000:
			iControl <= 2'b00;
		12'b000000000010:
			iControl <= 2'b00;
		12'b000000000011:
			iControl <= 2'b00;
		12'b001000XXXXXX:
			iControl <= 2'b01;
		12'b001100XXXXXX:
			iControl <= 2'b10;
		12'b001101XXXXXX:
			iControl <= 2'b10;
		12'b001110XXXXXX:
			iControl <= 2'b10;
		12'b100011XXXXXX:
			iControl <= 2'b01;
		12'b101011XXXXXX:
			iControl <= 2'b01;
		default:
			iControl <= 2'b11;
		endcase
	end

	/*
	always_comb begin
		if(iControlSel == 12'b000000000000) 
			iControl <= 2'b00;
		else if(iControlSel == 12'b000000000010) 
			iControl <= 2'b00;
		else if(iControlSel == 12'b000000000011) 
			iControl <= 2'b00;
		else if(iControlSel[11:6] == 6'b001000)
			iControl <= 2'b01;
		else if(iControlSel[11:6] == 6'b001100)
			iControl <= 2'b10;
		else if(iControlSel[11:6] == 6'b001101)
			iControl <= 2'b10;
		else if(iControlSel[11:6] == 6'b001110)
			iControl <= 2'b10;
		else if(iControlSel[11:6] == 6'b100011)
			iControl <= 2'b01;
		else if(iControlSel[11:6] == 6'b101011)
			iControl <= 2'b01;
		else
			iControl <= 2'b11;
	end
	*/

endmodule
