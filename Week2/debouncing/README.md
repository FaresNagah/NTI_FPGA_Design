# Debouncing

## Overview

A Verilog implementation of a digital debouncing circuit designed to remove the unwanted transitions produced by mechanical push buttons and switches.

Mechanical switches do not change cleanly from `0` to `1` or from `1` to `0`. When a button is pressed or released, the physical contacts can rapidly make and break contact several times before settling. This phenomenon is called **switch bouncing**.

If the raw switch signal is connected directly to digital logic, one physical button press may therefore be interpreted as multiple presses.

## Why Debouncing Is Needed

Consider a button that should produce one clean transition:

```text
Ideal:    0 ─────────── 1

Bounced:  0 ─── 1 0 1 0 1 ─── 1
```

Without debouncing, the FPGA may detect several transitions instead of one. A debouncer waits until the input has remained stable for a required amount of time before accepting the new state.

## Operation

The debouncing circuit samples the input using the clock and filters short, unstable changes. The output is updated only after the input has remained in a stable state for the required number of clock cycles.

The general process is:

1. Sample the mechanical switch input.
2. Detect a change in the input.
3. Start or continue the stabilization period.
4. Ignore short transitions caused by bouncing.
5. Update the debounced output once the input is stable.

This converts an unreliable mechanical signal into a clean digital signal suitable for counters, FSMs, edge detectors, and other synchronous logic.

## Important Design Idea

The debounce interval depends on the FPGA clock frequency and the number of clock cycles used by the filter. A longer filtering interval provides stronger rejection of bounce, while a shorter interval reduces the response delay.

## Modules

| File | Description |
|---|---|
| `bouncer.v` | Debouncing logic that filters unstable switch transitions |
| `bouner_tb.v` | Testbench used to simulate and verify the debouncing behavior |

> Note: `bouner_tb.v` follows the filename spelling used in the project.

## Verification

The `bouner_tb.v` testbench applies input transitions that represent switch activity and observes the debounced output. The simulation demonstrates that short unstable transitions are filtered and that the output responds to a properly stabilized input.

## Waveform

<img width="1238" height="713" alt="Debouncing waveform" src="https://github.com/user-attachments/assets/73f40c6f-0865-4691-8656-f0614228e2c5" />

## Transcript

<img width="335" height="199" alt="Debouncing transcript" src="https://github.com/user-attachments/assets/84ecbae0-99e3-4bba-bba3-02b0f1928f91" />

## Files

- `bouncer.v` – RTL implementation of the debouncing circuit.
- `bouner_tb.v` – Simulation testbench for the debouncer.
