# A description of how you implemented the modules 

## Mux 32
I build up mux 32 by adding a new mux2 for each new bit that is added. I created a mux4 with 3 mux2. one for bit 1 and one each to handle the lower and upper posibilites of bit 0.

Two create a mux8 module, I used two mux4 modules, one for the upper and one for the lower 4 bits. I then used another mux2 to select use the output of the upper or lower mux4. 

I repeated the above pattern for mux16 and mux32

## Adder

I picked a simpler approch with this one. I developed a 1 bit full adder. I then proceded to implement a simple 32 bit ripple carry adder. 

# A description of how you tested the mux32.
I tested mux32 by turning on 1 bit out of the 32 possibilities for mux inputs and then iterating through the 32 possibilities for the enable signal and verifying that the mux only returns 1 whe the correct enable signal is given. 


# How to run your tests
The Makefile provides commands to run tests.
- To run mux32 tests: `make test_mux32`
- To run add32 tests: `make test_full_adder32`
