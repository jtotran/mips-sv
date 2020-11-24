/***************************************
 * I-Mem for Beta: Single Cycle
 *
 * Elizabeth Basha
 * Fall 2016
 */
 
 module imem(input logic clk,
			 input logic [31:0] ia,
			 output logic [31:0] id);
			 
	logic [31:0] instrMemory [255:0];
	logic [31:0] iaWord;	// Need to use word aligned version of address
	
	initial
	begin
		$readmemh("tests/imemData.txt", instrMemory);
	end
			
	assign iaWord = (ia & 32'h7fffffff)>>2;	// Now also need to ignore supervisor bit
	assign id = instrMemory[iaWord];
	
endmodule