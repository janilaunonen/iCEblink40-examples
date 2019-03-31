module led_counter(
	input CLK_3p33MHZ,
	output LED2,
	output LED3,
	output LED4,
	output LED5
);
	reg [21:0] counter;

	always @ (posedge CLK_3p33MHZ)
		begin
			counter = counter + 22'd1;
		end

	assign {LED2, LED3, LED4, LED5} = counter[21:18];
endmodule
