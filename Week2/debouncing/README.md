# Debouncing

## Overview

A Verilog debouncing circuit for cleaning up the unstable transitions produced by a mechanical push button or switch.

## Operation

Mechanical switches can produce multiple rapid transitions when pressed or released. The debouncing logic filters these unwanted transitions and provides a stable digital output.

## Verification

The testbench verifies the debouncing logic by applying input transitions and observing that the output changes only after the input has been properly stabilized.

## Waveform

<img width="1238" height="713" alt="Screenshot 2026-09-13 221810" src="https://github.com/user-attachments/assets/73f40c6f-0865-4691-8656-f0614228e2c5" />

<!-- Upload the waveform screenshot here. -->

## Transcript
<img width="335" height="199" alt="Screenshot 2026-09-13 225620" src="https://github.com/user-attachments/assets/84ecbae0-99e3-4bba-bba3-02b0f1928f91" />
<!-- Upload the simulation transcript screenshot here. -->
