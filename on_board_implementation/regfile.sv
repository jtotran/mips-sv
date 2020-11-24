module regfile(
	input logic clk, RegWrite, 
	input logic [1:0] RegDst,
	input logic [4:0] ra, rb, rc,
	input logic [31:0] wdata, 
	output logic [31:0] radata, rbdata
);
	logic [31:0] memory[31:0] = '{
		32'h00000000,	
		32'h00000000,
		32'h00000000,
		32'h00000000,
		32'h00000000,
		32'h00000000,
		32'h00000000,
		32'h00000000,
		32'h00000000,
		32'h00000000,
		32'h00000000,
		32'h00000000,
		32'h00000000,
		32'h00000000,
		32'h00000000,
		32'h00000000,
		32'h00000000,
		32'h00000000,
		32'h00000000,
		32'h00000000,
		32'h00000000,
		32'h00000000,
		32'h00000000,
		32'h00000000,
		32'h00000000,
		32'h00000000,
		32'h00000000,
		32'h00000000,
		32'h00000000,
		32'h00000000,
		32'h00000000,
		32'h00000000
	};

       	logic [3:0] RegWriteDst; 
	
	assign RegWriteDst = {RegWrite, RegDst};

	always_ff @(posedge clk) begin
		case(RegWriteDst) 
		3'b100:
			memory[rc] <= wdata;
		3'b101:
			memory[rb] <= wdata;
		3'b110:
			memory[5'b00001] <= wdata;
		3'b111:
			memory[5'b11111] <= wdata;
		default:
			memory[rc] <= wdata;
	       	endcase
	end

	always_comb begin
		if(ra==5'd0) 
			radata <= 32'h00000000;
		else 
			radata <= memory[ra]; 
		if(rb==5'd0) 
			rbdata <= 32'h00000000;
		else
			rbdata <= memory[rb];
	end

endmodule
