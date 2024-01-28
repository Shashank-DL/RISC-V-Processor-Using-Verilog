module aludec(funct7, funct3, aluop, alucontrol);
    input [6:0] funct7;
    input [2:0] funct3;
    input [1:0] aluop;
    output [3:0] alucontrol;
    reg [3:0] alucontrol;
    always @(aluop or funct7 or funct3)
    case(aluop)
      2'b00: alucontrol <= 4'b0010; //add (for lw/sw/addi/auipc/jal)
      2'b01: alucontrol <= 4'b1010; //sub (for beq)
      2'b10: alucontrol <= 4'b1011; //slt (for blt)
      2'bxx: alucontrol <= 4'bxxxx;
      // R-type instructions
      default: casex(funct7)
        7'b0000000: casex(funct3)
		        3'b000: alucontrol <= 4'b0010; //add
		        3'b111: alucontrol <= 4'b0000; //and
		        3'b110: alucontrol <= 4'b0001; //or
		        3'b010: alucontrol <= 4'b1011; //slt
                      default: alucontrol <= 4'bxxxx;
			endcase
	 7'b0000001: casex(funct3)
                      3'b000: alucontrol <= 4'b0100; //mul
                      3'b100: alucontrol <= 4'b0101; //div
                      default: alucontrol <= 4'bxxxx;
		      endcase
	 7'b0100000: alucontrol <= 4'b1010; //sub
	 default: alucontrol <= 4'bxxxx;	//illegal operation
       endcase
    endcase
endmodule

