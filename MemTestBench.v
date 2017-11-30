module InstMemTestBench;
	
	//integer file;  
	
	reg [31:0]Pc=0;
	reg Clk=1; 
	wire [31:0]InstReg;			 
	
		
	InstMem IM1(Pc,Clk,InstReg);	
	  /*
	always
				begin 
					#5
					Clk=~Clk;
				end		 		 */
	integer i;
	initial
		begin	
			
					
			$monitor($time,,,"instruction is %b",InstReg);	
			//$display("%b",IMemory[5]);	 
			//$readmemb("instructionMemory.txt",IMemory);
			//$display("instruction is %b",InstMem[0]);		 
			//$display("instruction is %b",InstReg);
			//#10
			//$display("instruction is %b",InstReg);	 
			#10
			Clk<=0;
			#10		
			Clk<=1;
			Pc<=4;
			//$display("instruction is %b",InstReg);
			//$display("instruction is %b",IMemory[0]);
		end
		
	endmodule

module DataMemTestBench;
	
	reg[31:0] Address=8   ; // the address to read or write  in . 
reg [31:0] writeData=0 ; // the data to be writen in that address . 
reg  MemWrite=1; // write enable . 
reg  MemRead=0  ; // read  enable .
reg Clk=0; 	  // all compennts must have same clk 	.

wire[31:0] ReadData ; // data to be read from memory.
DataMem DM1( Address , writeData , MemRead , MemWrite  , Clk , ReadData );

always
				begin 
					#5
					Clk=~Clk;
					end
	/*
	integer file;
	integer i=0;   */
	initial
		begin		
			/*
			file=$fopen("DataMemory.txt");	  
			
			$fmonitor(file,"%b //%d\n",i,i);
			for(i=0;i<1023;i=i+1)
				begin 
					#1
					//$display("K");	 
					
				end		  
				
				#100
			$fclose(file);	 
			*/		 
			#15	 
			MemWrite=0;
			MemRead=1;
			$display("the read data=%b",ReadData);	
			
		end
		
endmodule
