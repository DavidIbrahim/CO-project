
module RegisterFile(RR1,RR2,WR,WD,WE,Clk,Out1,Out2);

input [4:0] RR1 , RR2 ;  // the address of the registers to read
input [4:0] WR; // the address of the registers to write
input signed [31:0]  WD;   // data to write
input WE;    		//write enable
input Clk; 		

output reg signed [31:0] Out1 , Out2 ;  // output of reading register 1 and reading register 2

reg signed [31:0] registers[31:0]; // an array of 32 registers each of 32 bits

integer i;
initial
begin

	for(i=0;i<32;i=i+1)
		begin
			registers[i]=i;
		end				
end
// * //any change
always @(RR1 , RR2)
 begin
	
	Out1 <= registers[RR1]; 
	Out2 <= registers[RR2];
    

end



//posedge clk
always @(WE) //The register file should perform a write operation every clock cycle only if the ?write_enable? signal is set to true,
begin
if(WE) 
	registers[WR] <= WD ;
end
	

endmodule

module project1TestBench();
reg [4:0] RR1 , RR2 ;  // the address of the registers to read
reg [4:0] WR; // the address of the registers to write
reg [4:0]ShiftCount;
reg [31:0] WD;   // data to write
reg WE;    		//write enable
reg Clk; 
reg Mux_Ctrl;		
wire signed [31:0] Out1 , Out2 ; 
wire signed [31:0] ALUResult;
wire signed [31:0] DataToWrite;
reg [0:4]op;

OurALU z(ALUResult,overflow,Out1,Out2,op,ShiftCount);
Mux_32bits a (WD,ALUResult,Mux_Ctrl,DataToWrite);
RegisterFile s(RR1,RR2,WR,DataToWrite,WE,Clk,Out1,Out2);

initial
begin
$monitor($time ,, " %b  ReadData1 :%d ReadData2 :%d AluResult :%d DataToWrite : %d Zero : %d",Clk,Out1,Out2,ALUResult,DataToWrite,overflow);

$display("       //put -2 in register 0 and read data from reg (0&1) ");
#5
Mux_Ctrl=0;

Clk = 0;
RR1 = 0;
RR2 = 1;
WR=0;
WD =-2;
WE =1 ;

#4       // put 1200 in register 1 and read data from reg (0&1) and add reg 0 and 1
Mux_Ctrl = 0;

op=4'b0010;
RR1 = 0;
RR2 = 1;
WR=1;
WD =-2;
WE =1 ;

#5 // put 1300 in register 31 and readData from register (0 and 31) and add
Mux_Ctrl =0;
op=4'b0010;
RR1 = 0;
RR2 = 31;
WR=31;
WD =1300;
WE =1 ;

#5  // put -2000 in register 3  and read data from (3 and 31) and add
Mux_Ctrl =0 ;
RR1 = 3;
$display("add");
op=4'b0010;
RR2 = 31;
WR=3;
WD =-2000;
WE =1 ;

#5  //  read data from (3 and 0) and sub and write the result (-2000) in reg 5
Mux_Ctrl =1 ;
RR1 = 3;
RR2 = 0;
$display("sub");
op=4'b0110;
WR=5;
WD =-2000;
WE =1 ;

#5  //  read data from (0 and 5) and make AND between them
Mux_Ctrl =1 ;
RR1 = 0;
RR2 = 5;
$display("AND");
op=4'b0000;
WR=5;
WD =-2000;
WE =0 ;

#5  //  read data from (0 and 5) and make OR
Mux_Ctrl =1 ;
RR1 = 0;
RR2 = 5;
$display("OR");
op=4'b0001;
WR=5;
WD =-2000;
WE =0 ;

#5  //  read data from (0 and 31) and SLL reg 0 by two
Mux_Ctrl =1 ;
RR1 = 0;
RR2 = 31;
op=4'b1110;
$display("SLL by two");
WR=5;
WD =-2000;
WE =0 ;
ShiftCount = 5'b00010;

#5  //  read data from (0 and 31) and SRA reg 0 by two
Mux_Ctrl =1 ;
RR1 = 0;
RR2 = 31;
$display("SRA");

op=4'b1111;
WR=5;
WD =-2000;
WE =0 ;
ShiftCount = 5'b00010;

#5  //  read data from (0 and 31) and make greater than
Mux_Ctrl =1 ;
RR1 = 0;
RR2 = 31;
op=4'b1000;
WR=5;
WD =-2000;
WE =0 ;

$display("greater than");

ShiftCount = 5'b00010;

#5  //  read data from (0 and 31) and make nor
Mux_Ctrl =1 ;
RR1 = 0;
RR2 = 31;
op=4'b1100;
WR=5;
WD =-2000;
WE =0 ;

$display("Nor");

ShiftCount = 5'b00000;

end



always
begin
#2 Clk = ~Clk;
end

endmodule






module Mux_32bits ( in1 , in2 , sel , out);

input [31:0] in1,in2;
input sel;
output reg [31:0] out ;

always @ (in1 or in2 or sel)
begin
if(sel ==1'b0)   out = in1 ; // 0
else             out = in2 ; // 1
end

endmodule


module MuxTestBench;
reg [31:0]in1;
reg[31:0] in2;
reg sel;
wire [31:0]out;

initial
begin
$monitor("%d %d %d %b",out,in1,in2,sel);
#1
in1 = 5;
in2 =6;
sel=1'b0;
#10
in1 = 10;
in2  = 11;
sel = 1'b1;
 
end
Mux_32bits a ( in1 , in2 , sel , out);

endmodule


module OurALU (Result,zeroDetection,A,B,Op,ShiftCount);
// we ignored the zero detection as it will be done on the reg it self also we ignored the overflow
output reg zeroDetection;
output reg [31:0] Result;
//reg Overflow; // not needed for now

input signed[31:0] A;
input signed[31:0] B;
input [3:0] Op;
input [4:0] ShiftCount;

wire [31:0] B_neg;
assign B_neg = - B;
//assign zeroDetection = (A==B)? 1:0 ;

//Addition op 2
always @(A or B or Op)
begin
//$display("always enterred");
if(Op == 4'b0010)
begin
Result <= (A+B);	 
//$display($time,,"addition entered A=%d B=%d result=%d",A,B,Result);
// for overflow
//if(A[31]==B[31] && A[31]== ~Result[31]) Overflow <= 1;
//else Overflow <=0;
end

//Subtraction op 6
else if(Op == 4'b0110)
begin

Result <= (A-B);
// for overflow
//if(A[31]==B_neg[31] && A[31]== ~Result[31]) Overflow <= 1;
//else Overflow <=0;

end

//And op 0
else if(Op == 4'b0000)
begin

Result <= (A&B);
//Overflow <=0;

end

//Or op 1
else if(Op == 4'b0001)
begin

Result <= (A|B);
//Overflow <=0;

end

//Nor op 12
else if(Op == 4'b1100)
begin

Result <= ~(A|B);
//Overflow <=0;

end

//Shift left logical op 14
else if(Op == 4'b1110)
begin
Result <= (A<<ShiftCount);
//Overflow <= 0;
end

//Shift right logical op 15
else if(Op == 4'b1101)
begin
Result <= (A>>ShiftCount);
//Overflow <= 0;
end

//Shift right arithmetic op 13
else if(Op == 4'b1111)
begin
Result <= (A>>>ShiftCount);
//if(A[31]==~Result[31])
//Overflow <= 1;
//else Overflow <= 0;
end

//Greater than Op 8
else if(Op == 4'b1000)
  if(A>B) Result = 1; 
	else Result = 0;
//smaller than Op 7 (slt)
else if(Op == 4'b0111)
  if(A<B) Result = 1; 
	else Result = 0;
else
Result = 31'bz;
// this to make it not dependent on a clock and synthis the code later
end 


endmodule


module AndGate_1bit(in1,in2,out);
output out;
input in1,in2;	
assign out = in1 & in2;

endmodule 

module Mux4To1_32bits(in1,in2,in3,in4,sel,out);

	input[31:0] in1,in2,in3,in4;
	input[1:0]sel;
	output reg[31:0] out;	
	always@(in1 or in2 or in3 or in4 or sel)
		begin
			if(sel==2'b00) out=in1;//0
			else if(sel==2'b01) out=in2;//1
			else if(sel==2'b10) out=in3;//2
			else out=in4;//3
		end
			
endmodule