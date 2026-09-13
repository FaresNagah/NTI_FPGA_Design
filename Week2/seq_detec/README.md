# Sequence Detector

## Overview

A collection of Verilog sequence detectors implemented using finite state machines (FSMs). The project demonstrates the difference between **Mealy and Moore machines** and between **overlapping and non-overlapping sequence detection**.

The detector receives a serial binary input, keeps track of the previously received bits through its FSM state, and asserts the detection output when the required sequence has been recognized.

## Mealy vs. Moore

The project includes both common FSM output styles:

- **Mealy FSM** – The output depends on both the current state and the current input. The sequence can therefore be detected as soon as the final required input bit arrives.
- **Moore FSM** – The output depends only on the current state. A separate detection state is used to indicate that the sequence has been recognized.

## Overlapping vs. Non-Overlapping Detection

Two sequence-detection behaviors are implemented:

- **Non-overlapping detection** – After detecting a sequence, the FSM returns to an appropriate state without reusing the detected sequence's bits for another detection.
- **Overlapping detection** – After detecting a sequence, the FSM keeps any useful suffix of the detected pattern so that a new occurrence can begin immediately. This allows consecutive or partially overlapping patterns to be detected.

For example, if the target pattern contains bits that can also form the beginning of the next occurrence, an overlapping detector preserves that information while a non-overlapping detector does not.

## Modules

| File | Description |
|---|---|
| `non_over_mealy.v` | Non-overlapping sequence detector using a Mealy FSM |
| `non_over_moore.v` | Non-overlapping sequence detector using a Moore FSM |
| `ovarlap_mealy.v` | Overlapping sequence detector using a Mealy FSM |
| `ovarlap_moore.v` | Overlapping sequence detector using a Moore FSM |
| `seq_tb.v` | Testbench for the sequence detector implementations |

> Note: `ovarlap_*` follows the filename spelling used in the project.

## FSM Operation

The general operation of the detectors is:

1. Start in the initial FSM state.
2. Read one serial input bit at a time.
3. Move to the state representing the progress made toward the target sequence.
4. Continue updating the state according to the incoming bit.
5. Assert the detection output when the required sequence is completed.
6. Depending on the implementation, either restart the search or preserve a useful part of the detected sequence for overlapping detection.

## Verification

The `seq_tb.v` testbench applies serial input patterns to the different detector implementations and observes their detection outputs. This allows the Mealy/Moore and overlapping/non-overlapping behaviors to be compared.

## Waveform

<!-- Upload the waveform screenshot here. -->

## Transcript

<!-- Upload the simulation transcript screenshot here. -->

## Files

- `non_over_mealy.v` – Non-overlapping Mealy sequence detector.
- `non_over_moore.v` – Non-overlapping Moore sequence detector.
- `ovarlap_mealy.v` – Overlapping Mealy sequence detector.
- `ovarlap_moore.v` – Overlapping Moore sequence detector.
- `seq_tb.v` – Sequence detector testbench.
