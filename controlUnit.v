module controlUnit(opCode,stallSignal,regDst,branch,memRead,memToReg,aluOp,memWrite,aluSrc,regWrite);	  
	
	input stallSignal;
	input [5:0]opCode;
	output reg regDst,branch,memRead,memToReg,memWrite,aluSrc,regWrite;	   
	output reg [1:0]aluOp;	
	
	always@(opCode)
		begin	  /*
			if(stallSignal)
				begin			$display($time,"nop");
					regDst <=0;
					aluSrc <=0;
					memToReg <=0;
					regWrite <=0;
					memRead <=0;
					memWrite <=0;
					branch<=0;
					aluOp<=00; 
				end	  
				
			else */if(opCode==0)//R-instruction
				begin
					regDst <=1;
					aluSrc <=0;
					memToReg <=0;
					regWrite <=1;
					memRead <=0;
					memWrite <=0;
					branch<=0;
					aluOp<=10; 
					//$display("The instruction is R-instruction");
				end	
			else if(opCode==35)//lw
				begin 
					regDst <=0;
					aluSrc <=1;
					memToReg <=1;
					regWrite <=1;
					memRead =1;
					memWrite <=0;
					branch<=0;
					aluOp<=00;
					//$display("The instruction is load word memRead=%d",memRead);
				end	
			else if(opCode==43)//sw
				begin
					regDst <=0;//don't care
					aluSrc <=1;
					memToReg <=1;//don't care
					regWrite <=0;
					memRead <=0;
					memWrite <=1;
					branch<=0;
					aluOp<=00;							  
					//$display("The instruction is store word");
				end	
			else if(opCode==4)//beq
				begin
					regDst <=0;//don't care
					aluSrc <=0;
					memToReg <=1;//don't care
					regWrite <=0;
					memRead <=0;
					memWrite <=0;
					branch<=1;
					aluOp<=01;		   
					//$display("The instruction is beq");
				end		
			else//not supported operation
				begin
					regDst <=0;
					aluSrc <=1;
					memToReg <=1;
					regWrite <=1;
					memRead <=1;
					memWrite <=0;
					branch<=0;
					aluOp<=00;						   
					//$display("The instruction is not supported ,opCode : %d",opCode);
				end		
				
		end
		
	
endmodule		  

module controlUnitTestBench;
	
	reg [5:0]opCode=1;
	wire regDst,branch,memRead,memToReg,memWrite,aluSrc,regWrite;
	wire [1:0]aluOp;
	/*
	reg clk=0;
	always
		begin
			#10
			clk=~clk;
		end	 	
		*/
	controlUnit c1(opCode,stallSignal,regDst,branch,memRead,memToReg,aluOp,memWrite,aluSrc,regWrite);
	initial
		begin 
			$monitor($time ,,"opCode=%d regDst=%d branch=%d,memRead=%d,memToReg=%d,aluOp=%b,memWrite=%d,aluSrc=%d,regWrite=%d",opCode,regDst,branch,memRead,memToReg,aluOp,memWrite,aluSrc,regWrite);  
			
			opCode=0; //R 		
			#30
			opCode=35;//lw
			#20
			opCode=43;//sw
			#20
			opCode=4; //beq
		end
		
			
endmodule


module control_sw  (   EX_MEM_memWrite        , MEM_WB_regWrite     ,  
 EX_MEM_IR_rt   , writeRegister   , 
 Lw_add_SW_hazzard_control_line_mux  );   


input wire EX_MEM_memWrite ;// if i am equal 1 then i am sw
input wire MEM_WB_regWrite ;// if i am equal 1 then i am lw or add
input wire [4:0]   EX_MEM_IR_rt  , writeRegister  ; // if we are equal then i want to write on a register on inst 1 which i also want to store the data that is stored in on inst 2 
//so this will create an hazzard as i didn't write on this address the data that i just added or loaded from the memory 
//so we make forwarding from the memout to the memin (put the value of mux equal 1 ) 
output reg Lw_add_SW_hazzard_control_line_mux ;

always@(  EX_MEM_memWrite or MEM_WB_regWrite or EX_MEM_IR_rt or    writeRegister    )
begin 

if(              (  EX_MEM_IR_rt ==  writeRegister) &&  (MEM_WB_regWrite==1)   && ( EX_MEM_memWrite == 1)  && (writeRegister!=0)       )
Lw_add_SW_hazzard_control_line_mux = 1 ;
else
Lw_add_SW_hazzard_control_line_mux=0 ;

end	
endmodule
	

