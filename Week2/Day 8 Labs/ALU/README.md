# ALU

An 8-bit parameterized ALU implemented in Verilog.

## Module
- `alu.v`
- Parameter: `WIDTH = 8`
- Inputs: `opcode`, `in_a`, `in_b`
- Outputs: `a_is_zero`, `alu_out`

## Operations
| Opcode | Operation |
|---|---|
| `000` | Pass `in_a` |
| `001` | Pass `in_a` |
| `010` | `in_a + in_b` |
| `011` | `in_a & in_b` |
| `100` | `in_a ^ in_b` |
| `101` | Pass `in_b` |
| `110` | Pass `in_a` |
| `111` | Pass `in_a` |

`a_is_zero` is asserted when `in_a` is zero.

## Testbench
`alu_test.v` checks all opcode cases and the zero-input condition, then displays `TEST PASSED` when all checks succeed.
