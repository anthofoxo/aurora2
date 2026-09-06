# .anim Decomp

## Format
| Type     | Name             | Meaning                                 |
| -------- | ---------------- | --------------------------------------- |
| `s32[4]` | header           | Last element may not be a header value? |
| `u32`    | hash             | `0A 9F 25 63`                           |
| `u32`    | _unknownField2   | Unknown, has a value of `1`             |
| `f32`    | _unknownField3   | Unknown, but matches last datapoint     |
| `str`    | traitTime        | `kTimeSeconds`                          |
| `u32`    | _unknownField5   | Edit Comp                               |
| `u32`    | _unknownField6   | 1, Unknown, probably how many sub-objects there is for this .anim entry |
| `str`    | _unknownField7   | `control.rumble`                        |
| `u32`    | _unknownField8   | 1, Unknown, I recall this being used as a flag for "if the parameter can be uniquely identified by a name" or something |
| `u32`    | param            | Object parameter hash                   |
| `s32`    | _unknownField10  | `-1`                                    |
| `u32`    | traitType        | `kTraitFloat (2)`                       |
| `u32`    | dataPointCount   | *Self explanitory*                      |
| `Datapoint[dataPointCount]` | datapoints | Array of [datapoint types](data_types.md#data-point-types)   |

## Footer

| Type    | Name            | Meaning                                   |
| ------- | --------------- | ----------------------------------------- |
| `s32`   | _unknownField00 | Unknown, has a value of `0`               |
| `s32`   | _unknownField01 | Unknown, has a value of `1`               |
| `s32`   | _unknownField02 | Unknown, has a value of `1`               |
| `s32`   | _unknownField03 | Unknown, has a value of `2`               |
| `s32`   | _unknownField04 | Unknown, has a value of `1`               |
| `s32`   | _unknownField05 | Unknown, has a value of `2`               |
| `str`   | _unknownField06 | Unknown, has a value of `kIntensityScale` |
| `str`   | _unknownField07 | Unknown, has a value of `kIntensityScale` |
| `bool`  | _unknownField08 | Unknown, has a value of `true`            |
| `bool`  | _unknownField09 | Unknown, has a value of `true`            |
| `s32`   | _unknownField10 | Unknown, has a value of `1`               |
| `f32`   | _unknownField11 | Unknown, has a value of `1.0`             |
| `f32`   | _unknownField12 | Unknown, has a value of `1.0`             |
| `f32`   | _unknownField13 | Unknown, has a value of `1.0`             |
| `f32`   | _unknownField14 | Unknown, has a value of `1.0`             |
| `f32`   | _unknownField15 | Unknown, has a value of `1.0`             |
| `u32`   | _unknownField16 | Unknown, has a value of `0`. May not be part of this structure. |