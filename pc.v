module pc(data_out,data_in,PCwrite);
    
    output reg [31:0] data_out;
    input wire [31:0] data_in;
    input wire PCwrite;
   
   always @(data_in)
        begin          
              if(PCwrite)
                		data_out <= data_in;
              else
                	 data_out <= data_out;
         end 
endmodule
