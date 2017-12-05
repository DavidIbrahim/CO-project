module ALUControl (Op, ALUOp, funct);

output reg [3:0] Op;
input [1:0] ALUOp;
input [5:0] funct;

parameter AND=4'b0000 , OR= 4'b0001 , ADD= 4'b0010,
          SUB= 4'b0110,  NOR= 4'b1100, SLL= 4'b1110 ,SRL = 4'b1101,SLT=4'b0111;


always@ (ALUOp or funct)
begin

if(ALUOp == 2'b00) //add
Op <= ADD;

else if(ALUOp == 2'b01) //sub
Op <= SUB;

else if(ALUOp == 2'b10) //funct
begin

if(funct == 36) Op <= AND;
if(funct == 37) Op <= OR;
if(funct == 32) Op <= ADD;
if(funct == 34) Op <= SUB;
if(funct == 42) Op <= SLT;
if(funct == 39) Op <= NOR;
if(funct == 0 ) Op <= SLL;
if(funct == 2) Op <= SRL;
if(funct == 42 ) Op<=SLT;
end //endif


else
Op<=4'bzzzz;

end //always


endmodule

module ALUControlTB;
reg [1:0] ALUOp;
reg [5:0] funct;
wire [3:0] Op;

initial
begin
$monitor($time ,, "ALUop: %b	funct: %d	Op:%b", ALUOp, funct, Op);

$display("lw-->add");
ALUOp= 2'b00;

#5
$display("beq-->sub");
ALUOp= 2'b01;

#5
$display("funct--add");
ALUOp= 2'b10;
funct= 32;

#5
$display("funct--sub");
ALUOp= 2'b10;
funct= 34;

#5
$display("funct--and");
ALUOp= 2'b10;
funct= 36;

#5
$display("funct--or");
ALUOp= 2'b10;
funct= 37;

#5
$display("funct--nor");
ALUOp= 2'b10;
funct= 39;

#5
$display("funct--slt");
ALUOp= 2'b10;
funct= 42;

#5
$display("funct--sll");
ALUOp= 2'b10;
funct= 0;

end// end initial

ALUControl F(Op, ALUOp, funct);

endmodule
