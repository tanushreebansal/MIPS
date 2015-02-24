// Zero Extender
module zero_extend(d_out,d_in);
  
  output wire [31:0] d_out;
  input wire [4:0] d_in;
  assign d_out = {{27{1'b0}},d_in[4:0]};
endmodule

