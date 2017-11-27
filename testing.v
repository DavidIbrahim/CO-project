
module RegisterFile(RR1,RR2,WR,WD,WE,Clk,Out1,Out2);
input [4:0] RR1 , RR2 ;  // the address of the registers to read
input [4:0] WR; // the address of the registers to write

input signed [31:0]  WD;   // data to write
input WE;    		//write enable
input Clk; 		
output reg signed [31:0] Out1 , Out2 ;  // output of reading register 1 and reading register 2

reg signed [31:0] registers[31:0]; // an array of 32 registers each of 32 bits





always @(*)
 begin
	
	Out1 <= registers[RR1]; 
	Out2 <= registers[RR2];
    

end




always @(posedge Clk) //The register file should perform a write operation every clock cycle only if the ?write_enable? signal is set to true,
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
initial
begin
$monitor($time ,, " %b  ReadData1 :%d ReadData2 :%d AluResult :%d DataToWrite : %d",Clk,Out1,Out2,ALUResult,DataToWrite);

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

op=4'b0000;
RR1 = 0;
RR2 = 1;
WR=1;
WD =1200;
WE =1 ;

#5 // put 1300 in register 31 and readData from register (0 and 31) and add
Mux_Ctrl =0;
 
RR1 = 0;
RR2 = 31;
WR=31;
WD =1300;
WE =1 ;
#5  // put -2000 in register 3  and read data from (3 and 31) and add
Mux_Ctrl =0 ;
RR1 = 3;
$display("add");
RR2 = 31;
WR=3;
WD =-2000;
WE =1 ;
#5  //  read data from (3 and 0) and sub and write the result (-2002) in reg 5
Mux_Ctrl =1 ;
RR1 = 3;
RR2 = 0;
$display("sub");
op=4'b0001;
WR=5;
WD =-2000;
WE =1 ;
#5  //  read data from (0 and 5) and sub and make and between them
Mux_Ctrl =1 ;
RR1 = 0;
RR2 = 5;
$display("AND");
op=4'b0010;
WR=5;
WD =-2000;
WE =0 ;
#5  //  read data from (0 and 5) and sub and make or between them
Mux_Ctrl =1 ;
RR1 = 0;
RR2 = 5;
$display("OR");
op=4'b0011;
WR=5;
WD =-2000;
WE =0 ;
#5  //  read data from (0 and 31) and sub and SLL reg 0 by two
Mux_Ctrl =1 ;
RR1 = 0;
RR2 = 31;
op=4'b0100;
$display("SLL by two");
WR=5;
WD =-2000;
WE =0 ;
ShiftCount = 5'b00010;
#5  //  read data from (0 and 31) a and SLA reg 0 by two
Mux_Ctrl =1 ;
RR1 = 0;
RR2 = 31;
$display("SLA");

op=4'b0110;
WR=5;
WD =-2000;
WE =0 ;
ShiftCount = 5'b00010;
#5  //  read data from (0 and 31) and sub and make greater than
Mux_Ctrl =1 ;
RR1 = 0;
RR2 = 31;
op=4'b0111;
WR=5;
WD =-2000;
WE =0 ;
$display("greater than");

ShiftCount = 5'b00010;
end



always
begin
#2 Clk = ~Clk;
end

 OurALU z(ALUResult,overflow,Out1,Out2,op,ShiftCount);
mux a (WD,ALUResult,Mux_Ctrl,DataToWrite);
RegisterFile s(RR1,RR2,WR,DataToWrite,WE,Clk,Out1,Out2);

endmodule



module mux ( in1 , in2 , sel , out);
input [31:0] in1,in2;
input sel;
output reg [31:0] out ;

always @ (in1 or in2 or sel)
begin
if(sel ==1'b0)
 out = in1 ;
else out = in2 ;
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
 mux a ( in1 , in2 , sel , out);

endmodule

module OurALU (Result,zeroDetection,A,B,Op,ShiftCount);
output reg zeroDetection;
output reg [31:0] Result;
reg Overflow;
input signed[31:0] A;
input signed[31:0] B;
input [3:0] Op;
input [4:0] ShiftCount;
wire [31:0] B_neg;
assign B_neg = - B;
 
//Addition op 0
always @(A or B or Op)
begin
if(Op == 4'b0000)
begin

Result <= (A+B);

if(A[31]==B[31] && A[31]== ~Result[31]) Overflow <= 1;
else Overflow <=0;

end

//Subtraction op 1
if(Op == 4'b0001)
begin

Result <= (A-B);

if(A[31]==B_neg[31] && A[31]== ~Result[31]) Overflow <= 1;
else Overflow <=0;

end

//And op 2
if(Op == 4'b0010)
begin

Result <= (A&B);
Overflow <=0;

end

//Or op 3
if(Op == 4'b0011)
begin

Result <= (A|B);
Overflow <=0;

end

//Shift left logical op 4
if(Op == 4'b0100)
begin
Result <= (A<<ShiftCount);
Overflow <= 0;
end

//Shift right logical op 5
if(Op == 4'b0101)
begin
Result <= (A>>ShiftCount);
Overflow <= 0;
end

//Shift right arithmetic op 6
if(Op == 4'b0110)
begin
Result <= (A>>>ShiftCount);
if(A[31]==~Result[31])
Overflow <= 1;
else Overflow <= 0;
end

//Greater than Op 7
if(Op == 4'b0111)
  if(A>B) Result = 1; 
	else Result = 0;
//smaller than Op 8
if(Op == 4'b1000)
  if(A<B) Result = 1; 
	else Result = 0;
if(A-B == 0)
	zeroDetection <= 1;
else zeroDetection <=0;
end 
 
endmodule