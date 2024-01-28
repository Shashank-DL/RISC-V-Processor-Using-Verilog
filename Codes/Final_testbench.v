module final_testbench();
 reg reset_; initial begin reset_=0; #22 reset_=1; #320 $stop; end
  reg clock;  initial clock=0; always #5 clock<=(!clock);
 // instantiate device to be tested
 risc_v dut(clock, reset_);

initial begin wait(reset_); #300
      $display("REG\tRESULT\t    EXPECTED");
      $display("R2\t%h\t0x19",dut.mycore.DP.rf.regFile[2]);    //register file which holds the o/p value is stored in x2 acessed and displayed for ans in 
      $finish;                                               
   end

endmodule 
