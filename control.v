module control(PCWriteCond,PCWrite,IorD,MemRead,MemWrite,MemtoReg,IRWrite,PCSource,ALUcontrol,ALUSrcA,ALUSrcB,RegWrite,RegDst,opcode,func,clk,rst);
  
  output reg PCWriteCond,PCWrite,IorD,MemRead,MemWrite,MemtoReg,IRWrite,RegWrite,RegDst;
  output reg [1:0] PCSource,ALUSrcA,ALUSrcB;
  output reg [3:0] ALUcontrol;
  input wire clk,rst;
  input wire [5:0] opcode,func;
  parameter
    ZERO = 4'b0000,
    ONE = 4'b0001, 
    TWO = 4'b0010,
    THREE = 4'b0011,
    FOUR = 4'b0100,
    FIVE = 4'b0101,
    SIX = 4'b0110,
    SEVEN =4'b0111,
    EIGHT= 4'b1000,
    NINE= 4'b1001,
    TEN = 4'b1010,
    ELEVEN = 4'b1011;
    
    
    reg [3:0] present_state,next_state;
    
    always@(present_state,opcode,func)
      begin
        case(present_state)
          
          ZERO: next_state = ONE;
          
          ONE : begin
                  case(opcode)
                    
                      6'b000001: next_state = TWO;//lw
                      6'b000010: next_state = TWO;//sw
                      6'b000011:next_state = TEN;//addi
                      6'b000101:next_state = EIGHT;// Beq
                      6'b000110:next_state = NINE;// j
                      6'b000000: next_state = SIX;// R-type
                      6'b000100:next_state = TEN;//subi
                      default: next_state = ZERO;                      
                    endcase
                end
        TWO: begin
                case(opcode)
                   6'b000001:next_state = THREE;//LW
                   6'b000010:next_state = FIVE;// SW
                   
                endcase 
             end
        
        THREE: next_state = FOUR;
        
        FOUR : next_state = ZERO;
        FIVE : next_state = ZERO;
        
        SIX : next_state = SEVEN;
        
        SEVEN : next_state = ZERO;
        
        EIGHT : next_state = ZERO;
        NINE : next_state = ZERO;
        
        TEN : next_state = ELEVEN;
        ELEVEN : next_state = ZERO;
      

      endcase
  end
                
  always @(posedge clk, negedge rst)
    begin
      if (!rst)
        present_state <= ZERO;
      else
        present_state <= next_state;
  end
  
  
  always@(present_state)
    begin
      PCWriteCond <= 1'b0;
      PCWrite <= 1'b0;
      IorD <= 1'b0;
      MemRead <= 1'b0;
      MemWrite <= 1'b0;
      MemtoReg <= 1'b0;
      IRWrite <= 1'b0;
      PCSource <= 2'b00;
      ALUcontrol <= 4'b1111;
      ALUSrcA <= 2'b00;
      ALUSrcB <= 2'b00;
      RegWrite <= 1'b0;
      RegDst <= 1'b0;
  
      
      case(present_state)
         ZERO: begin
                 MemRead <= 1'b1;
                 IRWrite <= 1'b1;
                 ALUSrcB <= 2'b01;
                 PCWrite <= 1'b1;
                 ALUcontrol <= 4'b0010;
                 
               end
               
        ONE:  begin
                ALUSrcB <= 2'b11;
                ALUcontrol <= 4'b0010;
              end
                        
        TWO: begin
                ALUSrcA <= 2'b01;
                ALUSrcB <= 2'b10;
                ALUcontrol <= 4'b0010;
                           
             end

      THREE: begin
                MemRead <= 1'b1;
                IorD <= 1'b1;
             end
             
      FOUR: begin
                RegDst <= 1'b0;
                RegWrite <= 1'b1;
                MemtoReg <= 1'b1;
            end

      FIVE : begin
                MemWrite <= 1'b1;
                IorD <= 1'b1;
             end 
             
      SIX: begin
             ALUSrcA <= 2'b01;
             RegDst <= 1'b1;
              case(func)
                
                   6'b100000: ALUcontrol <= 4'b0010;//add
                   6'b100001: ALUcontrol <= 4'b0110;//subtract
                   6'b100010: ALUcontrol <= 4'b0000;//AND
                   6'b100011: ALUcontrol <= 4'b0001;//OR
                   6'b100100: ALUcontrol <= 4'b1100;//NOR
                   6'b100101: begin
                               ALUcontrol <= 4'b1001;//sll
                               ALUSrcA <= 2'b10;
                              end
              endcase
              
           end
           
      SEVEN: begin
              RegDst <= 1'b1;
              RegWrite <= 1'b1;
            end
            
      EIGHT: begin
               ALUSrcA <= 2'b01;
               ALUcontrol <= 4'b0110;
               PCWriteCond <= 1'b1;
               PCSource <= 2'b01;
            
             end
             
     NINE : begin
              PCWrite <= 1'b1;
              PCSource <= 2'b10;
            end
    TEN: begin
            
            ALUSrcA <= 2'b01;
            ALUSrcB <= 2'b10;
            case(opcode)
              6'b000011:ALUcontrol <= 4'b0010;
              6'b000100:ALUcontrol <= 4'b0110;
           endcase
         end
    ELEVEN: begin
                RegDst <= 1'b0;
                RegWrite <= 1'b1;
            end

    endcase
  end
endmodule      