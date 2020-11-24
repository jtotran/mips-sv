module ctl(input logic reset, irq,
	input logic supervisorBit,
	input logic [5:0] opCode,
	input logic [5:0] funct,
	output logic [1:0] RegDst, 
	output logic ALUSrc, RegWrite,
	output logic MemWrite, MemRead, 
	output logic MemToReg,
	output logic [4:0] ALUOp,
	output logic Branch, BranchControl,
	output logic [1:0] Jump,
	output logic illOp
);

	always_comb begin
		if(reset) begin
			RegDst <= 2'b00;
			ALUSrc <= 1'b0;
			RegWrite <= 1'b0;
			MemWrite <= 1'b0;
			MemRead <= 1'b0;
			MemToReg <= 1'b0;
			ALUOp <= 5'b00000;

			// ASel <= 1'b00;
			Branch <= 1'b0;
			BranchControl <= 1'b0;
			Jump <= 2'b00;
			illOp <= 1'b0;
		end
		/*
		else if(irq && !supervisorBit) begin
			RegDst <= 2'b10;
			ALUSrc <= 1'b0;
			RegWrite <= 1'b1;
			MemWrite <= 1'b0;
			MemRead <= 1'b0;
			MemToReg <= 1'b0;
			ALUOp <= 5'b11010;

			ASel <= 1'b1;
			Branch <= 1'b0;
			BranchControl <= 1'b0;
			Jump <= 2'b00;
			illOp <= 1'b0;
		end
		*/
		else begin
		case(opCode) 
			// R-Type Instructions
			6'b000000: begin
				case(funct) 
					// shift left logical
					6'b000000: begin
						RegDst <= 2'b00;
						ALUSrc <= 1'b1;
						RegWrite <= 1'b1;
						MemWrite <= 1'b0;
						MemRead <= 1'b0;
						MemToReg <= 1'b0;
						ALUOp <= 5'b01000;

						// ASel <= 2'b00;
						Branch <= 1'b0;
						BranchControl <= 1'b0;
						Jump <= 2'b00;
						illOp <= 1'b0;
					end
					// shift right logical
					6'b000010: begin
						RegDst <= 2'b00;
						ALUSrc <= 1'b1;
						RegWrite <= 1'b1;
						MemWrite <= 1'b0;
						MemRead <= 1'b0;
						MemToReg <= 1'b0;
						ALUOp <= 5'b01001;

						// ASel <= 2'b00;
						Branch <= 1'b0;
						BranchControl <= 1'b0;
						Jump <= 2'b00;
						illOp <= 1'b0;
					end
					// shift right arithmetic 
					6'b000011: begin
						RegDst <= 2'b00;
						ALUSrc <= 1'b1;
						RegWrite <= 1'b1;
						MemWrite <= 1'b0;
						MemRead <= 1'b0;
						MemToReg <= 1'b0;
						ALUOp <= 5'b01011;

						// ASel <= 2'b00;
						Branch <= 1'b0;
						BranchControl <= 1'b0;
						Jump <= 2'b00;
						illOp <= 1'b0;
					end
					// add
					6'b100000: begin
						RegDst <= 2'b00;
						ALUSrc <= 1'b0;
						RegWrite <= 1'b1;
						MemWrite <= 1'b0;
						MemRead <= 1'b0;
						MemToReg <= 1'b0;
						ALUOp <= 5'b00000;

						// ASel <= 2'b00;
						Branch <= 1'b0;
						BranchControl <= 1'b0;
						Jump <= 2'b00;
						illOp <= 1'b0;
					end
					// subtract
					6'b100010: begin
						RegDst <= 2'b00;
						ALUSrc <= 1'b0;
						RegWrite <= 1'b1;
						MemWrite <= 1'b0;
						MemRead <= 1'b0;
						MemToReg <= 1'b0;
						ALUOp <= 5'b00001;

						// ASel <= 2'b00;
						Branch <= 1'b0;
						BranchControl <= 1'b0;
						Jump <= 2'b00;
						illOp <= 1'b0;
					end
					// and
					6'b100100: begin
						RegDst <= 2'b00;
						ALUSrc <= 1'b0;
						RegWrite <= 1'b1;
						MemWrite <= 1'b0;
						MemRead <= 1'b0;
						MemToReg <= 1'b0;
						ALUOp <= 5'b11000;

						// ASel <= 2'b00;
						Branch <= 1'b0;
						BranchControl <= 1'b0;
						Jump <= 2'b00;
						illOp <= 1'b0;
					end
					// or
					6'b100101: begin
						RegDst <= 2'b00;
						ALUSrc <= 1'b0;
						RegWrite <= 1'b1;
						MemWrite <= 1'b0;
						MemRead <= 1'b0;
						MemToReg <= 1'b0;
						ALUOp <= 5'b11110;

						 // ASel <= 2'b00;
						Branch <= 1'b0;
						BranchControl <= 1'b0;
						Jump <= 2'b00;
						illOp <= 1'b0;
					end
					// xor 
					6'b100110: begin
						RegDst <= 2'b00;
						ALUSrc <= 1'b0;
						RegWrite <= 1'b1;
						MemWrite <= 1'b0;
						MemRead <= 1'b0;
						MemToReg <= 1'b0;
						ALUOp <= 5'b10110;

						// ASel <= 2'b00;
						Branch <= 1'b0;
						BranchControl <= 1'b0;
						Jump <= 2'b00;
						illOp <= 1'b0;
					end
					// nor
					6'b100111: begin
						RegDst <= 2'b00;
						ALUSrc <= 1'b0;
						RegWrite <= 1'b1;
						MemWrite <= 1'b0;
						MemRead <= 1'b0;
						MemToReg <= 1'b0;
						ALUOp <= 5'b10001;

						// ASel <= 2'b00;
						Branch <= 1'b0;
						BranchControl <= 1'b0;
						Jump <= 1'b0;
						illOp <= 1'b0;
					end
					// set l. t.
					6'b101010: begin
						RegDst <= 2'b00;
						ALUSrc <= 1'b0;
						RegWrite <= 1'b1;
						MemWrite <= 1'b0;
						MemRead <= 1'b0;
						MemToReg <= 1'b0;
						ALUOp <= 5'b00111;

						 // ASel <= 2'b00;
						Branch <= 1'b0;
						BranchControl <= 1'b0;
						Jump <= 2'b00;
						illOp <= 1'b0;
					end
					// jump register 
					6'b001000: begin
						RegDst <= 2'b00;
						ALUSrc <= 1'b0;
						RegWrite <= 1'b0;
						MemWrite <= 1'b0;
						MemRead <= 1'b0;
						MemToReg <= 1'b0;
						ALUOp <= 5'b00000;

						// ASel <= 2'b00;
						Branch <= 1'b0;
						BranchControl <= 1'b0;
						Jump <= 2'b10;
						illOp <= 1'b0;
					end
					// nop
					default: begin
						RegDst <= 2'b10;
						ALUSrc <= 1'b0;
						RegWrite <= 1'b1;
						MemWrite <= 1'b0;
						MemRead <= 1'b0;
						MemToReg <= 1'b0;
						ALUOp <= 5'b11010;

						// ASel <= 2'b01;
						Branch <= 1'b0;
						BranchControl <= 1'b0;
						Jump <= 2'b00;
						illOp <= 1'b1;
						// ILLEGAL INSTRUCTIONS
					end
				endcase
			end
			// jump 
			6'b000010: begin
				RegDst <= 2'b00;
				ALUSrc <= 1'b0;
				RegWrite <= 1'b0;
				MemWrite <= 1'b0;
				MemRead <= 1'b0;
				MemToReg <= 1'b0;
				ALUOp <= 5'b00000;

				// ASel <= 2'b00;
				Branch <= 1'b0;
				BranchControl <= 1'b0;
				Jump <= 2'b01;
				illOp <= 1'b0;
			end
			// jump & link
			6'b000011: begin
				RegDst <= 2'b11;
				ALUSrc <= 1'b0;
				RegWrite <= 1'b1;
				MemWrite <= 1'b0;
				MemRead <= 1'b0;
				MemToReg <= 1'b0;
				ALUOp <= 5'b11010;

				// ASel <= 2'b01;
				Branch <= 1'b0;
				BranchControl <= 1'b0;
				Jump <= 2'b01;
				illOp <= 1'b0;
			end
			// branch eq 
			6'b000100: begin
				RegDst <= 2'b00;
				ALUSrc <= 1'b0;
				RegWrite <= 1'b0;
				MemWrite <= 1'b0;
				MemRead <= 1'b0;
				MemToReg <= 1'b0;
				ALUOp <= 5'b00001;

				// ASel <= 2'b00;
				Branch <= 1'b1;
				BranchControl <= 1'b0;
				Jump <= 2'b00;
				illOp <= 1'b0;
			end
			// branch neq 
			6'b000101: begin
				RegDst <= 2'b00;
				ALUSrc <= 1'b0;
				RegWrite <= 1'b0;
				MemWrite <= 1'b0;
				MemRead <= 1'b0;
				MemToReg <= 1'b0;
				ALUOp <= 5'b00001;

				// ASel <= 2'b00;
				Branch <= 1'b1;
				BranchControl <= 1'b1;
				Jump <= 2'b00;
				illOp <= 1'b0;
			end
			// addi
			6'b001000: begin
				RegDst <= 2'b01;
				ALUSrc <= 1'b1;
				RegWrite <= 1'b1;
				MemWrite <= 1'b0;
				MemRead <= 1'b0;
				MemToReg <= 1'b0;
				ALUOp <= 5'b00000;

				// ASel <= 2'b00;
				Branch <= 1'b0;
				BranchControl <= 1'b0;
				Jump <= 2'b00;
				illOp <= 1'b0;
			end
			// andi 
			6'b001100: begin
				RegDst <= 2'b01;
				ALUSrc <= 1'b1;
				RegWrite <= 1'b1;
				MemWrite <= 1'b0;
				MemRead <= 1'b0;
				MemToReg <= 1'b0;
				ALUOp <= 5'b11000;

				// ASel <= 2'b00;
				Branch <= 1'b0;
				BranchControl <= 1'b0;
				Jump <= 2'b00;
				illOp <= 1'b0;
			end
			// ori
			6'b001101: begin
				RegDst <= 2'b01;
				ALUSrc <= 1'b1;
				RegWrite <= 1'b1;
				MemWrite <= 1'b0;
				MemRead <= 1'b0;
				MemToReg <= 1'b0;
				ALUOp <= 5'b11110;

				// ASel <= 2'b00;
				Branch <= 1'b0;
				BranchControl <= 1'b0;
				Jump <= 2'b00;
				illOp <= 1'b0;
			end
			// xori
			6'b001110: begin
				RegDst <= 2'b01;
				ALUSrc <= 1'b1;
				RegWrite <= 1'b1;
				MemWrite <= 1'b0;
				MemRead <= 1'b0;
				MemToReg <= 1'b0;
				ALUOp <= 5'b10110;

				// ASel <= 2'b00;
				Branch <= 1'b0;
				BranchControl <= 1'b0;
				Jump <= 2'b00;
				illOp <= 1'b0;
			end
			// load word
			6'b100011: begin
				RegDst <= 2'b01;
				ALUSrc <= 1'b1;
				RegWrite <= 1'b1;
				MemWrite <= 1'b0;
				MemRead <= 1'b1;
				MemToReg <= 1'b1;
				ALUOp <= 5'b00000;

				// ASel <= 2'b00;
				Branch <= 1'b0;
				BranchControl <= 1'b0;
				Jump <= 2'b00;
				illOp <= 1'b0;
			end
			// store word
			6'b101011: begin
				RegDst <= 2'b00;
				ALUSrc <= 1'b1;
				RegWrite <= 1'b0;
				MemWrite <= 1'b1;
				MemRead <= 1'b0;
				MemToReg <= 1'b0;
				ALUOp <= 5'b00000;

				// ASel <= 2'b00;
				Branch <= 1'b0;
				BranchControl <= 1'b0;
				Jump <= 2'b00;
				illOp <= 1'b0;
			end
			// nop
			default: begin
				RegDst <= 2'b10;
				ALUSrc <= 1'b0;
				RegWrite <= 1'b1;
				MemWrite <= 1'b0;
				MemRead <= 1'b0;
				MemToReg <= 1'b0;
				ALUOp <= 5'b11010;

				// ASel <= 2'b01;
				Branch <= 1'b0;
				BranchControl <= 1'b0;
				Jump <= 2'b00;
				illOp <= 1'b1;
			end
		endcase
		end	
	end

endmodule 
