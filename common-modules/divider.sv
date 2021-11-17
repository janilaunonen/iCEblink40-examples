

module divider #(parameter COUNT = 3300000)
(input logic clk, input logic input_clk, output logic output_clk);
logic [$clog2(COUNT):0] counter = 0;
initial output_clk = 0;

always_ff @(posedge clk)
begin
	if (input_clk == 1'b1)
	begin
		if (counter != COUNT)
		begin
			counter++;
			output_clk <= 1'b0;
		end
		else
		begin
			counter <= 0;
			output_clk <= 1'b1;
		end
	end
	else
		output_clk <= output_clk;
end
endmodule : divider
