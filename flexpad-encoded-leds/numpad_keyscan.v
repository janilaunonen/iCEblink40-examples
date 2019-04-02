module numpad_keyscan(
	input clk_3p33MHz,
	input [3:0] keypad_row,
	output [2:0] keypad_col,
	output reg [11:0] keypad_button);

reg [3:0] buttons[2:0];
reg [3:0] selector = 4'b0001;
reg enable_400Hz = 1'b0;
parameter DIVIDER = 8192;
parameter COUNTER_BITS = 13;
reg [COUNTER_BITS - 1:0] counter = 0;

// counter increments at clk_3p33MHz until DIVIDER and
// raises enable_400Hz for 1 clock cycle and starts over
// counting from 0.
always @(posedge clk_3p33MHz)
begin
	if (counter != DIVIDER-1)
	begin
		counter <= counter + 1;
		enable_400Hz <= 0;
	end else begin
		counter <= 0;
		enable_400Hz <= 1;
	end
end

// rotating selector signal at 400Hz
always @(posedge clk_3p33MHz)
begin
	if (enable_400Hz)
	begin
		selector[3] <= selector[2];
		selector[2] <= selector[1];
		selector[1] <= selector[0];
		selector[0] <= selector[3];
	end
end

// selection signal is positive (1).
assign keypad_col[2:0] = selector[2:0];

// use selector to enable a column in a keypad to read
// a row of inputs to corresponding button registers
always @(posedge clk_3p33MHz)
begin
	case (selector)
		4'b0001 : keypad_button[11:8] <= keypad_row; //buttons[0] <= keypad_row;
		4'b0010 : keypad_button[7:4]  <= keypad_row; //buttons[1] <= keypad_row;
		4'b0100 : keypad_button[3:0]  <= keypad_row; //buttons[2] <= keypad_row;
//		4'b1000 : 
//		begin
//			keypad_button[11:8] <= buttons[0][3:0];
//			keypad_button[7:4]  <= buttons[1][3:0];
//			keypad_button[3:0]  <= buttons[2][3:0];
//		end
	endcase
end
endmodule
