module ForwardControl(EX_MEM_regWrite,MEM_WB_regWrite,EX_MEM_rd,MEM_WB_rd,regNoToCompareWz,forwardSignal);
	
	input EX_MEM_regWrite,MEM_WB_regWrite;
	input [3:0]	EX_MEM_rd,MEM_WB_rd,regNoToCompareWz;
	output reg[1:0]forwardSignal; 				 
	always@(EX_MEM_regWrite or MEM_WB_regWrite or EX_MEM_rd or MEM_WB_rd or regNoToCompareWz)
		begin
			if( (EX_MEM_rd==regNoToCompareWz)&& EX_MEM_regWrite	&& (EX_MEM_rd!=0) )
				begin
					forwardSignal<=01;//execute hazard
				end
						
			else if( (MEM_WB_rd==regNoToCompareWz)&& MEM_WB_regWrite && (MEM_WB_rd!=0) )		
				begin
					 forwardSignal<=10;//memory hazard	
				end			
			else
				forwardSignal<=00;//no forwarding
				
		end
	endmodule