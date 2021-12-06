PROJ = common-modules
PIN_DEF =  iceblink40_vq100.pcf
DEVICE = hx1k
PACKAGE = vq100
ICEBURNPY = python3
ICEBURNPATH = /home/jabba/Programming/iceBurn

%_tb: %.sv %_tb.sv
	iverilog -g2005-sv -o $@ $^

%_tb.vcd: %_tb
	./$<

visualize: %_tb.vcd
	gtkwave -f $^

all: $(PROJ).rpt $(PROJ).bin

clean:
	rm *.vcd *_tb

.PHONY: all clean
