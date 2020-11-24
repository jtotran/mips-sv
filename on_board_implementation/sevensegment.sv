module sevensegment(
	input logic [31:0] debugval,
	output logic [6:0] segmentSeven, 
	output logic [6:0] segmentSix, 
	output logic [6:0] segmentFive, 
	output logic [6:0] segmentFour, 
	output logic [6:0] segmentThree,
	output logic [6:0] segmentTwo,
	output logic [6:0] segmentOne,
	output logic [6:0] segmentZero
);

	always_comb begin
		case(debugval[3:0]) 
		4'b0000:
			segmentZero <= 7'b1000000;
		4'b0001:
			segmentZero <= 7'b1111001;
		4'b0010:
			segmentZero <= 7'b0100100;
		4'b0011:
			segmentZero <= 7'b0110000;
		4'b0100:
			segmentZero <= 7'b0011001;
		4'b0101:
			segmentZero <= 7'b0010010;
		4'b0110:
			segmentZero <= 7'b0000010;
		4'b0111:
			segmentZero <= 7'b1111000;
		4'b1000:
			segmentZero <= 7'b0000000;
		4'b1001:
			segmentZero <= 7'b0010000; 
		4'b1010:
			segmentZero <= 7'b0001000;
		4'b1011:
			segmentZero <= 7'b0000011;
		4'b1100:
			segmentZero <= 7'b1000110;
		4'b1101:
			segmentZero <= 7'b0100001;
		4'b1110:
			segmentZero <= 7'b0000110;
		4'b1111:
			segmentZero <= 7'b0001110;
		default:
			segmentZero <= 7'b1000000;
		endcase
	end
	
	always_comb begin
		case(debugval[7:4]) 
		4'b0000:
			segmentOne <= 7'b1000000;
		4'b0001:
			segmentOne <= 7'b1111001;
		4'b0010:
			segmentOne <= 7'b0100100;
		4'b0011:
			segmentOne <= 7'b0110000;
		4'b0100:
			segmentOne <= 7'b0011001;
		4'b0101:
			segmentOne <= 7'b0010010;
		4'b0110:
			segmentOne <= 7'b0000010;
		4'b0111:
			segmentOne <= 7'b1111000;
		4'b1000:
			segmentOne <= 7'b0000000;
		4'b1001:
			segmentOne <= 7'b0010000; 
		4'b1010:
			segmentOne <= 7'b0001000;
		4'b1011:
			segmentOne <= 7'b0000011;
		4'b1100:
			segmentOne <= 7'b1000110;
		4'b1101:
			segmentOne <= 7'b0100001;
		4'b1110:
			segmentOne <= 7'b0000110;
		4'b1111:
			segmentOne <= 7'b0001110;
		default:
			segmentOne <= 7'b1000000;
		endcase
	end

	always_comb begin
		case(debugval[11:8]) 
		4'b0000:
			segmentTwo <= 7'b1000000;
		4'b0001:
			segmentTwo <= 7'b1111001;
		4'b0010:
			segmentTwo <= 7'b0100100;
		4'b0011:
			segmentTwo <= 7'b0110000;
		4'b0100:
			segmentTwo <= 7'b0011001;
		4'b0101:
			segmentTwo <= 7'b0010010;
		4'b0110:
			segmentTwo <= 7'b0000010;
		4'b0111:
			segmentTwo <= 7'b1111000;
		4'b1000:
			segmentTwo <= 7'b0000000;
		4'b1001:
			segmentTwo <= 7'b0010000; 
		4'b1010:
			segmentTwo <= 7'b0001000;
		4'b1011:
			segmentTwo <= 7'b0000011;
		4'b1100:
			segmentTwo <= 7'b1000110;
		4'b1101:
			segmentTwo <= 7'b0100001;
		4'b1110:
			segmentTwo <= 7'b0000110;
		4'b1111:
			segmentTwo <= 7'b0001110;
		default:
			segmentTwo <= 7'b1000000;
		endcase
	end

	always_comb begin
		case(debugval[15:12]) 
		4'b0000:
			segmentThree <= 7'b1000000;
		4'b0001:
			segmentThree <= 7'b1111001;
		4'b0010:
			segmentThree <= 7'b0100100;
		4'b0011:
			segmentThree <= 7'b0110000;
		4'b0100:
			segmentThree <= 7'b0011001;
		4'b0101:
			segmentThree <= 7'b0010010;
		4'b0110:
			segmentThree <= 7'b0000010;
		4'b0111:
			segmentThree <= 7'b1111000;
		4'b1000:
			segmentThree <= 7'b0000000;
		4'b1001:
			segmentThree <= 7'b0010000; 
		4'b1010:
			segmentThree <= 7'b0001000;
		4'b1011:
			segmentThree <= 7'b0000011;
		4'b1100:
			segmentThree <= 7'b1000110;
		4'b1101:
			segmentThree <= 7'b0100001;
		4'b1110:
			segmentThree <= 7'b0000110;
		4'b1111:
			segmentThree <= 7'b0001110;
		default:
			segmentThree <= 7'b1000000;
		endcase
	end

	always_comb begin
		case(debugval[19:16]) 
		4'b0000:
			segmentFour <= 7'b1000000;
		4'b0001:
			segmentFour <= 7'b1111001;
		4'b0010:
			segmentFour <= 7'b0100100;
		4'b0011:
			segmentFour <= 7'b0110000;
		4'b0100:
			segmentFour <= 7'b0011001;
		4'b0101:
			segmentFour <= 7'b0010010;
		4'b0110:
			segmentFour <= 7'b0000010;
		4'b0111:
			segmentFour <= 7'b1111000;
		4'b1000:
			segmentFour <= 7'b0000000;
		4'b1001:
			segmentFour <= 7'b0010000; 
		4'b1010:
			segmentFour <= 7'b0001000;
		4'b1011:
			segmentFour <= 7'b0000011;
		4'b1100:
			segmentFour <= 7'b1000110;
		4'b1101:
			segmentFour <= 7'b0100001;
		4'b1110:
			segmentFour <= 7'b0000110;
		4'b1111:
			segmentFour <= 7'b0001110;
		default:
			segmentFour <= 7'b1000000;
		endcase
	end

	always_comb begin
		case(debugval[23:20]) 
		4'b0000:
			segmentFive <= 7'b1000000;
		4'b0001:
			segmentFive <= 7'b1111001;
		4'b0010:
			segmentFive <= 7'b0100100;
		4'b0011:
			segmentFive <= 7'b0110000;
		4'b0100:
			segmentFive <= 7'b0011001;
		4'b0101:
			segmentFive <= 7'b0010010;
		4'b0110:
			segmentFive <= 7'b0000010;
		4'b0111:
			segmentFive <= 7'b1111000;
		4'b1000:
			segmentFive <= 7'b0000000;
		4'b1001:
			segmentFive <= 7'b0010000; 
		4'b1010:
			segmentFive <= 7'b0001000;
		4'b1011:
			segmentFive <= 7'b0000011;
		4'b1100:
			segmentFive <= 7'b1000110;
		4'b1101:
			segmentFive <= 7'b0100001;
		4'b1110:
			segmentFive <= 7'b0000110;
		4'b1111:
			segmentFive <= 7'b0001110;
		default:
			segmentFive <= 7'b1000000;
		endcase
	end

	always_comb begin
		case(debugval[27:24]) 
		4'b0000:
			segmentSix <= 7'b1000000;
		4'b0001:
			segmentSix <= 7'b1111001;
		4'b0010:
			segmentSix <= 7'b0100100;
		4'b0011:
			segmentSix <= 7'b0110000;
		4'b0100:
			segmentSix <= 7'b0011001;
		4'b0101:
			segmentSix <= 7'b0010010;
		4'b0110:
			segmentSix <= 7'b0000010;
		4'b0111:
			segmentSix <= 7'b1111000;
		4'b1000:
			segmentSix <= 7'b0000000;
		4'b1001:
			segmentSix <= 7'b0010000; 
		4'b1010:
			segmentSix <= 7'b0001000;
		4'b1011:
			segmentSix <= 7'b0000011;
		4'b1100:
			segmentSix <= 7'b1000110;
		4'b1101:
			segmentSix <= 7'b0100001;
		4'b1110:
			segmentSix <= 7'b0000110;
		4'b1111:
			segmentSix <= 7'b0001110;
		default:
			segmentSix <= 7'b1000000;
		endcase
	end

	always_comb begin
		case(debugval[31:28]) 
		4'b0000:
			segmentSeven <= 7'b1000000;
		4'b0001:
			segmentSeven <= 7'b1111001;
		4'b0010:
			segmentSeven <= 7'b0100100;
		4'b0011:
			segmentSeven <= 7'b0110000;
		4'b0100:
			segmentSeven <= 7'b0011001;
		4'b0101:
			segmentSeven <= 7'b0010010;
		4'b0110:
			segmentSeven <= 7'b0000010;
		4'b0111:
			segmentSeven <= 7'b1111000;
		4'b1000:
			segmentSeven <= 7'b0000000;
		4'b1001:
			segmentSeven <= 7'b0010000; 
		4'b1010:
			segmentSeven <= 7'b0001000;
		4'b1011:
			segmentSeven <= 7'b0000011;
		4'b1100:
			segmentSeven <= 7'b1000110;
		4'b1101:
			segmentSeven <= 7'b0100001;
		4'b1110:
			segmentSeven <= 7'b0000110;
		4'b1111:
			segmentSeven <= 7'b0001110;
		default:
			segmentSeven <= 7'b1000000;
		endcase
	end

endmodule
