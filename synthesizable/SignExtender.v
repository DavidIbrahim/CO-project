module SignExtender(input signed [15:0]in ,output reg signed [31:0]out);
	initial
		begin
			out<=0;
		end
	always@*
		begin				   
			out={{16{in[15]}},in[15:0]};
			//out[15:0]=[15:0]in;	
		end
		
endmodule

module SignExtenderTestBench;
	
	reg [15:0] numberToExtend;
	wire [31:0] extendedNumber;
	SignExtender s1(numberToExtend,extendedNumber);
	initial
		begin
			//$monitor($time,,,"numberToExtend=%d extendedNumber=%d",numberToExtend,extendedNumber);
			numberToExtend=16'b0111111111111111;
			#10
			numberToExtend=16'b1111110111111111;
		end											
		
	endmodule
