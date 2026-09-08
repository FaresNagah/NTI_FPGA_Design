# Data Driver

A parameterized tri-state data driver implemented in Verilog.

## Module
- `driver.v`
- Parameter: `WIDTH = 8`
- Inputs: `data_en`, `data_in`
- Output: `data_out`

## Functionality
- When `data_en = 1`, `data_out` follows `data_in`.
- When `data_en = 0`, `data_out` is set to high impedance (`Z`).

## Testbench
`driver_test.v` verifies the disabled high-impedance state and enabled outputs using `8'h55` and `8'hAA`, then displays `TEST PASSED` when all checks succeed.

## Waveform
<!-- Upload the waveform screenshot here. -->

## Transcript
<!-- Upload the simulation transcript screenshot here. -->
