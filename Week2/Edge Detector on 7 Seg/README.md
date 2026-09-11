# Edge Detector on 7 Seg

## Overview

A Verilog FPGA design that detects positive and falling edges, counts the detected edges, and displays the resulting count on a six-digit 7-segment display.

## Operation

The design is built from several modules working together:

- **Positive-edge detector** – Detects a rising transition of the input signal using a Moore FSM.
- **Falling-edge detector** – Detects a falling transition of the input signal using a Moore FSM.
- **Edge detector** – Combines the edge-detection logic.
- **Edge counter** – Counts the detected edges.
- **Clock divider** – Generates a slower clock suitable for the display and counter logic.
- **Binary-to-7-segment decoder** – Converts binary values into 7-segment display patterns.
- **Six-digit display controller** – Handles the six 7-segment digits.
- **Top module** – Integrates the complete design.

## Modules

| File | Description |
|---|---|
| `positive_edge_moore.v` | Positive-edge detection using a Moore FSM |
| `falling_edge_moore.v` | Falling-edge detection using a Moore FSM |
| `edge_detector.v` | Edge detection logic |
| `edge_counter.v` | Counts detected edges |
| `clock_divider.v` | Divides the input clock |
| `bi_to_7seg.v` | Binary-to-7-segment decoder |
| `six_digit.v` | Six-digit 7-segment display controller |
| `top_module.v` | Top-level design integrating the modules |
| `toptb.v` | Top-level testbench |

## Verification

The top-level testbench `toptb.v` is used to simulate the complete edge-detector system and observe the generated outputs.

## Waveform

<img width="1139" height="586" alt="Edge Detector Waveform" src="https://github.com/user-attachments/assets/6f6e1299-65a2-4c71-b811-0ef523e95cfe" />

## Transcript

<!-- Upload the simulation transcript screenshot here. -->

## Files

- `positive_edge_moore.v` – Positive-edge Moore FSM.
- `falling_edge_moore.v` – Falling-edge Moore FSM.
- `edge_detector.v` – Edge detection module.
- `edge_counter.v` – Edge counter.
- `clock_divider.v` – Clock divider.
- `bi_to_7seg.v` – Binary-to-7-segment decoder.
- `six_digit.v` – Six-digit display controller.
- `top_module.v` – Top-level module.
- `toptb.v` – Top-level testbench.
