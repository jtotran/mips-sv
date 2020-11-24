/***************************************
 * I-Mem for Beta (Lab 4)
 *
 * Elizabeth Basha
 * Spring 2015
 */
 
 module imem4(input logic clk,
			 input logic [31:0] ia,
			 output logic [31:0] id);
			 
	logic [31:0] instrMemory [255:0] /* synthesis ram_init_file = "imem.mif" */;
	logic [31:0] iaWord;	/* Need to use word aligned version of address */
			
	assign iaWord = (ia & 32'h7fffffff)>>2;	// Now also need to ignore supervisor bit
	assign id = instrMemory[iaWord];
	
endmodule
