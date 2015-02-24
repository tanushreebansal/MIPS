module regfile(Read_data1,Read_data2,Read_register1,Read_register2,Write_register,Write_data,RegWrite,clk);  
  output reg [31:0] Read_data1,Read_data2 ;
  input wire [4:0]  Read_register1,Read_register2,Write_register;
  input wire RegWrite,clk;
  input wire[31:0] Write_data;
  reg[5:0] i;
  reg[31:0] regfile[0:31];
    
    
    always @(posedge clk)
      begin
           Read_data1<= regfile[Read_register1];
           Read_data2<= regfile[Read_register2];
      end      
    
        
    always@(RegWrite)
      begin
        if(RegWrite == 1'b1)
          begin
            regfile[Write_register]<= Write_data;
          end
      end


        
        initial
          begin
            for(i=0;i<32;i=i+1)
                regfile[i] = 32'd0;
                
                regfile[0] <= 32'h0000_0006;
                regfile[1] <= 32'h0000_0009;
          end 
      endmodule

                    
                    
                
            

      