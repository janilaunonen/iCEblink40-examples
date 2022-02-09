module divider
#(parameter COUNT = 3300000)
 (input logic clk, input_clk, output logic output_pulse);

// check that the parameter is sensible i.e. > 1
initial if (COUNT < 2)
	$fatal(1, "Divider given nonsensical parameter value (<2)");

logic [$clog2(COUNT - 1):0] counter = 0;
logic output_clk = 0;

always_ff @(posedge clk) begin
	if (input_clk == 1'b1) begin
		if (counter != (COUNT - 1)) begin
			counter++;
			output_clk <= 1'b0;
		end
		else begin
			counter <= 0;
			output_clk <= 1'b1;
		end
	end
	else
		output_clk <= output_clk;
end
assign output_pulse = output_clk & clk;
endmodule : divider
