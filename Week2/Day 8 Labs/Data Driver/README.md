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
<img width="914" height="668" alt="Screenshot 2026-09-08 231748" src="https://github.com/user-attachments/assets/4a1340b5-828d-449e-bfc2-47c0f314db17" />


## Transcript
<img width="526" height="119" alt="image" src="https://github.com/user-attachments/assets/83314b32-0739-44bb-b1cf-4d99b87323bf" />

