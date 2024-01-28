module instructionMemory(address, readData);
   input [5:0] address;
   output [31:0] readData;
   reg [31:0] RAM[0:63];
   initial $readmemh("instr_set.dat", RAM);         // here reads the data from risvtest file
   assign readData = RAM[address];
endmodule