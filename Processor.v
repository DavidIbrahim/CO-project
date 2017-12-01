module CPU (clk) ;

input clk;

reg[31:0] PC; //Memory


wire [31:0] Ain, Bin; //Input to the main ALU 
wire[31:0] readDataMemory ; // output of dataMemory
wire [31:0] proceedingPC ; //  =pc+4
wire[31:0] nextPC ; // output of third mux chooses between proceedingPC(PC+4) and branch address
//reg[31:0] nextPCReg;
wire[31:0] nextPC_branch; // this  is the new address of pc if the instruction is beq
wire signed [31:0] ALUResult;
wire signed [31:0]writeData;
wire [4:0] writeRegister; // the address of the registers to write output of the mux
wire [1:0] aluOP;
wire regWrite,regDst,aluSrc,memWrite,memToReg,memRead,branch,zeroDetection,selectorOfBranchMux;  
wire [3:0]operation;//input to mainAlu and output from Alucontrol
wire [4:0] rs, rt,rd,shamt ; // Access Instruction fields fields 
wire [5:0]funct,opCode;	     // Access Instruction fields fields 
wire [15:0]immediate_address;// Access Instruction fields fields 
wire [31:0]readData2;     // output of fileregister and input to the second mux
wire[31:0] instruction; // output of Instrection memory
wire[31:0]extended_immediate; // output of signExtension 
wire[31:0]extended_shiftedBy2; // output of signExtender after being shifted by 2 , used in beq


Mux_32bits thirdMux(proceedingPC,nextPC_branch,selectorOfBranchMux,nextPC);	 // mux before pc//fetch stage
InstMem  IMemory(PC,clk,instruction);//in the fetch stage
Mux_5bits firstMux( rt , rd , regDst , writeRegister);  // mux before registerFile // fetch stage
RegisterFile registerFile(rs,rt,writeRegister,writeData,regWrite,clk,Ain,readData2);// id stage
SignExtender signExtend(immediate_address ,extended_immediate);// before alu under the register file done //in the id stage
controlUnit mainControlUnit(opCode,regDst,branch,memRead,memToReg,aluOP,memWrite,aluSrc,regWrite);//control unit//id stage and have effects in other stages
Mux_32bits secondMux(readData2,extended_immediate,aluSrc,Bin);	 // mux before ALU//id stage
ALUControl aluControlUnit(operation, aluOP, funct);// alu control unit// exe stage
OurALU mainAlu(ALUResult,xxxxx,Ain,Bin,operation,shamt); // main alu// exe stage
DataMem DMemory( ALUResult ,readData2 ,memRead , memWrite  ,clk , readDataMemory ); //Data Memory//mem
Mux_32bits fourthMux(ALUResult,readDataMemory , memToReg, writeData);// mux before WriteData in reg//wb






// These assignments defines fields from the instruction

//before fetch to determine next pc
assign selectorOfBranchMux = branch & zeroDetection;
// r format assign
assign opCode = instruction [31:26];
assign rs = instruction[25:21];
assign rt = instruction [20:16];
assign rd = instruction [15:11];
assign shamt = instruction[10:6];	
assign funct = instruction[5:0];
// i format assign
assign immediate_address = instruction[15:0];	
// another shift left up the alu 
assign extended_shiftedBy2 = (extended_immediate<<2);
//adder for pc instead of a module
assign proceedingPC = PC+4 ;
//for branch 
assign nextPC_branch = proceedingPC + extended_shiftedBy2;
// zero detection instead of using the one in the alu 
assign zeroDetection = ((Ain-Bin)==0)?1:0;

 




initial
begin
// for first inst only
PC = 0;
//nextPCReg=0;

$monitor($time,,"PC = %d , instruction=%h, ,rs=%d,rt=%d,Bin = %d Ain = %d,AluResult = %d ",
PC,instruction,rs,rt,Bin,Ain,ALUResult);

end







always @(posedge clk)
begin
// for new inst
PC <=nextPC;



end











endmodule

module cpuTestBench();

wire clk ;
 ClkGen c(clk);
 CPU a(clk) ;

endmodule