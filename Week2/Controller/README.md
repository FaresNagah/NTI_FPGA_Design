# Controller

## Overview

A Verilog controller implemented as a finite state machine (FSM) for an 8-bit processor. The controller decodes the instruction opcode and generates the required control signals across the different execution phases.

## Instruction Set

| Opcode | Instruction |
|---|---|
| `000` | HLT |
| `001` | SKZ |
| `010` | ADD |
| `011` | AND |
| `100` | XOR |
| `101` | LDA |
| `110` | STO |
| `111` | JMP |

## Operation

The controller progresses through the processor's execution phases and generates control signals according to the current phase and instruction opcode.

The implemented instruction sequence includes:

- **HLT** – Halt execution.
- **SKZ** – Skip the next instruction when the accumulator is zero.
- **ADD** – Perform addition using the accumulator and memory data.
- **AND** – Perform a bitwise AND operation.
- **XOR** – Perform a bitwise XOR operation.
- **LDA** – Load data from memory into the accumulator.
- **STO** – Store the accumulator value in memory.
- **JMP** – Jump to the specified memory address.

## Inputs

- `opcode [2:0]` – 3-bit instruction opcode.
- `phase [2:0]` – Current execution phase.
- `reset` – Resets the controller state.
- `zero` – Indicates whether the accumulator is zero.

## Outputs

The controller generates the processor control signals required during each execution phase, including signals for memory read/write, accumulator operations, ALU operations, program counter control, and instruction register control.

## Verification

The testbench `controller_test.v` verifies the controller by applying the different instruction opcodes and execution phases and checking the resulting control signals.

## Waveform

<!-- Upload the waveform screenshot here. -->
<img width="1229" height="613" alt="Screenshot 2026-09-09 172412" src="https://github.com/user-attachments/assets/efa9d3d7-1277-49f2-84be-2f90f519a560" />



## Transcript
<img width="596" height="179" alt="Screenshot 2026-09-09 172357" src="https://github.com/user-attachments/assets/d9226fe7-ee04-43a6-a15b-8d565ee22ce7" />


<!-- Upload the simulation transcript screenshot here. -->

## Files

- `controller.v` – FSM-based controller implementation.
- `controller_test.v` – Testbench used to verify the controller operation and control signals.
