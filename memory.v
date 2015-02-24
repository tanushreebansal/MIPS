module memory(mem_data,address,write_data,mem_read,mem_write,clk);
 
output reg [31:0] mem_data;
input wire [31:0] write_data;
input wire [31:0] address;
input wire mem_read,mem_write,clk;


reg [7:0] memory[0:1023];

  always @(address,mem_read,mem_write)
    begin
          case({mem_read,mem_write})
            2'b10:  begin
                      mem_data[31:24] <= memory[address];
                      mem_data[23:16] <= memory[address+1];
                      mem_data[15:8] <= memory[address+2];
                      mem_data[7:0] <= memory[address+3]; 
              
                      end
                      
            2'b01:
                    begin
                      memory[address] <= write_data[31:24];
                      memory[address+1] <= write_data[23:16];
                      memory[address+2] <= write_data[15:8];
                      memory[address+3] <= write_data[7:0];
                    
                    end
          endcase
    end
       
  initial 
    begin  
        //load data
        memory[0] <= 8'h00;
        memory[1] <= 8'h00;
        memory[2] <= 8'h00;
        memory[3] <= 8'h08;
        
        memory[4] <= 8'h00;
        memory[5] <= 8'h00;
        memory[6] <= 8'h00;
        memory[7] <= 8'h04;
        
        memory[8] <= 8'h00;
        memory[9] <= 8'h00;
        memory[10] <= 8'h00;
        memory[11] <= 8'h01;
        
        
        /*instructions*/
        
      /*R-Type*/      
      
      
          // beq r16 r17 3
          memory[128] <= 8'h16; 
          memory[129] <= 8'h11;
          memory[130] <= 8'h00;
          memory[131] <= 8'h03;
           
       /* // add r2,r0,r1
          memory[128] <= 8'h00; 
          memory[129] <= 8'h01;
          memory[130] <= 8'h10;
          memory[131] <= 8'h20;*/
         
          // sub r3,r1,r0
          memory[132] <= 8'h00; 
          memory[133] <= 8'h20;
          memory[134] <= 8'h18;
          memory[135] <= 8'h21; 
        
          // and r4,r0,r1
          memory[136] <= 8'h00; 
          memory[137] <= 8'h01;
          memory[138] <= 8'h20;
          memory[139] <= 8'h22; 
      
          // or r5,r0,r1
          memory[140] <= 8'h00; 
          memory[141] <= 8'h01;
          memory[142] <= 8'h28;
          memory[143] <= 8'h23; 
        
          //nor r6 r8 r8
          memory[144] <= 8'h01; 
          memory[145] <= 8'h08;
          memory[146] <= 8'h30;
          memory[147] <= 8'h24;
          
          
          //sll r7 r0 1
          memory[148] <= 8'h00; 
          memory[149] <= 8'h00;
          memory[150] <= 8'h38;
          memory[151] <= 8'h65;  
        
        
        
        
      /* I-Type */
      
        // addi r9 r1 4
          memory[152] <= 8'b0000_1100; 
          memory[153] <= 8'b0010_1001;
          memory[154] <= 8'h00;
          memory[155] <= 8'h04;
          
           // subi r10 r1 1
          memory[156] <= 8'h10; 
          memory[157] <= 8'b0010_1010;
          memory[158] <= 8'h00;
          memory[159] <= 8'h01;
         
          // lw r8 4(r16) 
          memory[160] <= 8'h06; 
          memory[161] <= 8'h08;
          memory[162] <= 8'h00;
          memory[163] <= 8'h04;
          
          // sw r1 0(r16) 
          memory[164] <= 8'b0000_1010; 
          memory[165] <= 8'h01;
          memory[166] <= 8'h00;
          memory[167] <= 8'h00;
          
         
          
          /* J- Type */
        // j 128 
          memory[168] <= 8'h18; 
          memory[169] <= 8'h00;
          memory[170] <= 8'h00;
          memory[171] <= 8'h20;
          
      /*  // beq r16 r17 128
          memory[172] <= 8'h16; 
          memory[173] <= 8'h11;
          memory[174] <= 8'h00;
          memory[175] <= 8'h80;*/
           
      
    end
endmodule

