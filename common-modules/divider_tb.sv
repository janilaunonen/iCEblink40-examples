module divider_tb;
logic clk, input_clk, output_pulse0, output_pulse1, output_pulse2, output_pulse3, output_pulse4;

//divider #(.COUNT(0)) mut_zero (.clk(clk), .input_clk(clk), .output_pulse(output_pulse0));
//divider #(.COUNT(1)) mut_unity (.clk(clk), .input_clk(clk), .output_pulse(output_pulse1));
divider #(.COUNT(2)) mut_half (.clk(clk), .input_clk(clk), .output_pulse(output_pulse2));
divider #(.COUNT(3)) mut_third (.clk(clk), .input_clk(clk), .output_pulse(output_pulse3));
divider #(.COUNT(4)) mut_fourth (.clk(clk), .input_clk(clk), .output_pulse(output_pulse4));

// oscillate clock every 5 simulation units
always #5 clk <= ~clk;

// oscillate input_clk every 10 simulation units
always #10 input_clk <= ~input_clk;

initial #0 begin
	clk = 0;
	input_clk = 0;
#100     $finish;
end

initial begin
	$dumpfile("divider_tb.vcd");
	$dumpvars(0, divider_tb);
end
endmodule : divider_tb
