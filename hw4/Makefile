# -Wall turns on all warnings
# -g2012 selects the 2012 version of iVerilog
IVERILOG=iverilog -Wall -g2012 -y ./ -I ./
VVP=vvp
VIVADO=vivado -mode batch -source

# Look up .PHONY rules for Makefiles
.PHONY: clean submission remove_solutions

MUXES=mux4.sv mux8.sv mux16.sv mux32.sv 

test_4a: test_4a.sv 4a.sv $(MUXES)
	${IVERILOG} $^ -o test_4a.bin && ${VVP} test_4a.bin

test_mux4: test_mux4.sv mux4.sv $(MUXES)
	${IVERILOG} $^ -o test_mux4.bin && ${VVP} test_mux4.bin

test_mux4: test_mux4.sv mux4.sv $(MUXES)
	${IVERILOG} $^ -o test_mux4.bin && ${VVP} test_mux4.bin

test_mux32: test_mux32.sv mux32.sv $(MUXES)
	${IVERILOG} $^ -o test_mux32.bin && ${VVP} test_mux32.bin

test_full_adder: test_full_adder.sv full_adder.sv
	${IVERILOG} $^ -o test_full_adder.bin && ${VVP} test_full_adder.bin

test_full_adder32: test_full_adder32.sv full_adder.sv full_adder32.sv
	${IVERILOG} $^ -o test_full_adder32.bin && ${VVP} test_full_adder32.bin


# Call this to clean up all your generated files
clean:
	rm -f *.bin *.vcd vivado*.log vivado*.jou vivado*.str

# Call this to generate your submission zip file.
submission:
	zip submission.zip Makefile *.sv README.md docs/* xilinx/*.xpr *.xdc
