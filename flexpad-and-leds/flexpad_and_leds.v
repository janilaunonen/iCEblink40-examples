// Example, how to configure pins to pull up and read flexible 3x4 number pad
// keyboard that is basically a matrix of switches. This module does not
// detect individual buttons, but only a button on certain column is pressed.
//
// Theory of operation:
// Here the rows are configured for input with pull up to logical 1 and the
// columns are connected to output pins.
// Output pins are written logical 0, so if a button is pressed in a pad, that
// 0 overrides the pulled up (weak) 1 in that row's input and thus we detect a
// 0. That means a button is pressed and light a led to indicate that row.
//
// Practical considerations: you need to have flexpad keyboard connected to
// correct pins. I use iCEblink-HX1K's 0 to 6 pins. See the corresponding
// iceblink40_vq100.pcf file and iCEblink40-HX1K Evaluation Kit
// User’s Guide. NOTE: pin numbers on board are different from device package
// pin numbers! The iceblink40_vq100.pcf tells the toolchain which package
// pins are named how. To see device package pins maps to board pins, see
// Figure 16. Location of the 3.3V Digital I/O Connections and the FPGA Pin
// Number in the above document.
module top(
	input KEYPAD_ROW_0,
	input KEYPAD_ROW_1,
	input KEYPAD_ROW_2,
	input KEYPAD_ROW_3,
	output KEYPAD_COL_0,
	output KEYPAD_COL_1,
	output KEYPAD_COL_2,
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

	// instantate a flexpad_and_leds module
	flexpad_and_leds flexpad_and_leds_inst(
		keypad_row_0_din,
		keypad_row_1_din,
		keypad_row_2_din,
		keypad_row_3_din,
		KEYPAD_COL_0,
		KEYPAD_COL_1,
		KEYPAD_COL_2,
		LED2,
		LED3,
		LED4,
		LED5);

endmodule	


module flexpad_and_leds(
	input KEYPAD_ROW_0,
	input KEYPAD_ROW_1,
	input KEYPAD_ROW_2,
	input KEYPAD_ROW_3,
	output KEYPAD_COL_0,
	output KEYPAD_COL_1,
	output KEYPAD_COL_2,
	output LED2,
	output LED3,
	output LED4,
	output LED5
);
	// make cols go low
	assign KEYPAD_COL_0 = 1'b0;
	assign KEYPAD_COL_1 = 1'b0;
	assign KEYPAD_COL_2 = 1'b0;

	// we use active low logic in keys, so we need to invert results
	assign LED2 = ~KEYPAD_ROW_0;
	assign LED3 = ~KEYPAD_ROW_1;
	assign LED4 = ~KEYPAD_ROW_2;
	assign LED5 = ~KEYPAD_ROW_3;
endmodule
