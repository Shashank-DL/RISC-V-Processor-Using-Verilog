module controller(opcode, funct7, funct3, zero, LSb_aluresult, memtoreg, memwrite, memread, selBranch, alusrcA, alusrcB, regwrite, alucontrol, jump);
   input[6:0] opcode;
   input[6:0] funct7;
   input[2:0] funct3;
   input zero;
   input LSb_aluresult; // Less significant bit of alu result
   output memtoreg, memwrite, memread, alusrcA, alusrcB ,regwrite, selBranch, jump;
   output [3:0] alucontrol;
   wire [1:0] aluop;
   wire branch;

   maindec MainDec(opcode, memtoreg, memwrite, memread, jump, branch, alusrcA, alusrcB, regwrite, aluop, funct3);
   aludec  AluDec(funct7, funct3, aluop, alucontrol);

   // Branch selection
   wire beq_enable;
   wire blt_enable;
   assign beq_enable = branch & zero;
   assign blt_enable = branch & LSb_aluresult;
   // To avoid delay of the  2-input AND gate (propagation time = 60ps)
   assign selBranch = (opcode==7'b1100011) ? ( (funct3==3'b000) ? beq_enable : blt_enable ) :
                      opcode==7'b0110011 ? 1'b0 :
                      opcode==7'b0000011 ? 1'b0 :
                      opcode==7'b0100011 ? 1'b0 :
                      opcode==7'b0010011 ? 1'b0 :
                      opcode==7'b0010111 ? 1'b0 :
                      opcode==7'b1101111 ? 1'b0 : 1'bx;
endmodule
