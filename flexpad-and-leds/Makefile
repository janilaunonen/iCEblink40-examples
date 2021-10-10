PROJ = flexpad_and_leds
PIN_DEF =  iceblink40_vq100.pcf
DEVICE = hx1k
PACKAGE = vq100
ICEBURNPY = python3
ICEBURNPATH = /home/jabba/Programming/iceBurn

all: $(PROJ).rpt $(PROJ).bin

%.json: %.v
	yosys -p 'synth_ice40 -top top -json $@' $<

%.asc: $(PIN_DEF) %.json
	nextpnr-ice40 --$(DEVICE) --package $(PACKAGE) --json $(word 2,$^) --pcf $(PIN_DEF) --asc $@

%.bin: %.asc
	icepack $< $@

%.rpt: %.asc
	icetime -d $(DEVICE) -mtr $@ $<

prog: $(PROJ).bin
	$(ICEBURNPY) $(ICEBURNPATH)/iCEburn.py  -e -v -w  $<

sudo-prog: $(PROJ).bin
	@echo 'Executing prog as root!!!'
	$(ICEBURNPY) $(ICEBURNPATH)/iCEburn.py  -e -v -w  $<

clean:
	rm -f $(PROJ).json $(PROJ).asc $(PROJ).bin $(PROJ).rpt

.PHONY: all prog clean
