# Parity

## Overview

A Verilog implementation of parity generation and checking for binary data. Parity is a simple error-detection technique commonly used in digital communication and data transmission.

The circuit uses the number of `1` bits in a data word to determine its parity. The implementation demonstrates how XOR reduction can be used to calculate parity efficiently in combinational logic.

## Parity Concept

Parity adds one extra bit to a group of data bits so that the total number of `1`s follows a defined rule.

- **Even parity** – The parity bit is chosen so the total number of `1`s, including the parity bit, is even.
- **Odd parity** – The parity bit is chosen so the total number of `1`s, including the parity bit, is odd.

For a data word `data`, the XOR reduction `^data` is `1` when the data contains an odd number of `1`s and `0` when it contains an even number of `1`s.

## Operation

The parity circuit evaluates the input data and produces the corresponding parity result. The output can then be used as a parity bit or as part of a parity-checking process.

For even parity:

```text
parity_bit = ^data
```

This works because XOR is `1` for an odd number of asserted input bits. Adding that parity bit makes the total number of `1`s even.

## Example

| Data | Number of `1`s | Even Parity Bit |
|---|---:|---:|
| `0000` | 0 | `0` |
| `0001` | 1 | `1` |
| `0011` | 2 | `0` |
| `0111` | 3 | `1` |

## Modules

| File | Description |
|---|---|
| `parity.v` | Parity generation/checking logic |
| `parity_tb.v` | Testbench used to verify the parity implementation |

## Verification

The `parity_tb.v` testbench applies different binary input patterns and checks the generated parity result. Testing patterns with both even and odd numbers of `1`s verifies that the parity logic behaves correctly.

## Waveform

<img width="1117" height="731" alt="Parity waveform" src="https://github.com/user-attachments/assets/dfe65315-9190-420e-a5d7-bde813a2964d" />

## Transcript

<!-- Upload the simulation transcript screenshot here. -->

## Files

- `parity.v` – RTL implementation of the parity logic.
- `parity_tb.v` – Simulation testbench.
