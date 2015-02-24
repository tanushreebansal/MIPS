module ALU(alu_result,zero,input1,input2,alu_control);
  output reg [31:0] alu_result;
  output reg zero;
  input wire [31:0] input1,input2;
  input wire [3:0] alu_control;
 
 initial
    begin
        alu_result = 32'h0000_0000;
        zero = 1'b0;
    end
    


  always @(alu_control,input1,input2)
      begin
          case (alu_control)
          4'b0010: alu_result <= input1 + input2;//add
          4'b0110: alu_result <= input1 - input2;//sub
          4'b0000: alu_result <= input1 & input2;//AND
          4'b0001: alu_result <= input1 | input2;//OR
          4'b1100: alu_result <= ~(input1 | input2);//NOR
          4'b1001: alu_result <= input2 << input1 ;//sll
       endcase
       
      end
       
  always@(alu_result)       
    begin
      if(alu_result == 32'h0000_0000)
            zero = 1'b1;
        else
            zero = 1'b0;
    end
endmodule
