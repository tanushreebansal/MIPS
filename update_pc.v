module update_pc(PCWriteEnable,PCWriteCond,zero,PCWrite,next_pc,clk);
  output reg PCWriteEnable;
  input wire [31:0] next_pc;
  input wire PCWriteCond,zero,PCWrite,clk;
  reg temp;
  
  always@(zero or PCWriteCond or PCWrite)
    begin
      temp = zero & PCWriteCond;
      PCWriteEnable = temp | PCWrite;
    end
  endmodule

