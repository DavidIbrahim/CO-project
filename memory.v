module InstMem(Pc,Clk,InstReg);

input [31:0] Pc ;  // program counter to identify which inst
input  Clk; // same for all of the program

output reg [31:0] InstReg ; //  the inst that coincides with that pc number 

reg [31:0]IMemory[0:1023]; //  the memory reg.s .
initial
		begin	
			integer i;
			for(i=0;i<1024;i=i+1)
				begin
					IMemory[i]=0;
				end									 
		$readmemb("instructionMemory.txt",IMemory);	
end					

always @(posedge Clk)
begin
	//$display("k %b",IMemory[0]);
	$display("k %b",Pc);	
	//$display("k %b",Clk);	
	InstReg <= IMemory[Pc>>2]; // as pc points to a bit so divide by 4 to point to a word 
        
end

endmodule




module DataMem ( Address , writeData , MemRead , MemWrite  , Clk , ReadData );

input [31:0] Address   ; // the address to read or write  in . 
input [31:0] writeData ; // the data to be writen in that address . 
input  MemWrite ; // write enable . 
input  MemRead  ; // read  enable .
input Clk; 	  // all compennts must have same clk 	.

output reg [31:0] ReadData ; // data to be read from memory.

reg[31:0]DMemory[0:1023]; // the memory reg.s .

initial
		begin	
			integer i;
			for(i=0;i<1024;i=i+1)
				begin
					DMemory[i]=0;
				end		
				$display("%b",DMemory[1]);
		$readmemb("DataMemory.txt",DMemory);		
		$display("%b",DMemory[1]);
end	
always @(posedge Clk )
begin			 
	$display("it is a posedge");
if (MemWrite)
	DMemory[Address>>2] <= writeData ;  
else   
	begin						
		$display("mem Write=0,address=%b",Address>>2);
	ReadData <= DMemory[Address>>2] ; 	
	$display("ReadData=%b",ReadData);
	end

end

endmodule




module ClkGen (Clk);



output reg Clk ; // FREQ = 1/ 2*N *10 pow(-9)

initial 
Clk = 0 ;

always
begin
#1 Clk  = 0 ;//N=1
#1 Clk  = 1 ;
end

endmodule

module Mux_5bits ( in1 , in2 , sel , out);
input [4:0] in1,in2;
input sel;
output reg [4:0] out ;

always @ (in1 or in2 or sel)
begin
if(sel ==1'b0)
 out = in1 ;
else out = in2 ;
end
endmodule

