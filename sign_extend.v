// Sign Extender
module sign_extend(d_out,d_in);
  
  output wire [31:0] d_out;
  input wire [15:0] d_in;
  assign d_out = {{16{d_in[15]}},d_in[15:0]};
endmodule
