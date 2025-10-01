# RISCy
A 16-bit RISC pipelined CPU with custom-built components in VHDL

Repo organization 
🔹 ALU
All arithmetic and logic-related components: the ALU itself, its control logic, and logic gate modules used within or alongside it.

🔹 ControlUnit
Handles instruction decoding and control signal generation.

🔹 Pipeline
Everything related to pipeline stages and hazard management.

🔹 Registers
PC and register-related modules.

🔹 Datapath
General datapath modules that don’t neatly fall under ALU or Registers but are essential to instruction execution.
