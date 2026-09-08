# Full Adder

Verilog implementations of a 1-bit full adder using different modeling styles.

## Modules
- `full_adder_bl.v` — behavioral modeling
- `full_adder_gl.v` — gate-level modeling
- `full_adder_sl.v` — structural modeling using two half adders
- `half_adder.v` — half adder used by the structural implementation

## Inputs and Outputs
- Inputs: `a`, `b`, `cin`
- Outputs: `sum`, `cout`

## Testbench
`full_adder_tb.v` applies all eight possible combinations of `a`, `b`, and `cin` to the behavioral implementation.

## Waveform
<!-- Upload the waveform screenshot here. -->

## Transcript
<!-- Upload the simulation transcript screenshot here. -->
