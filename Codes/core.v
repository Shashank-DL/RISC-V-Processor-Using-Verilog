module core(clock, reset_, readDataDMem, instr, pc, memwrite, memread, aluOut, readData2);
   input clock, reset_;
   input[31:0] readDataDMem,instr;
   output[31:0] pc, aluOut, readData2;
   output memwrite, memread;
   wire memtoreg,alusrcA,alusrcB,regwrite,selBranch,jump,zero,LSb_aluresult;
   wire[3:0] alucontrol;

   controller C(instr[6:0], instr[31:25], instr[14:12], zero, LSb_aluresult, memtoreg, memwrite, memread, selBranch, alusrcA, alusrcB, regwrite, alucontrol, jump);
   datapath DP(clock, reset_, memtoreg, regwrite, alucontrol, instr, readDataDMem, zero, pc, aluOut, readData2, selBranch, alusrcA, alusrcB, jump, LSb_aluresult);
endmodule
