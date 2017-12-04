module stallingControl(ID_EX_memRead,ID_EX_rt,IF_ID_rs,IF_ID_rt,stallSignal);
	
	//input selectorOfBranchMux;
	input ID_EX_memRead;//if 1 then lw operation				
	input [4:0] ID_EX_rt,IF_ID_rs,IF_ID_rt;		
	output reg stallSignal;
	
	always@* 
		begin			//$display($time,,"ID_EX_memRead=%b ID_EX_rt=%d IF_ID_rs=%d IF_ID_rt=%d",ID_EX_memRead,ID_EX_rt,IF_ID_rs,IF_ID_rt);
			if(ID_EX_memRead)
				begin
					if( (ID_EX_rt==IF_ID_rs) || (ID_EX_rt==IF_ID_rt) )
						begin stallSignal=1;	  /*$display($time,,"stall is 1");*/	 end
					else
						begin stallSignal=0;	 /* $display($time,,"stall is 0");*/	 end
				end	
			/*else if(selectorOfBranchMux)
				stallSignal=1;*///beq
				
			else
				begin stallSignal=0;	  /*$display($time,,"stall is 0");*/	 end
				
		end
		
		
	
endmodule  
