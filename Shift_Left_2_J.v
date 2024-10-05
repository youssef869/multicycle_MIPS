module Shift_Left_2_J(
input  wire [25:0] in,
output wire [27:0] out
);

assign out = in << 2;
endmodule