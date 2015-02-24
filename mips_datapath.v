/* Group 9 
  TANUSHREE BANSAL (2010C6PS656G)
  BANDLA VENKATA KRISHNA (2010C6PS416G)
  VANSH MUDGIL (2010C6PS474G)
  G.GNANAPRIYA (2010C6PS577G)
*/

module mips_datapath(cycle,ALUControl,clk,rst);

  output wire[3:0] ALUControl;
  input wire clk,rst;
  output reg [31:0] cycle = 32'd0;

      always @ (posedge clk)
          begin
            cycle = cycle + 1;
          end


  // PC initialized
  reg[31:0] PC;
  initial
     begin
        PC <=32'd168;
    end
  
  
  //control wires
  wire [1:0] PCSource,ALUSrcA,ALUSrcB;
  wire PCWriteCond,PCWrite,IorD,MemRead,MemWrite,MemtoReg,IRWrite,RegWrite,RegDst;

  //data path wires
  wire [31:0] IorDMux,MemData,IROut,MDROut,MemtoRegMux,SignExtendOut,ZeroExtendOut,sign_extend_shift_2,RD1,RD2,ARegOut,BRegOut,
  ALUSrcA_out,ALUSrcB_out,ALUResult,ALURegOut,next_pc;
  wire [4:0] RtRdMux;
  reg[31:0] prev_alu;

  

  /* pcMux
      IorD = 0 ie address is for instruction
      IorD = 1 ie address is for data   
  */   
 assign IorDMux = IorD ? ALURegOut : PC;
  
  
  //memory
  memory MEM(MemData,IorDMux,BRegOut,MemRead,MemWrite,clk);
 
  //Instruction register
  IR_reg IR(IROut,MemData,IRWrite);


  //Memory Data Register
  register MDR(MDROut,MemData);

  //Control unit
  control CONT(PCWriteCond,PCWrite,IorD,MemRead,MemWrite,MemtoReg,IRWrite,PCSource,ALUControl,ALUSrcA,ALUSrcB,RegWrite,RegDst,IROut[31:26],IROut[5:0],clk,rst);

  //instruction decoding
  /* RegDst :
      0 => Rt is the destination register
      1 => Rd is the destination register
  */
   mux2to1 MUX3(RtRdMux,IROut[20:16],IROut[15:11],RegDst);
   
   
    /* MemtoReg :
      0 => Data to be written back in the write register comes from alu
      1 => Data to be written back in the write register comes from memory (in case of LW)
  */
   assign MemtoRegMux = MemtoReg ?MDROut:ALURegOut ;

  //Registers
  regfile REGFILE(RD1,RD2,IROut[25:21],IROut[20:16],RtRdMux,MemtoRegMux,RegWrite,clk);
  register A(ARegOut,RD1);
  register B(BRegOut,RD2);

   // sign extend and shift 2;
  sign_extend SE1(SignExtendOut,IROut[15:0]);//for lw,sw,addi,subi
  assign sign_extend_shift_2 = SignExtendOut*4;//for beq
   
  //zero extend for sll instruction
  zero_extend ZE1(ZeroExtendOut,IROut[10:6]);

  //muxes for ALU input
  mux_4to1 MUX0(ALUSrcA_out,PC,ARegOut,ZeroExtendOut,ZeroExtendOut,ALUSrcA);
  mux_4to1 MUX1(ALUSrcB_out,BRegOut,32'd4,SignExtendOut,sign_extend_shift_2,ALUSrcB);


  //ALU
  ALU alu(ALUResult,zero,ALUSrcA_out,ALUSrcB_out,ALUControl);
  register ALUOUT(ALURegOut,ALUResult);
   
   //Creating a delay to save the branch address when branch comparsion takes place
   always@(ALUResult)
    begin
    #40
       prev_alu <= ALUResult;
    end
  
  
  //jump address calculation
    wire [31:0] jump_address;
   assign jump_address = {PC[31:28],IROut[25:0],2'b00};
   
  mux_4to1 MUX2(next_pc,ALUResult,prev_alu,jump_address,jump_address,PCSource);

  //updating pc
   wire PCWriteEnable; 
   update_pc UPC(PCWriteEnable,PCWriteCond,zero,PCWrite,next_pc,clk);
   always@(posedge clk) 
           begin 
            if(PCWriteEnable==1'b1)
             begin 
                  PC <= next_pc; 
            end 
          end 
 

endmodule