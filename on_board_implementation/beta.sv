module beta(
	/*---------------COMMENT THIS OUT IF TESTING SIM-----------------*/
	input logic clk, reset, irq,
	output logic debugMemRead, debugMemWrite,
	output logic [31:0] debugia, debugid, debugmemAddr
	/*---------------------------------------------------------------*/

	/*--------------UNCOMMENT THIS OUT IF TESTING SIM----------------*/
	/*
	input logic clk, reset, irq,
	input logic [31:0] id, memReadData,
	output logic [31:0] ia, memAddr, memWriteData,
	output logic MemRead, MemWrite
	*/
	/*---------------------------------------------------------------*/
);
	/*---------------COMMENT THIS OUT IF TESTING SIM-----------------*/
	logic [31:0] memAddr, memWriteData;
	logic MemWrite, MemRead; 
	logic [31:0] memReadData;

	logic [31:0] ia, id;

	/* Debug-Display Signals */
	assign debugMemRead = MemRead;
	assign debugMemWrite = MemWrite;
	assign debugia = ia;
	assign debugid = id;
	assign debugmemAddr = memAddr;
	/*---------------------------------------------------------------*/

	logic [1:0] RegDst;
	logic ALUSrc, RegWrite, MemToReg;
	logic [4:0] ALUOp;
	logic [31:0] radata, wdata;

	logic [1:0] iControl;
	logic [31:0] controlOutput;
	logic [31:0] controlRbdata;

	logic [31:0] zeroPadShamt, signExtend, zeroPadI;

	logic z, v, n;
	
	logic ASel, Branch, BranchControl, illOp; 
	logic [1:0] Jump;
	logic [1:0] PCControl;	
	logic [31:0] PCPlusfour;
	logic [31:0] inputAddr;
	logic [31:0] jumpSel, raSel;
	
	/* Logic Element Assignments */
	assign zeroPadShamt = {26'd0, id[11:6]};
	assign zeroPadI = {16'h0000, id[15:0]};

	assign PCPlusfour = ia + 32'd4;


	/* Instantiated Modules */
	/*---------------COMMENT THIS OUT IF TESTING SIM-----------------*/
	dmem4 xdmem4(clk, memAddr, memWriteData, MemWrite, MemRead, memReadData); 
	imem4 ximem4(clk, ia, id);
	/*---------------------------------------------------------------*/

	pcctl xpcctl(irq, illOp, ia[31], PCControl); 
	ictl xictl(id[31:26], id[5:0], iControl);
	jctl xjctl(ia, id, radata, zeroPadI, Branch, BranchControl, Jump, z, jumpSel);
	
	pc xpc(clk, reset, Jump, PCControl, inputAddr, ia);
	regfile xregfile(clk, RegWrite, RegDst, id[25:21], id[20:16], id[15:11], wdata, radata, memWriteData);
	ctl xctl(reset, irq, ia[31], id[31:26], id[5:0], RegDst, ALUSrc, RegWrite, MemWrite, MemRead, MemToReg, ALUOp, ASel, Branch, BranchControl, Jump, illOp);
	alu xalu(raSel, controlRbdata, ALUOp, memAddr, z, v, n);

	always_comb begin
		case(PCControl)
		2'b00:
			inputAddr <= jumpSel;
		2'b01:
			inputAddr <= 32'h80000008;
		2'b10:
			inputAddr <= 32'h80000004;
		default:
			inputAddr <= ia;
		endcase
	end

	always_comb begin
		case(id[15]) 
		1'b0:
			signExtend <= {16'h0000, id[15:0]};
		1'b1: 
			signExtend <= {16'hFFFF, id[15:0]};
		default: 
			signExtend <= {16'h0000, id[15:0]};

		endcase
	end

	always_comb begin
		case(iControl) 	
		2'b00:
			controlOutput <= zeroPadShamt;
		2'b01:
			controlOutput <= signExtend;
		2'b10:
			controlOutput <= zeroPadI;
		default:
			controlOutput <= zeroPadShamt;
		endcase
	end

	always_comb begin
		case(ALUSrc) 
		1'b0:
			controlRbdata <= memWriteData;
		1'b1:
			controlRbdata <= controlOutput;
		default: 
			controlRbdata <= memWriteData;
		endcase
	end

	always_comb begin
		case(MemToReg) 
		1'b0:
			wdata <= memAddr;
		1'b1:
			wdata <= memReadData;
		default:
			wdata <= memAddr;
		endcase
	end

	always_comb begin
		case(ASel) 
		1'b0:
			raSel <= radata;
		1'b1:
			raSel <= PCPlusfour;
		default:
			raSel <= radata;	
		endcase
	end

endmodule
