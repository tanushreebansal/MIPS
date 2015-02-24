module IR_reg(data_out,data_in,IRwrite);
    
    output reg [31:0] data_out;
    input wire [31:0] data_in;
    input wire IRwrite;
   
   always @(data_in,IRwrite)
        begin          
              if(IRwrite)
                
              		data_out <= data_in;
              
              else
                
                	data_out <= data_out;
                
        end 
endmodule

