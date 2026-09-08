# MUX

A parameterized 2-to-1 multiplexer implemented in Verilog.

## Module
- `multiplexor.v`
- Parameter: `WIDTH = 5`
- Inputs: `sel`, `in0`, `in1`
- Output: `mux_out`

## Functionality
- When `sel = 0`, `mux_out = in0`.
- When `sel = 1`, `mux_out = in1`.

## Testbench
`multiplexor_test.v` verifies both select conditions using 5-bit test values and displays `TEST PASSED` when all checks succeed.

## Waveform
<!-- Upload the waveform screenshot here. -->

## Transcript
<!-- Upload the simulation transcript screenshot here. -->
