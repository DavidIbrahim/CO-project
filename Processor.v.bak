module CPU (clk,instruction) ;
input signed[31:0] instruction;
input clk;
parameter LW = 6'b100011, SW = 6'b101011, BEQ = 6'b000100, ALUop = 6'b000000; //for checking op code
wire [31:0] Ain, Bin; //Input to the main ALU 
reg[31:0] PC, DMemory[0:1023]; //Memory
wire [31:0] proceedingPC ; //  =pc+4
wire[31:0] nextPC ; // output of third mux chooses between proceedingPC(PC+4) and branch address

wire[31:0] nextPC_branch; // this is is the new address of pc if the instruction is beq 
wire signed [31:0] ALUResult;
wire signed [31:0]writeData;
wire [4:0] writeRegister; // the address of the registers to write output of the mux


wire regWrite,regDst,aluSrc,memWrite,memToReg,memRead,branch,zeroDetection,selectorOfBranchMux;  

wire [3:0]operation;//input to mainAlu and output from Alucontrol

wire [4:0] rs, rt,rd,shamt ; // Access Instruction fields fields 
wire [5:0]funct,opCode;	     // Access Instruction fields fields 
wire [15:0]immediate_address;// Access Instruction fields fields 
wire [31:0]readData2;     // output of fileregister and input to the second mux
wire[31:0] instruction2; // output of Instrection memory
wire[31:0]extended_immediate; // output of signExtension 
wire[31:0]extended_shiftedBy2; // output of signExtender after being shifted by 2 , used in beq
InstMem  IMemory(PC,clk,instruction2);

Mux_5bits firstMux( rt , rd , regDst , writeRegister);  // mux before registerFile
	
RegisterFile registerFile(rs,rt,writeRegister,writeData,regWrite,Clk,Ain,readData2);

SignExtender signExtend(immediate_address ,extended_immediate);

controlUnit mainControlUnit(opCode,regDst,branch,memRead,memToReg,aluOp,memWrite,aluSrc,regWrite);//control unit

Mux_32bits secondMux(readData2,extended_immediate,aluSrc,Bin);	 // mux before ALU

ALUControl aluControlUnit(operation, aluOp, funct);// alu control unit

OurALU mainAlu(ALUResult,zeroDetection,Ain,Bin,operation,shamt); // main alu

AndGate_1bit branchAnd( selectorOfBranchMux , branch , zeroDetection);

Mux_32bits thirdMux(proceedingPC,nextPC_branch,selectorOfBranchMux,nextPc);	 // mux before ALU

// These assignments defines fields from the instruction
assign op = instruction [31:26];
assign rs = instruction[25:21];
assign rt = instruction [20:16];
assign rd = instruction [15:11];
assign shamt = instruction[10:6];	
assign funct = instruction[5:0];
assign immediate_address = instruction[15:0];	
assign extended_shiftedBy2 = (extended_immediate<<2);
assign proceedingPC = PC+4 ;
assign nextPC_branch = nextPC + extended_shiftedBy2;
initial
begin
PC = 0;

end

endmodule
