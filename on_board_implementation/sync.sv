module sync(
	input logic clk,
	input logic asyncInput, 
	output logic edgeOutput  
);

	logic syncInput;
	logic ffOneOutput;
	logic ffTwoOutput;

	always_ff @(posedge clk) begin 

		ffOneOutput <= asyncInput;
		ffTwoOutput <= ffOneOutput;
		syncInput <= ffTwoOutput;

	end

	assign edgeOutput = !ffTwoOutput & syncInput;

endmodule
