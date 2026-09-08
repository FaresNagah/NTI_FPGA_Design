# Data Driver

## Overview

A parameterized Verilog data driver that controls whether an input data bus is driven onto the output or placed in a high-impedance (`Z`) state. This models a tri-state data bus interface.

## Operation

| `data_en` | `data_out` |
|-----------|------------|
| `1` | `data_in` |
| `0` | High-impedance (`Z`) |

The `WIDTH` parameter controls the size of the data bus and defaults to 8 bits.

## Inputs

- `data_in [WIDTH-1:0]` – Input data bus.
- `data_en` – Enables or disables the driver.

## Output

- `data_out [WIDTH-1:0]` – Driven data when enabled, otherwise high-impedance.

## Verification

The testbench verifies the driver in both enabled and disabled states and checks the resulting output against the expected values.

## Waveform

<img width="381" height="228" alt="image" src="https://github.com/user-attachments/assets/9b6c70ff-032b-407e-b970-3c6a484d424f" />


## Transcript

<img width="747" height="148" alt="image" src="https://github.com/user-attachments/assets/a459f4b2-bf47-497a-aa8a-cc32ca564100" />


## Files

- `DataDriver.v` – Parameterized data driver RTL implementation.
- `driver_test.v` – Testbench used to verify the data driver.
