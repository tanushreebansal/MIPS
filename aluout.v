module pc(data_out,data_in,branch);
    
    output reg [31:0] data_out;
    input wire [31:0] data_in;
    input wire branch;
   
   always @(data_in,branch)
        begin          
              if(!branch)
                		data_out <= data_in;
              else
                	 data_out <= data_out;
         end 
endmodule
