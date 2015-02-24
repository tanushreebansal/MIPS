module mux_4to1 (y,a,b,c,d,sel);
  output reg [31:0] y;
  input wire [31:0] a,b,c,d;
  input wire[1:0]sel;

always@(*)

begin
  casez(sel)
    2'b00: y<=a;
    2'b01: y<=b;
    2'b10: y<=c;
    2'b11: y<=d;
    default: y<=1'bz;
  endcase
end

endmodule
