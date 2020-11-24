/***************************************
 * Testbench for Beta: Full Beta with Basic Pipelining
 *
 * Elizabeth Basha
 * Spring 2014
 */
 
 module testBeta();
 
		// Define parameters when calling from do file
        parameter testFileName;
        parameter numTests;
		parameter CYCLE_TIME=32'd10;
        
        // Signal declarations
		logic clk = 1'b0;
        logic reset = 1'b1;
		logic irq = 1'b0;
		logic [31:0] ia, memAddr;
		logic MemWrite, MemRead;
           
        logic [3:0] cntlIn;
		logic [31:0] iaExpected, memAddrExpected, memWriteDataExpected;
                
		logic MemWriteExpected, MemReadExpected;
		logic [99:0] testVector[800:0];
        int inputIndex = 32'd0, checkIAIndex = 32'd0, checkMemAddrIndex = 32'd0;
        
        // Module under test declaration
        beta dutBeta(.clk(clk),.reset(reset),.irq(irq),.ia(ia),.memAddr(memAddr),.MemWrite(MemWrite),.MemRead(MemRead));
        
		// Generate clock signal
		always #(CYCLE_TIME) clk = ~clk;
		
        // Test
        initial
        begin         
           // Read test file
           $readmemh(testFileName, testVector);
        end
        
		// Always block for assigning input signals; this should happen every clock cycle
		always @(negedge clk)
		begin
			// Assign signals and check for results
			if(inputIndex<numTests)
			begin
				cntlIn = testVector[inputIndex][98:96];

				// Set signals
				reset = cntlIn[2];
				MemReadExpected = cntlIn[1];
				MemWriteExpected = cntlIn[0];
								
				// Increment i
				inputIndex=inputIndex+32'd1;
			end
			// No else - checking stops the test
		end
		
		// Always blocks for checking results; each needs to wait until correct pipeline stage and look backwards
		// Check IA first - this should be on posedge after inputs set (Fetch stage)
		always @(posedge clk)
		begin
			// For initial test, checking memAddr
			if(checkIAIndex<=inputIndex && (inputIndex!=32'd0))
			begin
				if(checkIAIndex<numTests)
				begin				
					iaExpected = testVector[checkIAIndex][95:64];

					// Check result
					if((ia!==iaExpected))
					begin
						$display("Error at simulation time = %0t\t",$time);
						$display("Expected ia = %h\n",iaExpected);
						//$stop;
					end
					
					// Increment i
					checkIAIndex=checkIAIndex+32'd1;
				end
			end
		end
		// Check memAddr second - this should be valid in Execute stage (3 posedges after inputs)
		always @(posedge clk)
		begin
			// For initial test, checking memAddr
			if(((checkMemAddrIndex+32'd1)<inputIndex) || (inputIndex>=numTests))
			begin
				if(checkMemAddrIndex<numTests)
				begin				
					memAddrExpected = testVector[checkMemAddrIndex][63:32];

					// Check result
					#1 if((memAddr!==memAddrExpected))
					begin
						$display("Error at simulation time = %0t\t",$time);
						$display("Expected memAddr = %h\n",memAddrExpected);
						//$stop;
					end
					
					// Increment i
					checkMemAddrIndex=checkMemAddrIndex+32'd1;
				end else begin
					// If all done, exit cleanly
					$display("Test Successful!\n");
					$stop;
				end
			end
		end
		
 endmodule