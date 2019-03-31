// Demonstrate rotating selector with slowed clock and visualized with leds.
// NOTE: this module generates 400Hz enable signal derived from the main
// clock, but selector rotator's always-block is triggered by main clock, thus
// not splitting the clock domain. That is the way you want it. The "wrong"
// way would be to use the derived 400Hz signal to trigger selector rotator's
// always-block. In this example it would have also worked just fine as the
// leds don't care about clock domains.
module led_rotator(
	input CLK_3p33MHZ,
	output LED2,
	output LED3,
	output LED4,
	output LED5);

	reg [21:0] counter = 22'd0;
	reg clk_400Hz_enable = 1'b0;
	reg [3:0] circle = 4'b0001;
	localparam DIVIDER = 22'd1000000;

	// counter goes from from 0 to DIVIDER
	// and generates one main clock pulse wide 
	// clk_400Hz_enable signal
	always @(posedge CLK_3p33MHZ)
	begin
		if (counter != DIVIDER)
		begin
			clk_400Hz_enable <= 1'b0;
			counter <= counter + 22'd1;
		end
		else
		begin
			clk_400Hz_enable <= 1'b1;
			counter <= 22'd0;
		end
	end

	// selector rotator
	always @(posedge CLK_3p33MHZ)
	begin
		if (clk_400Hz_enable)
		begin
			circle[3] <= circle[2];
			circle[2] <= circle[1];
			circle[1] <= circle[0];
			circle[0] <= circle[3];
		end
	end
	assign {LED2, LED3, LED4, LED5} = circle[3:0];
endmodule
