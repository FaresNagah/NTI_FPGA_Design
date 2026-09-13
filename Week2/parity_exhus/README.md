# Parity Exhaustive

## Overview

An exhaustive verification of the parity circuit. Instead of checking only a few selected data values, the testbench exercises the complete range of supported input combinations and verifies the parity result for every case.

Exhaustive verification is useful for small combinational circuits because every possible input can be tested, giving strong confidence that the implementation follows the expected truth table.

## Parity Concept

Parity is based on the number of `1`s in a binary data word.

- **Even parity** requires the total number of `1`s, including the parity bit, to be even.
- **Odd parity** requires the total number of `1`s, including the parity bit, to be odd.

For even parity, the XOR reduction of the data is commonly used:

```text
parity_bit = ^data
```

If the data contains an odd number of `1`s, the reduction XOR is `1`; if it contains an even number of `1`s, the result is `0`.

## Exhaustive Testing

The testbench systematically applies the available binary input combinations to the parity design and compares the output with the expected parity value.

For an `N`-bit input, exhaustive testing covers all `2^N` possible input combinations.

This is particularly useful for confirming that edge cases are not missed and that the parity logic works consistently for both even and odd numbers of `1`s.

## Modules

| File | Description |
|---|---|
| `parity.v` | Parity generation/checking logic used by the testbench |
| `parity_tb_withexh.v` | Testbench that performs exhaustive parity verification |

## Verification

`parity_tb_withexh.v` applies the complete set of supported input combinations and checks each result against the expected parity. A successful simulation confirms that all tested combinations produce the correct result.

## Waveform

<img width="1261" height="746" alt="Exhaustive parity waveform" src="https://github.com/user-attachments/assets/2c3ee473-4009-4de2-81d2-94599fc408c2" />

## Transcript

<img width="503" height="74" alt="Exhaustive parity transcript" src="https://github.com/user-attachments/assets/f2176660-0e2c-423a-a833-2d6dcebe6def" />

## Files

- `parity.v` – RTL implementation of the parity logic.
- `parity_tb_withexh.v` – Exhaustive verification testbench.
