# .gate Objects
A .gate Object represents a boss sub-level in the game. Each .gate Object is made up of one or more boss patterns, each represented by a separate [.lvl Object](lvl.md).

## Format

### Header
| Length | Data Type                    | Meaning   |
| ------ | ---------------------------- | --------- |
| 4      | [int32](data_types.md#int32) | *Unknown* |
| 4      | [int32](data_types.md#int32) | *Unknown* |
| 4      | [int32](data_types.md#int32) | *Unknown* |

### Main Definition
*Unknown*

### Footer
| Length   | Data Type                        | Meaning   |
| -------- | -------------------------------- | --------- |
| variable | [string](data_types.md#string)   | *Unknown* |
| variable | [string](data_types.md#string)   | *Unknown* |
| variable | [string](data_types.md#string)   | *Unknown* |
| 4        | [int32](data_types.md#int32)?    | *Unknown* |
| variable | [string](data_types.md#string)   | *Unknown* |
| 4        | [float32](data_types.md#float32) | *Unknown* |
| variable | [string](data_types.md#string)   | *Unknown* |