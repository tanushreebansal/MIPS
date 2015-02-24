module register(d_out,d_in);// For state registers : A,B,ALUOut,MDR
  parameter SIZE=32;
  output reg[SIZE-1:0]d_out;
  input wire[SIZE-1:0]d_in;
  
  always@(d_in)
    begin
        d_out <= d_in;
    end
    
endmodule
      
  
