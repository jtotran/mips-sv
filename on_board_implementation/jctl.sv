module jctl(
	input logic [31:0] ia, id, radata, zeroPadI,
	input logic Branch, BranchControl, 
	input logic [1:0] Jump, 
	input logic z,
	output logic [31:0] jumpSel
);

	logic [31:0] branchSel;
	logic [31:0] jumpExtend, jumpShift, jumpAddr;
	logic [6:0] jumpControl;

	assign jumpExtend = {{16{id[15]}},id[15:0]};
	assign jumpShift = jumpExtend << 4'h2;
	assign jumpAddr = {ia[31:28],jumpShift[27:0]};
	assign jumpControl = {Jump, jumpAddr[31], radata[31], BranchControl, z, branchSel[31]};

	logic [1:0] branchAddrSel;

	assign branchAddrSel = {Branch, zeroPadI[13]};

	always_comb begin
		case(branchAddrSel)
			2'b00:
				branchSel <= ia;
			2'b01:
				branchSel <= ia;
			2'b10:
				branchSel <= ia + ({16'h0000, zeroPadI[15:0]} << 2);
			2'b11:
				branchSel <= ia + ({16'hFFFF, zeroPadI[15:0]} << 2);
			default: 
				branchSel <= ia;
		endcase
	end

	always_comb begin
		casex(jumpControl) 
		7'b00XX00X: 
			jumpSel <= ia;
		7'b00XX010:
			jumpSel <= {1'b0, branchSel[30:0]};
		7'b00XX011:
			jumpSel <= {ia[31], branchSel[30:0]};
		7'b00XX100:
			jumpSel <= {1'b0, branchSel[30:0]};
		7'b00XX101:
			jumpSel <= {ia[31], branchSel[30:0]};
		7'b00XX11X:
			jumpSel <= ia;
		7'b010XXXX:
			jumpSel <= {1'b0, jumpAddr[30:0]};
		7'b011XXXX:
			jumpSel <= {ia[31], jumpAddr[30:0]};
		7'b10X0XXX:
			jumpSel <= {1'b0, radata[30:0]};
		7'b10X1XXX:
			jumpSel <= {ia[31], radata[30:0]};
		7'b110XXXX:
			jumpSel <= {1'b0, jumpAddr[30:0]};
		7'b111XXXX:
			jumpSel <= {ia[31], jumpAddr[30:0]};
		default:
			jumpSel <= ia;
		endcase
	end

endmodule
