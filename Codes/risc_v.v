module risc_v(clock,reset_);
   input clock, reset_;
   wire memwrite;
   wire [31:0] readDataDMem, instr, pc, aluOut, readData2;

   core mycore(clock, reset_, readDataDMem, instr, pc, memwrite, memread, aluOut, readData2);
   instructionMemory imem(pc[7:2], instr);
   dataMemory dmem(clock, memwrite, aluOut[5:0], readData2,  readDataDMem);
endmodule
