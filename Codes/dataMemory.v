module dataMemory(clock, writeEnable, address, writeData, readData);
   input clock, writeEnable;
   input[5:0] address;
   input[31:0] writeData;
   output[31:0] readData;
   reg [31:0] RAM2[0:63];
   assign readData = RAM2[address[5:2]];
   always @(posedge clock)
   if (writeEnable) RAM2[address[5:2]] <= writeData;
endmodule
