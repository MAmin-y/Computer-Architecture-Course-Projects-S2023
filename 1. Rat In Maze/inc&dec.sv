module inc_and_dec(input [3:0] pi, input inc, dec, output reg [3:0] po, output poslim, neglim);
 always@(inc,dec,pi) begin
	po = (inc && ~poslim) ? pi + 1:
	      (dec && ~neglim) ? pi - 1:
	       pi;
  end
assign poslim = (inc && (&pi));
assign neglim = (dec && ~(|pi));
endmodule