/***************************************
 * D-Mem for Beta (Lab 4)
 *
 * Elizabeth Basha
 * Spring 2015
 */
 
 module dmem4(
	input logic clk,
	input logic [31:0] memAddr,
	input logic [31:0] memWriteData,
	input logic MemWrite, MemRead,
	output logic [31:0] memReadData
);
			 
	logic [31:0] dataMemory[1023:0] /* synthesis ram_init_file = "dmem.mif" */;
	logic [31:0] memAddrWord;	// need to use word aligned version
	logic [31:0] memReadDataReg; 
	
	/*
	initial
	begin
		$readmemb("tests/lab4dmem.txt", dataMemory);
	end
	*/
	
	assign memAddrWord = memAddr>>2;
	
	always_ff @(posedge clk)
	begin
		if(MemWrite) begin
			dataMemory[memAddrWord] <= memWriteData;
			memReadDataReg <= memWriteData;
		end
		else
			memReadDataReg <= dataMemory[memAddrWord];
	end
	
	assign memReadData = MemRead ? memReadDataReg : 32'd0;
	
endmodule
