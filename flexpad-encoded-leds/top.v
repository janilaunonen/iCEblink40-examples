`include "numpad_keyscan.v"

module top(
	input CLK_3P33MHZ, // KEYPAD_CLK,
	input KEYPAD_ROW_0,
	input KEYPAD_ROW_1,
	input KEYPAD_ROW_2,
	input KEYPAD_ROW_3,
	output KEYPAD_COL_0,
	output KEYPAD_COL_1,
	output KEYPAD_COL_2, //	output [11:0] keypad_button,
	output LED2,
	output LED3,
	output LED4,
	output LED5
);
	// create io-block instance connected to pin KEYPAD_ROW_0 and initialise
	// it for input and enable pull-up.
	wire keypad_row_0_din;
	SB_IO #(
		.PIN_TYPE(6'b000001),
		.PULLUP(1'b1)
	) keypad_row_0_config (
		.PACKAGE_PIN(KEYPAD_ROW_0),
		.D_IN_0(keypad_row_0_din)
	);

	wire keypad_row_1_din;
	SB_IO #(
		.PIN_TYPE(6'b000001),
		.PULLUP(1'b1)
	) keypad_row_1_config (
		.PACKAGE_PIN(KEYPAD_ROW_1),
		.D_IN_0(keypad_row_1_din)
	);

	wire keypad_row_2_din;
	SB_IO #(
		.PIN_TYPE(6'b000001),
		.PULLUP(1'b1)
	) keypad_row_2_config (
		.PACKAGE_PIN(KEYPAD_ROW_2),
		.D_IN_0(keypad_row_2_din)
	);

	wire keypad_row_3_din;
	SB_IO #(
		.PIN_TYPE(6'b000001),
		.PULLUP(1'b1)
	) keypad_row_3_config (
		.PACKAGE_PIN(KEYPAD_ROW_3),
		.D_IN_0(keypad_row_3_din)
	);

	wire [11:0] keypad_button;

	wire [2:0] dummy;

	numpad_keyscan numpad_keyscan_inst(
		.clk_3p33MHz(CLK_3P33MHZ),
		.keypad_row({keypad_row_0_din, keypad_row_1_din, keypad_row_2_din, keypad_row_3_din}),
		.keypad_col(dummy),      //{KEYPAD_COL_0, KEYPAD_COL_1, KEYPAD_COL_2}),
		.keypad_button(keypad_button[11:0]));

	// The column selection is negative active (as the rows are pulled
	// up). However, numpad_keyscan module gives selected row positive.
	assign {KEYPAD_COL_0, KEYPAD_COL_1, KEYPAD_COL_2} = ~dummy[2:0];

	// encode the pressed key as a 4-bit binary word with leds.
	always @(posedge CLK_3P33MHZ)
	begin
		case (~keypad_button)
			12'b100000000000 : {LED2, LED3, LED4, LED5} = 4'd12;
			12'b010000000000 : {LED2, LED3, LED4, LED5} = 4'd11;
			12'b001000000000 : {LED2, LED3, LED4, LED5} = 4'd10;
			12'b000100000000 : {LED2, LED3, LED4, LED5} = 4'd9;
			12'b000010000000 : {LED2, LED3, LED4, LED5} = 4'd8;
			12'b000001000000 : {LED2, LED3, LED4, LED5} = 4'd7;
			12'b000000100000 : {LED2, LED3, LED4, LED5} = 4'd6;
			12'b000000010000 : {LED2, LED3, LED4, LED5} = 4'd5;
			12'b000000001000 : {LED2, LED3, LED4, LED5} = 4'd4;
			12'b000000000100 : {LED2, LED3, LED4, LED5} = 4'd3;
			12'b000000000010 : {LED2, LED3, LED4, LED5} = 4'd2;
			12'b000000000001 : {LED2, LED3, LED4, LED5} = 4'd1;
			default : {LED2, LED3, LED4, LED5} = 4'd0;
		endcase
	end
endmodule
