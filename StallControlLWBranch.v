module StallControlBranch(EX_MEM_memRead,opCode,EX_MEM_Opcode,ID_EX_Opcode,EX_MEM_rt,IF_ID_rs,IF_ID_rt,EX_MEM_rd,ID_EX_rd,stallSignal);
	
	input EX_MEM_memRead;//if 1 then lw instruction is the one above the above instruction 			
	input [5:0]opCode,EX_MEM_Opcode,ID_EX_Opcode; //to check that the current instruction is beq,the prev. is R-type, before the prev is R-type
	input [4:0] EX_MEM_rt,IF_ID_rs,IF_ID_rt,EX_MEM_rd,ID_EX_rd;		
	output reg stallSignal;											 
	
	always@( EX_MEM_memRead or opCode or EX_MEM_rt or IF_ID_rs or IF_ID_rt or EX_MEM_Opcode or ID_EX_Opcode or EX_MEM_rd or ID_EX_rd)	
		begin 
			//$strobe($time,,"EX_MEM_memRead=%d,opCode=%d,EX_MEM_Opcode=%d,ID_EX_Opcode=%d,EX_MEM_rt=%d,IF_ID_rs=%d,IF_ID_rt=%d,EX_MEM_rd=%d,ID_EX_rd=%d,stallSignal=%d",EX_MEM_memRead,opCode,EX_MEM_Opcode,ID_EX_Opcode,EX_MEM_rt,IF_ID_rs,IF_ID_rt,EX_MEM_rd,ID_EX_rd,stallSignal);
			//in case of lw before beq but we considered there is nop after lw
			if(	EX_MEM_memRead && (opCode==4) && ( (EX_MEM_rt==IF_ID_rs) || (EX_MEM_rt==IF_ID_rt) )  )
				begin
					stallSignal=1;
					$strobe($time,,"stallSignal=%d",stallSignal);
					$display($time,,"case of lw before beq");
				end
			//in case of R-type before beq by one
			else if( (EX_MEM_Opcode==0)&& (opCode==4)&&( (EX_MEM_rd==IF_ID_rs) || (EX_MEM_rd==IF_ID_rt) ) ) 
				begin
					stallSignal=1; 
					$display($time,,"R-type before beq by one");
				end			 
				//in case of R-type before beq by two
			/*else if(	(ID_EX_Opcode==0)&&(opCode==4) && ( (ID_EX_rd==IF_ID_rs) || (ID_EX_rd==IF_ID_rt) ) )
				begin
					stallSignal=1;
					$strobe($time,,"R-type before beq by two");
				end	*/
				
			else
				begin
					stallSignal=0;
				end
				
		end
			
endmodule
