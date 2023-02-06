module clock_buffer_tb();

reg mclk;
wire bclk;

//realtime is of type real used for storing time as a floating point value.
realtime t1,t2,t3,t4,t5,t6; 

parameter CYCLE = 10;

//module instantiation
clock_buffer DUT(mclk,bclk);

//clock generation
initial begin
	mclk = 1'b0;
	forever #(CYCLE/2) mclk = ~mclk;
end

//task for master clock
task master;
	begin
		@(posedge mclk); t1 = $realtime;
		@(posedge mclk); t2 = $realtime;
		t3 = t2 - t1;
	end
endtask

//task for buffer clcok
task bufout;
	begin
		@(posedge bclk); t4 = $realtime;
		@(posedge bclk); t5 = $realtime;	
		t6 = t5 - t4;
	end
endtask

//task for checking frequency and phase
task freq_phase;
realtime phase_diff,freq_diff;
	begin
		freq_diff = t6 - t3;
		phase_diff = t4 - t1;
		$display("freq_diff=%0t,phase_diff=%0t",freq_diff,phase_diff);
	end
endtask

initial 
	begin
		fork
		master;
		bufout;
		join
		freq_phase;
	end

endmodule