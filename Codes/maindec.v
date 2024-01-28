
module maindec(opcode, memtoreg, memwrite, memread, jump, branch, alusrcA, alusrcB, regwrite, aluop, funct3);
   input [6:0] opcode;
   input [2:0] funct3;
   output memtoreg, memwrite, memread, jump, branch, alusrcA, alusrcB, regwrite;
   output [1:0] aluop;
   reg [9:0] controls;
   assign {regwrite, alusrcA, alusrcB, jump, branch, memwrite, memread, memtoreg, aluop} = controls;
   always @(opcode or funct3)
   casex(opcode)
     7'b0110011: controls <= 10'b1100000011;  // R-Type
     7'b0000011: controls <= 10'b1110001100;  // LW
     7'b0100011: controls <= 10'b0110010000;  // SW
     7'b0010011: controls <= 10'b1110000000;  // ADDI
     7'b0010111: controls <= 10'b1010000000;  // AUIPC
     7'b1101111: controls <= 10'b0011000000;  // JAL
     7'b1100011: casex(funct3)
                   3'b000: controls <= 10'b0100100001;  // BEQ
                   3'b100: controls <= 10'b0100100010;  // BLT
                   default: controls <= 10'bxxxxxxxxxx; // illegal op
                 endcase
     default: controls <= 10'bxxxxxxxxxx; // illegal op
   endcase
endmodule

