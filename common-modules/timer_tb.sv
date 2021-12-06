module timer_tb();
logic clk = 0;
logic clk1kHz = 0;
logic en = 0;
logic [9:0] delayInMs = 10;
logic to;

//divider #(.COUNT(2)) mut (.clk(clk), .input_clk(clk), .output_clk(output_clk));
timer mut(.clk(clk), .clk1kHz(clk1kHz), .enable(en), .delayInMs(delayInMs), .timeout(to));

// oscillate clock every 5 simulation units
always #5 clk = ~clk;

// oscillate 1kHz clock every 10 simulation units
always @(posedge clk)
	clk1kHz <= ~clk1kHz;

initial #0 begin
	clk = 0;
	clk1kHz = 0;
	#10 en = 1;
	#70 delayInMs = 0;
	#130 $finish;
end

initial begin
	$dumpfile("timer_tb.vcd");
	$dumpvars(0, timer_tb);
end
endmodule : timer_tb
