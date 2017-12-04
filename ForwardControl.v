module ForwardControl(EX_MEM_regWrite,MEM_WB_regWrite,EX_MEM_rd,MEM_WB_rd,MEM_WB_rt,regNoToCompareWz,forwardSignal);
	
	input EX_MEM_regWrite,MEM_WB_regWrite;
	input [4:0]	EX_MEM_rd,MEM_WB_rd,MEM_WB_rt,regNoToCompareWz;
	output reg[1:0]forwardSignal; 				 
	always@(EX_MEM_regWrite or MEM_WB_regWrite or EX_MEM_rd or MEM_WB_rd or regNoToCompareWz or MEM_WB_rt)
		begin  
			//$strobe($time,,"EX_MEM_regWrite=%d MEM_WB_regWrite=%d EX_MEM_rd=%d MEM_WB_rd=%d regNoToCompareWz=%d",EX_MEM_regWrite,MEM_WB_regWrite,EX_MEM_rd,MEM_WB_rd,regNoToCompareWz); 
			if( (EX_MEM_rd==regNoToCompareWz)&& EX_MEM_regWrite	&& (EX_MEM_rd!=0) )
				begin
					forwardSignal<=01;//execute hazard	
					$display($time,,"execute hazard");
				end
						
			else if( (MEM_WB_rd==regNoToCompareWz)&& MEM_WB_regWrite && (MEM_WB_rd!=0) )		
				begin
					forwardSignal<=10;//memory hazard
					$display($time,,"memory hazard");
				end
			else if( (MEM_WB_rt==regNoToCompareWz)&& MEM_WB_regWrite && (MEM_WB_rt!=0) )		   
				begin
					forwardSignal<=11;//lw hazard
					$display($time,,"load hazard");
				end
				
			else
				forwardSignal<=00;//no forwarding
				
		end
	endmodule