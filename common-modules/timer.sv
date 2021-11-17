// Theory of operation:
// The timer starts from 0 and counts clk1kHz ticks (if enable == 1) until
// delayInMs ticks have been counted and sets the timeout signal high for 1
// clk cycle.
//
// To disable the counter, set enable = 0. When the enable signal is set to 1,
// the delayInMs is loaded from bus on clk's rising edge and the counting is
// started from 0.
module timer(input logic clk, clk1kHz, enable, input logic [9:0] delayInMs, output logic timeout);
initial timeout = 0;
logic [9:0] counter = 0;
logic loaded = 0;

always_ff @(posedge clk)
	// normal operation
	if (enable && loaded) begin
		if (counter == 0 && timeout == 1'b0)
			timeout <= 1'b1;	// raise timout for one clk
		else if (counter == 0 && timeout == 1'b0)
			timeout <= 1'b0;	// lower timeout
		else
			counter--;
	end
	// load counter when enable rises
	else if (enable && ~loaded) begin
		counter <= delayInMs;
		loaded <= 1'b1;
	end
endmodule : timer
