module mux2to1(y,a,b,sel);
  output reg [4:0] y;
  input wire [4:0] a,b;
  input wire sel;

  always @(*)
    begin
      if(!sel)
        y <= a;
      else if(sel)
        y <= b;
          end
endmodule


