The Pattern Processor (PAT). 8-bit implementation.
===================================================

This repository contains the implementation of the 8-bit version of the PAT processor.
This processor has been taped out on an AMS 0.18um High Voltage process and targets **1GHz operation**.

Documentation for the PAT processor can be found in the docs directory at github.com/pat-processor/docs/


Repository Overview
-------------------

The repository contains verilog design files and a Cadence verilog-to-OA or verilog-to-DEF flow, mixed with Synopsys optimisation.
The end product is suitable for either immediate tape-out or import into Virtuoso for further processing.

The following directories exist, and have the following use:


pat/ directory
--------------

This directory contains the main PAT design files:

Subdirectories:
* def - DEF layout files
* design_compiler - files for use when optimising the datapath using Synopsys Design Compiler.
* encounter - files for Cadence Encounter place and route.
* hdl - verilog design files for the processor and support circuitry
* oa - Cadence OpenAccess layout
* rc-compiler - scripts for and output from Cadence RTL Compiler, for synthesis of verilog to technology mapped verilog
* reports - implementation reports e.g. area reports from the synthesis tools
* schematics - schematics of critical path sub-circuits
* testbenches - RTL testbenches and Modelsim test scripts



patasm/ directory
--------------------

This directory contains a Python-based assembler for the PAT processor. Version 2 is applicable for both PAT 8-bit and PAT 32-bit designs.



pattern-buffer/ directory
------------------------

This directory contains design files for the associated Pattern Buffer implementation. The Pattern Buffer can be filled at 8Gbit/s from the PAT processor.

Subdirectories:
* encounter - files for Cadence Encounter place and route.
* hdl - verilog design files for the processor and support circuitry
* oa - Cadence OpenAccess layout
* rc-compiler - scripts for and output from Cadence RTL Compiler, for synthesis of verilog to technology mapped verilog
* testbenches - RTL testbenches and Modelsim test scripts



priority-encoder/ directory
---------------------------

This directory contains a process test circuit of a simple 4-imput priority encoder.

Subdirectories:
* encounter - files for Cadence Encounter place and route.
* hdl - verilog design files for the processor and support circuitry
* oa - Cadence OpenAccess layout
* rc-compiler - scripts for and output from Cadence RTL Compiler, for synthesis of verilog to technology mapped verilog



Contact
-------

The maintainer of this repository is Simon Hollis (simon A  T  cs.bris.ac.uk)