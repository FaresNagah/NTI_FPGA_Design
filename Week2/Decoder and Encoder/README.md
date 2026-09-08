# Decoder and Encoder

Verilog implementations of a 2-to-4 decoder and a 4-to-2 encoder.

## Decoder
- File: `decoder.v`
- Inputs: 2-bit `in`, `enable`
- Output: 4-bit `out`
- When enabled, each 2-bit input selects one corresponding one-hot output.

## Encoder
- File: `encoder.v`
- Inputs: 4-bit `in`, `enable`
- Output: 2-bit `out`
- The testbench applies one-hot inputs `0001`, `0010`, `0100`, and `1000`.

## Testbenches
- `decoder_tb.v`
- `encoder_tb.v`

Both testbenches exercise the implemented input cases and display the resulting outputs.
