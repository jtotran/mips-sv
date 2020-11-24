module beta(
	input logic clk, reset, irq,
	output logic [31:0] ia, memAddr, 
	output logic MemWrite, MemRead
);

	logic illOp;
	logic [1:0] PCControl;
	logic [31:0] id;
	logic [31:0] inputAddr;

	logic [31:0] memWriteData;
	logic [31:0] radata;

	logic RegWrite;
	logic [1:0] iControl;
	logic [31:0] zeroPadShamt, signExtend, zeroPadI;

	logic [1:0] RegDst;
	logic ALUSrc;
	logic [4:0] ALUOp;


	//---------------------Forwarding Unit Signals Begin-----------------//
	logic [1:0] ASel;
	logic [1:0] forwardControl; 
	logic [31:0] forwardControlSel;

	logic [4:0] ra_pipe_id;
	logic [4:0] rb_pipe_id;
	//---------------------Forwarding Unit Signals End-------------------//


	logic z, v, n;
	logic [31:0] raSel;
	logic [31:0] controlOutput;
	logic [31:0] controlRbdata;
	
	logic [1:0] Jump;
	logic Branch, BranchControl;

	logic [31:0] PCPlusfour;
	logic [31:0] jumpExtend;
	logic [31:0] jumpShift;
	logic [31:0] jumpAddr, branchAddr;
	logic [31:0] branchSel, jumpSel;

	logic [31:0] memReadData;
 
	logic MemToReg;
	logic [4:0] regWriteDst;
	logic [31:0] wdata;
	

	//----------------------------IF/ID Pipeline Signals------------------//
	logic [31:0] ia_pipe_if, id_pipe_if;


	//----------------------------ID/EX Pipeline Signals------------------//
	logic MemToReg_pipe_id, RegWrite_pipe_id;
	logic MemRead_pipe_id, MemWrite_pipe_id;
	// logic [1:0] ASel_pipe_id;
	logic [1:0] iControl_pipe_id;
	logic ALUSrc_pipe_id;
	logic RegDst_pipe_id;
	logic [4:0] ALUOp_pipe_id;
	logic Branch_pipe_id, BranchControl_pipe_id;
	logic [1:0] Jump_pipe_id;
	logic [31:0] ia_pipe_id, id_pipe_id;
	logic [31:0] radata_pipe_id, memWriteData_pipe_id;
	logic [31:0] zeroPadShamt_pipe_id, signExtend_pipe_id, zeroPadI_pipe_id;


	//----------------------------EX/MEM Pipeline Signals------------------//
	logic MemToReg_pipe_ex, RegWrite_pipe_ex;
	logic MemRead_pipe_ex, MemWrite_pipe_ex;
	logic [31:0] JumpSel_pipe_ex;
	logic [31:0] memAddr_pipe_ex;
	logic [31:0] memWriteData_pipe_ex;
	logic [4:0] regWriteDst_pipe_ex;

	logic [31:0] id_pipe_ex;


	//----------------------------MEM/WB Pipeline Signals------------------//
	logic MemToReg_pipe_mem;
	logic RegWrite_pipe_mem;
	logic [31:0] memReadData_pipe_mem;
	logic [31:0] memAddr_pipe_mem;
	logic [4:0] regWriteDst_pipe_mem;

	logic [31:0] id_pipe_mem;

	//----------------------------Fetch Stage-----------------------------//
	// pc xpc(clk, reset, Jump, PCControl, inputAddr, ia);
	pc xpc(clk, reset, ia);
	imem x_imem(clk, ia, id);


	//----------------------------Decode Stage----------------------------//
	// regfile xregfile(clk, RegWrite, RegDst, id[25:21], id[20:16], id[15:11], wdata, radata, memWriteData);
	// NOTE: Pay attention to regWrite, regWriteDst, and wdata
	// ** regWrite_pipe_mem
	// ** regWriteDst_pipe_mem 
	// ** wdata_pipe_mem ? Maybe not...
	regfile xregfile(clk, RegWrite_pipe_mem, id_pipe_if[25:21], id_pipe_if[20:16], regWriteDst_pipe_mem, wdata, radata, memWriteData);
	// NOTE: irq should not matter at this moment 
	// NOTE: Take out ASel since this will be computed in the forwarding
	// unit
	// ctl xctl(reset, irq, ia_pipe_if[31], id_pipe_if[31:26], id_pipe_if[5:0], RegDst, ALUSrc, RegWrite, MemWrite, MemRead, MemToReg, ALUOp, ASel, Branch, BranchControl, Jump, illOp);
	ctl xctl(reset, irq, ia_pipe_if[31], id_pipe_if[31:26], id_pipe_if[5:0], RegDst, ALUSrc, RegWrite, MemWrite, MemRead, MemToReg, ALUOp, Branch, BranchControl, Jump, illOp);

	//----------------------------Execute Stage---------------------------//
	assign ra_pipe_id = id_pipe_id[25:21];
	assign rb_pipe_id = id_pipe_id[20:16];

	alu xalu(raSel, controlRbdata, ALUOp_pipe_id, memAddr, z, v, n);
	forwardUnit x_forwardUnit(clk, ra_pipe_id, rb_pipe_id, MemToReg_pipe_ex, RegWrite_pipe_ex, regWriteDst_pipe_ex, MemToReg_pipe_mem, RegWrite_pipe_mem, regWriteDst_pipe_mem, ASel, forwardControl);

	//----------------------------Memory Stage----------------------------//
	dmem x_dmem(clk, memAddr_pipe_ex, memWriteData_pipe_ex, MemWrite_pipe_ex, MemRead_pipe_ex, memReadData);

	
	//----------------------------Write-Back Stage------------------------//
	// regfile xregfile(clk, RegWrite, RegDst, id[25:21], id[20:16], id[15:11], wdata, radata, memWriteData);
	// NOTE: Values gets written back to regfile


	//----------------------------IF/ID Pipeline--------------------------//
	ifid x_ifid(clk, ia, id, ia_pipe_if, id_pipe_if);


	//----------------------------ID/EX Pipeline--------------------------//
	/*
	idex x_idex(
		clk,
		MemToReg, 
		RegWrite, 
		MemRead, 
		MemWrite,
		ASel,
		iControl,
		ALUSrc,
		RegDst,
		ALUOp,
		Branch,
		BranchControl,
		Jump,
		ia_pipe_if,
		id_pipe_if,
		radata,
		memWriteData,
		zeroPadShamt,
		signExtend,
		zeroPadI,
		MemToReg_pipe_id,
		RegWrite_pipe_id,
		MemRead_pipe_id,
		MemWrite_pipe_id,
		ASel_pipe_id,
		iControl_pipe_id,
		ALUSrc_pipe_id,
		RegDst_pipe_id,
		ALUOp_pipe_id,
		Branch_pipe_id,
		BranchControl_pipe_id,
		Jump_pipe_id,
		ia_pipe_id,
		id_pipe_id,
		radata_pipe_id,
		memWriteData_pipe_id,
		zeroPadShamt_pipe_id,
		signExtend_pipe_id,
		zeroPadI_pipe_id
	);
	*/ 
	idex x_idex(
		clk,
		MemToReg, 
		RegWrite, 
		MemRead, 
		MemWrite,
		iControl,
		ALUSrc,
		RegDst,
		ALUOp,
		Branch,
		BranchControl,
		Jump,
		ia_pipe_if,
		id_pipe_if,
		radata,
		memWriteData,
		zeroPadShamt,
		signExtend,
		zeroPadI,
		MemToReg_pipe_id,
		RegWrite_pipe_id,
		MemRead_pipe_id,
		MemWrite_pipe_id,
		iControl_pipe_id,
		ALUSrc_pipe_id,
		RegDst_pipe_id,
		ALUOp_pipe_id,
		Branch_pipe_id,
		BranchControl_pipe_id,
		Jump_pipe_id,
		ia_pipe_id,
		id_pipe_id,
		radata_pipe_id,
		memWriteData_pipe_id,
		zeroPadShamt_pipe_id,
		signExtend_pipe_id,
		zeroPadI_pipe_id
	);


	//----------------------------EX/MEM Pipeline--------------------------//
	exmem x_exmen(
		clk, 
		MemToReg_pipe_id, 
		RegWrite_pipe_id, 
		MemRead_pipe_id, 
		MemWrite_pipe_id, 
		jumpSel,
		memAddr,
		memWriteData_pipe_id,
		regWriteDst,
		id_pipe_id,
		MemToReg_pipe_ex,
		RegWrite_pipe_ex,
		MemRead_pipe_ex,
		MemWrite_pipe_ex,
		JumpSel_pipe_ex,
		memAddr_pipe_ex,
		memWriteData_pipe_ex,
		regWriteDst_pipe_ex,
		id_pipe_ex
	);


	//----------------------------EX/MEM Pipeline--------------------------//
	memwb x_memwb(clk, MemToReg_pipe_ex, RegWrite_pipe_ex, memReadData, memAddr_pipe_ex, regWriteDst_pipe_ex, id_pipe_ex, MemToReg_pipe_mem, RegWrite_pipe_mem, memReadData_pipe_mem, memAddr_pipe_mem, regWriteDst_pipe_mem, id_pipe_mem);

	//----------------------------Fetch Stage-----------------------------//
	/*
	always_comb begin
		if (illOp)  
			PCControl <= 2'b10;
		else begin
			case(irq) 
				1'b0:
		       			PCControl <= 2'b00;
				1'b1: begin
					case(ia[31]) 
						1'b0:
							PCControl <= 2'b01;
						1'b1:
							PCControl <= 2'b00;
						default:
							PCControl <= 2'b00;
					endcase
				end
				default:
					PCControl <= 2'b00;
			endcase
		end
	end

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
	*/

	//----------------------------Decode Stage----------------------------//
	always_comb begin
		zeroPadShamt <= {26'd0, id_pipe_if [11:6]};
		zeroPadI <= {16'h0000, id_pipe_if [15:0]};

		case(id_pipe_if [15]) 
			1'b0:
				signExtend <= {16'h0000, id_pipe_if [15:0]};
			1'b1: 
				signExtend <= {16'hFFFF, id_pipe_if [15:0]};
			default: 
				signExtend <= {16'h0000, id_pipe_if [15:0]};
		endcase

		case(id_pipe_if [31:26]) 
			6'b000000: begin
				case(id_pipe_if [5:0]) 
					6'b000000:
						iControl <= 2'b00;
					6'b000010:
						iControl <= 2'b00;
					6'b000011:
						iControl <= 2'b00;
					default: 
						iControl <= 2'b11;
				endcase
			end
			6'b001000:
				iControl <= 2'b01;
			6'b001100:
				iControl <= 2'b10;
			6'b001101:
				iControl <= 2'b10;
			6'b001110:
				iControl <= 2'b10;
			6'b100011:
				iControl <= 2'b01;
			6'b101011:
				iControl <= 2'b01;
			default:
				iControl <= 2'b11;
		endcase
	end


	//----------------------------Execute Stage----------------------------//
	// IMPORTANT: Changed the bit size of ASel
	// IMPORTANT: May need to change the control for ASel to the
	// forwarding unit 
	assign PCPlusfour = ia_pipe_id;
	
	always_comb begin
		case(ASel) 
			2'b00:
				raSel <= radata_pipe_id;
			2'b01: begin
				// raSel <= PCPlusfour + 4'h4;
				raSel <= memAddr_pipe_ex;
			end
			2'b10:
				raSel <= wdata;
			default:
				raSel <= radata_pipe_id;	
		endcase
	end

	//----------------------------Forwarding Unit Mux-----------------------//
	always_comb begin
		case(forwardControl) 
			2'b00:
				forwardControlSel <= memWriteData_pipe_id;
			2'b01:
				forwardControlSel <= memAddr_pipe_ex; 
			2'b10:
				forwardControlSel <= wdata;
			default: 
				forwardControlSel <= memWriteData_pipe_id;
		endcase

	end  

	//----------------------------ALUSrc2 Begin----------------------------//
	always_comb begin
		case(iControl_pipe_id) 	
			2'b00:
				controlOutput <= zeroPadShamt_pipe_id;
			2'b01:
				controlOutput <= signExtend_pipe_id;
			2'b10:
				controlOutput <= zeroPadI_pipe_id;
			default:
				controlOutput <= zeroPadShamt_pipe_id;
		endcase
	end

	always_comb begin
		case(ALUSrc_pipe_id) 
			1'b0: begin
				// controlRbdata <= memWriteData_pipe_id;
				controlRbdata <= forwardControlSel;
			end
			1'b1:
				controlRbdata <= controlOutput;
			default: 
				controlRbdata <= memWriteData_pipe_id;
		endcase
	end
	//----------------------------ALUSrc2 End----------------------------//


	//----------------------------Branch & Jump Logic Begin--------------//
	assign jumpExtend = {{16{id_pipe_id[15]}},id_pipe_id[15:0]};
	assign jumpShift = jumpExtend << 4'h2;
	assign jumpAddr = {PCPlusfour[31:28],jumpShift[27:0]};
	always_comb begin
		case(zeroPadI_pipe_id[13])
			1'b0:
				branchAddr <= PCPlusfour + ({16'h0000, zeroPadI_pipe_id[15:0]} << 2);
			1'b1:
				branchAddr <= PCPlusfour + ({16'hFFFF, zeroPadI_pipe_id[15:0]} << 2);
			default:
				branchAddr <= PCPlusfour + ({16'h0000, zeroPadI_pipe_id[15:0]} << 2);
		endcase
	end

	always_comb begin 
		case(Branch_pipe_id) 
			1'b0:
				branchSel <= PCPlusfour;
			1'b1:
				branchSel <= branchAddr;
			default:
				branchSel <= PCPlusfour;
		endcase
	end

	always_comb begin
		$display("branchSel: %h", branchSel);
		$display("PCPlusfour: %h", PCPlusfour);
		$display("jumpAddr: %h", jumpAddr);
		case(Jump_pipe_id)
			2'b00: begin
				case(BranchControl_pipe_id) 
					1'b0: begin
						case(z)
							1'b0:
								jumpSel <= PCPlusfour;
							1'b1: begin
								case(branchSel[31])
									1'b0:
										jumpSel <= {1'b0, branchSel[30:0]};

									1'b1:
										jumpSel <= {PCPlusfour[31], branchSel[30:0]};
									default:
										jumpSel <= {1'b0, branchSel[30:0]};
								endcase
							end
							default:
								jumpSel <= PCPlusfour;
						endcase
					end
					1'b1: begin
						case(z)
							1'b0: begin
								case(branchSel[31])
									1'b0:
										jumpSel <= {1'b0, branchSel[30:0]};

									1'b1:
										jumpSel <= {PCPlusfour[31], branchSel[30:0]};
									default:
										jumpSel <= {1'b0, branchSel[30:0]};
								endcase
							end
							1'b1:
								jumpSel <= PCPlusfour;
							default:
								jumpSel <= PCPlusfour;
						endcase

					end
					default: begin
						case(z)
							1'b0:
								jumpSel <= PCPlusfour;
							1'b1: begin
								case(branchSel[31])
									1'b0:
										jumpSel <= {1'b0, branchSel[30:0]};

									1'b1:
										jumpSel <= {PCPlusfour[31], branchSel[30:0]};
									default:
										jumpSel <= {1'b0, branchSel[30:0]};
								endcase
							end
							default:
								jumpSel <= PCPlusfour;
						endcase

					end
				endcase
			end
			2'b01: begin       
				case(jumpAddr[31])
					1'b0:
						jumpSel <= {1'b0, jumpAddr[30:0]};

					1'b1:
						jumpSel <= {PCPlusfour[31], jumpAddr[30:0]};
					default:
						jumpSel <= {1'b0, jumpAddr[30:0]};
				endcase 
			end
			2'b10: begin
				case(radata_pipe_id[31])
					1'b0:
						jumpSel <= {1'b0, radata_pipe_id[30:0]};

					1'b1:
						jumpSel <= {PCPlusfour[31], radata_pipe_id[30:0]};
					default:
						jumpSel <= {1'b0, radata_pipe_id[30:0]};
				endcase
			end
			default: begin
				case(jumpAddr[31])
					1'b0:
						jumpSel <= {1'b0, jumpAddr[30:0]};

					1'b1:
						jumpSel <= {PCPlusfour[31], jumpAddr[30:0]};
					default:
						jumpSel <= {1'b0, jumpAddr[30:0]};
				endcase
			end
		endcase
	end
	//----------------------------Branch & Jump Logic End----------------//


	// IMPORTANT: Place RegDst Mux here...
	always_comb begin
		case(RegDst_pipe_id) 
			2'b00:
				regWriteDst <= id_pipe_id[15:11];
			2'b01:
				regWriteDst <= id_pipe_id[20:16];
			2'b10:
				regWriteDst <= 5'b00001;
			2'b11:
				regWriteDst <= 5'b11111;
			default:
				regWriteDst <= id_pipe_id[15:11];
		endcase
	end


	//----------------------------Mem Stage------------------------------//
	// NOTE: Write-Back Stage utilizes D-Mem


	//----------------------------Write-Back Stage-----------------------//
	always_comb begin
		case(MemToReg_pipe_mem) 
			1'b0:
				wdata <= memAddr_pipe_mem;
			1'b1:
				wdata <= memReadData_pipe_mem;
			default:
				wdata <= memAddr_pipe_mem;
		endcase
	end

endmodule
