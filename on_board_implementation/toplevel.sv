module toplevel(
	input logic clk, reset, irq, pause, 
	input logic [1:0] switchLed,
	output logic MemRead, MemWrite,
	output logic [6:0] segmentSeven, 
	output logic [6:0] segmentSix, 
	output logic [6:0] segmentFive, 
	output logic [6:0] segmentFour, 
	output logic [6:0] segmentThree,
	output logic [6:0] segmentTwo,
	output logic [6:0] segmentOne,
	output logic [6:0] segmentZero,
	output logic debugClk
);

	logic divclk;
	logic modclk;
	logic pauseclk = 1'b1;
	logic [1:0] clkControl;

	logic [31:0] debugia, debugid, debugmemAddr;

	logic [6:0] iasegmentSeven;
	logic [6:0] iasegmentSix;
	logic [6:0] iasegmentFive; 
	logic [6:0] iasegmentFour;
	logic [6:0] iasegmentThree;
	logic [6:0] iasegmentTwo;
	logic [6:0] iasegmentOne;
	logic [6:0] iasegmentZero;

	logic [6:0] idsegmentSeven;
	logic [6:0] idsegmentSix;
	logic [6:0] idsegmentFive; 
	logic [6:0] idsegmentFour;
	logic [6:0] idsegmentThree;
	logic [6:0] idsegmentTwo;
	logic [6:0] idsegmentOne;
	logic [6:0] idsegmentZero;

	logic [6:0] memAddrsegmentSeven;
	logic [6:0] memAddrsegmentSix;
	logic [6:0] memAddrsegmentFive; 
	logic [6:0] memAddrsegmentFour;
	logic [6:0] memAddrsegmentThree;
	logic [6:0] memAddrsegmentTwo;
	logic [6:0] memAddrsegmentOne;
	logic [6:0] memAddrsegmentZero;

	assign clkControl = {pauseclk, pause};
	assign debugClk = modclk;

	clockdiv xclockdiv(clk, divclk);
	beta xbeta(modclk, reset, irq, MemRead, MemWrite, debugia, debugid, debugmemAddr);
	sevensegment iasevensegment(
		debugia,
		iasegmentSeven,
		iasegmentSix,
		iasegmentFive, 
		iasegmentFour,
		iasegmentThree,
		iasegmentTwo,
		iasegmentOne,
		iasegmentZero
	);
	sevensegment idsevensegment(
		debugid,
		idsegmentSeven,
		idsegmentSix,
		idsegmentFive, 
		idsegmentFour,
		idsegmentThree,
		idsegmentTwo,
		idsegmentOne,
		idsegmentZero
	);
	sevensegment memAddrsevensegment(
		debugmemAddr,
		memAddrsegmentSeven,
		memAddrsegmentSix,
		memAddrsegmentFive, 
		memAddrsegmentFour,
		memAddrsegmentThree,
		memAddrsegmentTwo,
		memAddrsegmentOne,
		memAddrsegmentZero
	);

	always_ff @(posedge divclk) 
	begin
		case(clkControl)
			2'b00:
			begin
				modclk <= ~modclk;	
			end
			2'b01:
			begin
				modclk <= 1'b0;
				pauseclk <= 1'b1;
			end
			2'b10:
			begin
				modclk <= 1'b1;
				pauseclk <= 1'b0;
			end
			2'b11:
			begin
				modclk <= 1'b0;
			end
			default:
			begin
				modclk <= ~modclk;
			end
		endcase
	end

	always_comb 
	begin
		case(switchLed)
		2'b00:
		begin
			segmentSeven <= iasegmentSeven;
			segmentSix <= iasegmentSix;
			segmentFive <= iasegmentFive; 
			segmentFour <= iasegmentFour;
			segmentThree <= iasegmentThree;
			segmentTwo <= iasegmentTwo;
			segmentOne <= iasegmentOne;
			segmentZero <= iasegmentZero;
		end
		2'b01:
		begin
			segmentSeven <= idsegmentSeven;
			segmentSix <= idsegmentSix;
			segmentFive <= idsegmentFive; 
			segmentFour <= idsegmentFour;
			segmentThree <= idsegmentThree;
			segmentTwo <= idsegmentTwo;
			segmentOne <= idsegmentOne;
			segmentZero <= idsegmentZero;
		end
		2'b10:
		begin
			segmentSeven <= memAddrsegmentSeven;
			segmentSix <= memAddrsegmentSix;
			segmentFive <= memAddrsegmentFive; 
			segmentFour <= memAddrsegmentFour;
			segmentThree <= memAddrsegmentThree;
			segmentTwo <= memAddrsegmentTwo;
			segmentOne <= memAddrsegmentOne;
			segmentZero <= memAddrsegmentZero;
		end
		2'b11:
		begin
			segmentSeven <= iasegmentSeven;
			segmentSix <= iasegmentSix;
			segmentFive <= iasegmentFive; 
			segmentFour <= iasegmentFour;
			segmentThree <= iasegmentThree;
			segmentTwo <= iasegmentTwo;
			segmentOne <= iasegmentOne;
			segmentZero <= iasegmentZero;
		end
		default:
		begin
			segmentSeven <= iasegmentSeven;
			segmentSix <= iasegmentSix;
			segmentFive <= iasegmentFive; 
			segmentFour <= iasegmentFour;
			segmentThree <= iasegmentThree;
			segmentTwo <= iasegmentTwo;
			segmentOne <= iasegmentOne;
			segmentZero <= iasegmentZero;
		end
		endcase
	end


endmodule
