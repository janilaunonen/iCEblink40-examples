module divider_tb();
logic clk, output_pulse;

divider #(.COUNT(2)) mut (.clk(clk), .input_clk(clk), .output_pulse(output_pulse));

// oscillate clock every 5 simulation units
always #5 clk <= !clk;

initial #0 begin
	clk = 0;
#60     $finish;
end

initial begin
	$dumpfile("divider_tb.vcd");
	$dumpvars(0, divider_tb);
end
endmodule : divider_tb
