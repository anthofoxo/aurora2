# Data Types

## Basic Types
All data types are stored in memory with [little-endian byte order](https://en.wikipedia.org/wiki/Endianness).

### s8
A signed 8-bit integer.

### u8
An unsigned 8-bit integer.

### s16
A signed 16-bit integer.

### u16
An unsigned 16-bit integer.

### s32
A signed 32-bit integer.

### u32
An unsigned 32-bit integer.

### f32
A 32-bit [IEEE 754](https://en.wikipedia.org/wiki/IEEE_754) floating point value.

## Alias Types
### bool
An alias of `u8`. A boolean representing `true` or `false`. Valid values are `0` and `1`.

## Structs and Arrays
Arrays and Structs are used to group data together and is common for data points, headers and plenty of other types. Arrays and Structs are byte aligned and tightly packed. This means there are no padding bytes between members.

A Struct lets us make composite types and group data together with names. This makes it easier for us to reason about data.

Unlike in `C` or `C++` we can use variables in our array sizes. This help us define structures cleanly, however when it comes to implementing these structures, you will need to use containers of some kind.

In constract to the tiddlyhost wiki, our types have sizes implicitly known. This means instead of every Struct telling us the individual byte sizes and types, we'll just tell you the type name, and the size can be inferred based on the type. This makes arrays much more intuitive too.

| Type | Name | Meaning   |
| ---- | ---- | --------- |
| `u8` | a    | *Example* |
| `u8` | b    | *Example* |
| `u8` | c    | *Example* |

Given this structure, lets assume `a`, `b`, and `c` are related. We can simply store them together in an array.

| Type    | Name | Meaning   |
| ------- | ---- | --------- |
| `u8[3]` | a    | *Example* |

## Placeholder Types
Placeholder types denote data of unknown size. Ideally we should never need these, however we don't fully understand the Thumper structures so this is needed to make notes to ourselves in a semantic way.

### Unbounded
The unbound placeholder `...` may have any value from `0` to `+Inf`. This is the most extreme placeholder type may select any amount of data.

### Bounded
The bounded placeholder `a..b` may select any value in the range in the closed range of `a` to `b` inclusive.

For example `u8[4..6]` may select `4`, `5`, or `6` bytes.

## Composite Types and Structures

Its common to see arrays with a dynamic size. This will be called a `vector`. Pull from C++ terms. Shortened to `vec` in structs.

### vec\<T\>
| Type       | Name     | Meaning   |
| ---------- | -------- | --------- |
| `u32`      | count    | Number of elements in the array |
| `T[count]` | elements | The elements of the array |

## Composite aliases

### sstr
A string in Thumper is simply a size that refers to the following byte count, then the bytes themselves. Strings are an alias of `vec<T> where T = u8`. When expanded follows this structure:

| Type       | Name  | Meaning                       |
| ---------- | ----- | ----------------------------- |
| `u32`      | size  | Number of bytes in the string |
| `u8[size]` | bytes | The bytes of the string       |

### f32vec2
An array of 2 `f32`. Typically used to represent texture coordinates in meshes.

* The first offset is commonly aliased as `x`, `r` or `s`.
* The second offset is commonly aliased as `y`, `g` or `t`.

| Type     | Name | Meaning                  |
| -------- | ---- | ------------------------ |
| `f32[2]` | vals | The values of the vector |

### f32vec3
An array of 3 `f32`. Typically used to represent positions and normal vectors.

* The first offset is commonly aliased as `x`, or `r`.
* The second offset is commonly aliased as `y`, `g`.
* The third offset is commonly aliased as `z`, `b`.

| Type     | Name | Meaning                  |
| -------- | ---- | ------------------------ |
| `f32[3]` | vals | The values of the vector |

### u8vec4
An array of 4 `u8`. Typically used to represent colors.

* The first offset is commonly aliased as `x`, or `r`.
* The second offset is commonly aliased as `y`, `g`.
* The third offset is commonly aliased as `z`, `b`.
* The fourth offset is commonly aliased as `w`, `a`.

| Type    | Name | Meaning                  |
| ------- | ---- | ------------------------ |
| `u8[4]` | vals | The values of the vector |

## Data Point Types
### boolDataPoint
| Type   | Name          | Meaning                                                                                                                                                |
| ------ | ------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `f32`  | time          | At what time (in beats) this data point occurs. The allowed values for time \\(t\\) are: \\(t \in \mathbb{Z} \vert 0 \leq t < total number of beats\\) |
| `bool` | value         | ON/OFF state. `false` = OFF; `true` = ON.                                                                                                              |
| `str`  | interpolation | This is meaningless for `boolDataPoint`                                                                                                                |
| `str`  | easing        | This is meaningless for `boolDataPoint`                                                                                                                |

### f32DataPoint
| Type   | Name          | Meaning                                                                                            |
| ------ | ------------- | -------------------------------------------------------------------------------------------------- |
| `f32`  | time          | At what time (in beats) this data point occurs. The allowed values for time depend on the context. |
| `f32`  | value         | The value this data point holds. The specific meaning of this value depends on the context.        |
| `str`  | interpolation | What interpolation method is applied on this data point with its neighboring data points. See [Interpolation Trait](trait_values.md#interpolation) for a list of allowed values. |
| `str`  | easing        | What easing method is applied on this data point with its neighboring data points. See [Easing Trait](trait_values.md#easing) for a list of allowed values. |