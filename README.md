# RISCy
A 16-bit RISC pipelined CPU with custom-built components in VHDL. 

## Project structure 

- _ALU_ : All arithmetic and logic-related components. Contains he ALU itself, its control logic, and logic gate modules used within or alongside it.

- _ControlUnit_ : Handles instruction decoding and control signal generation.

- _Pipeline_ : Everything related to pipeline stages and hazard management.

- _Registers_ : PC and register-related modules.

- _Datapath_ : General datapath modules. 

- _processor_ : The implementation of the CPU, combining all the other components. 

- _transitionFiller_ : A python script that produces the input values for the Waveforms an the correct increments.

- _WaveformsAndRTLs_ : The waveforms and RTL diagrams for all components.
