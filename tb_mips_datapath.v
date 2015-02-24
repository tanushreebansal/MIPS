module tb_mips_datapath();
  reg clk,rst;
  wire[31:0] cycle;
  wire[3:0] ALUControl;
  

mips_datapath MD1(cycle,ALUControl,clk,rst);
 initial
    begin
     clk <=1'b0;  rst <= 1'b0;
    end

  always @(clk)
    begin
      //Clock time period = 20ns
      #20 clk <= ~clk;
      rst <= 1'b1;
    end

initial 
  begin
    #200 $stop;
  end

endmodule
