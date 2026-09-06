# Data Types
Types are the fundamental entity defining how a certain region of memory should be interpreted, formatted and displayed.
All types are interpreted in little endian.
Structures are written using the [ImHex Pattern Language](https://docs.werwolv.net/pattern-language).

## Unsigned Integers
Unsigned integer types represent regular binary numbers. They are displayed as a integer value ranging from `0` to `(2^(8*size-1))`.

| Name  | Size    |
| ----- | ------- |
| `u8`  | 1 Byte  |
| `u16` | 2 Bytes |
| `u32` | 4 Bytes |

## Signed Integers
Signed integer types represent signed binary numbers in Two's Complement representation.
They are displayed as a integer value ranging from `-(2^(7*size))` to `(2^(7*size)-1)`

| Name  | Size    |
| ----- | ------- |
| `s8`  | 1 Byte  |
| `s16` | 2 Bytes |
| `s32` | 4 Bytes |

## Floating Points
Floating Point types represent a floating pointer number.

| Name  | Size             |
| ----- | ---------------- |
| `f32` | 4 Bytes, IEEE754 |
| `f64` | 8 Bytes, IEEE754 |

## Aliases
Aliases provide are just another way to represent data with a more meaningful type name.

| Name   | Size   | Description                    |
| ------ | ------ | ------------------------------ |
| `char` | 1 Byte | ASCII Character                |
| `bool` | 1 Byte | Boolean value `true` / `false` |

## Strings
### `sstr`
Sized strings start with a byte length followed by the character bytes. This is the most common string type used.

```hexpat
u32 size;
char bytes[size];
```

### `cstr`
A c style null terminated string. The string bytes just begin and continue until a `null` / `0x00` byte is hit.

```hexpat
char bytes[];
```