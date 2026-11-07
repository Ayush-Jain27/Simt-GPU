
# SIMT GPU — SystemVerilog RTL Architecture

A personal hardware architecture project exploring parallel
execution, signed integer arithmetic, and GPU-inspired
SIMT (Single Instruction, Multiple Thread) design.

**Status: Early RTL development**

## Project Objective

The goal is to design an eight-lane, single-warp SIMT
processor capable of executing integer compute kernels,
beginning with INT8 matrix-vector multiplication (GEMV).

The project is being developed incrementally, with
functional verification before architectural expansion.

## Current Architecture

The initial compute subsystem consists of:

- Eight independently enabled multiply-accumulate units
- Signed INT8 multiplication
- Signed 32-bit accumulators
- Synchronous accumulator clearing
- Shared clock and per-lane enable masking
- A separate combinational 32-bit ALU

Each MAC lane operates on its own operands and maintains
its own accumulator state.

This is an eight-lane arithmetic subsystem, not yet a
complete instruction-executing SIMT processor.

## Verification

The design includes self-checking SystemVerilog tests
covering:

- Signed arithmetic
- Positive and negative operands
- INT8 boundary values
- Accumulator hold behavior
- Per-lane enable masking
- Synchronous clear priority
- Randomized arithmetic inputs
- Basic ALU operations and comparisons

Simulation results should be recorded after execution.

## Running the Tests

Using Icarus Verilog:

### Single MAC

    iverilog -g2012 -s mac_tb -o mac_sim mac.sv mac_tb.sv
    vvp mac_sim

### Eight-Lane MAC

    iverilog -g2012 -s mac8_tb -o mac8_sim mac.sv mac8.sv mac8_tb.sv
    vvp mac8_sim

### ALU

    iverilog -g2012 -s alu_tb -o alu_sim simt_pkg.sv alu.sv alu_tb.sv
    vvp alu_sim

## Planned Development

### Phase 1 — Arithmetic Datapath
Complete and verify the eight-lane MAC and ALU subsystem.

### Phase 2 — Instruction Execution
Add instruction decoding, a program counter,
per-lane register files, and a warp controller.

### Phase 3 — Memory System
Implement memory access, load/store execution,
and latency handling.

### Phase 4 — GEMV Workload
Execute an INT8 matrix-vector multiplication program
and compare outputs against a Python reference.

### Phase 5 — FPGA Implementation
Target the AMD AUP-ZU3 FPGA platform and report
resource utilization, timing, and performance.

## Design Goals

- Readable and synthesizable SystemVerilog
- Clear separation of control and datapath
- Reproducible functional verification
- Measurable hardware costs and bottlenecks
- Incremental, documented architecture development

## Current Limitations

The current arithmetic subsystem does not implement
instruction fetching, warp scheduling, load/store
execution, or branch divergence handling.

FPGA resource utilization, timing closure, and DSP
inference have not yet been measured.

## Author

Ayush Jain

GitHub: https://github.com/Ayush-Jain27
