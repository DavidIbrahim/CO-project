module ALUControl (Op, ALUOp, funct);

output reg [3:0] Op;
input [1:0] ALUOp;
input [5:0] funct;

always@ (ALUOp or funct)
begin

if(ALUOp == 2'b00) //add
Op <= 4'b0010;

if(ALUOp == 2'b01) //sub
Op <= 4'b0110;

if(ALUOp == 2'b10) //funct
begin

if(funct == 36) Op <= 4'b0000; //and
if(funct == 37) Op <= 4'b0001; //or
if(funct == 32) Op <= 4'b0010; //add
if(funct == 34) Op <= 4'b0110; //sub
if(funct == 42) Op <= 4'b0111; //slt
if(funct == 39) Op <= 4'b1100; //nor
if(funct == 0 ) Op <= 4'b1110; //sll

end //endif
end //always


endmodule

module ALUControlTB;
reg [1:0] ALUOp;
reg [5:0] funct;
wire [3:0] Op;

initial
begin
$monitor($time ,, "ALUop: %b	funct: %d	ShiftCount: %d	Op:%b", ALUOp, funct, ShiftCount, Op);

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
