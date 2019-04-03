# iCEblink40-examples
Simple example programs for the Lattice iCEblink40-HX1K Evaluation Kit in Verilog for fun and learning using open source toolchain. The examples might work easily with Lattice ICECube2 ( http://www.latticesemi.com/Products/DesignSoftwareAndIP/FPGAandLDS/iCEcube2 ), however I had problems setting up the ICECube2 on my Linux so I opted to use open source toolchain, namely yosys, arachne-pnr, icestorm, iceburn.

Examples are simple and probably fits any FPGA.

## Tools:
* iCEblink40-HX1K: http://www.latticesemi.com/iCEblink40-HX1K
* Yosys: http://www.clifford.at/yosys/
* Arachne-pnr https://github.com/YosysHQ/arachne-pnr
* Icestorm: http://www.clifford.at/icestorm/

## Documentation:
* https://www.latticesemi.com/~/media/LatticeSemi/Documents/DataSheets/iCE/iCE40LPHXFamilyDataSheet.pdf
* https://www.latticesemi.com/~/media/LatticeSemi/Documents/UserManuals/EI/iCEblink40HX1KEvaluationKitUsersGuide.PDF

## Examples:
1 led-conter: simple clock divider with highest bits output to onboard leds. Basic example for pin assignment.

2 led-rotator: rotating led driven by slowed enable signal derived from main clock.

3 flexpad-and-leds: detects buttons pressed on a flexible keypad and lights up leds according to the button's row. The used keyboard is like this: https://media.digikey.com/pdf/Data%20Sheets/Adafruit%20PDFs/419_Web.pdf

4 flexpad-encoded-leds: detects individual buttons pressed on flexible keypad and encodes the button pressed (wrongly currently) and shows the result with leds. Uses techniques from examples 2 and 3; rotating selector selects the column to be read and the I/Os are setup like in flexpax-and-leds.
