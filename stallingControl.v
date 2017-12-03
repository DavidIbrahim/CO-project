module stallingControl(ID_EX_memRead,ID_EX_rt,IF_ID_rs,IF_ID_rt,stallSignal);
	
	
	input ID_EX_memRead;//if 1 then lw operation				
	input [4:0] ID_EX_rt,IF_ID_rs,IF_ID_rt;		
	output reg stallSignal;
	
	always@(ID_EX_memRead or ID_EX_rt or IF_ID_rs or IF_ID_rt) 
		begin			$display($time,,"ID_EX_memRead=%b ID_EX_rt=%d IF_ID_rs=%d IF_ID_rt=%d",ID_EX_memRead,ID_EX_rt,IF_ID_rs,IF_ID_rt);
			if(ID_EX_memRead)
				begin
					if( (ID_EX_rt==IF_ID_rs) || (ID_EX_rt==IF_ID_rt) )
						begin stallSignal=1;	  $display($time,,"stall is 1");	 end
					else
						begin stallSignal=0;	  $display($time,,"stall is 0");	 end
				end
			else
				begin stallSignal=0;	  $display($time,,"stall is 0");	 end
				
		end
		
		
	
endmodule  
