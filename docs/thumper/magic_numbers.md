# Magic Numbers
A magic number is a 32-bit hash value produced by applying a hash function on a ~~string~~ series of bytes. Hash tables are maintained in the game executable storing the hash values for string literals like game file paths, object types and parameter names. This is probably done to avoid expensive string comparisons and allow a more compact way of packing the binary game files.

## Hash Function
Thumper's hash function is split into three parts:
1. Prologue - Performed once per hash
2. Loop - Performed one or more times per hash
3. Epilogie - Performed once per hash

These functions **NO NOT** match the function signitures exactly as seen in the executable, but they are written in a way thats close. See the `thumper binary` section below for accurate function signitures.

### Prologue
```cpp
void prologue(std::uint32_t& value) {
    value = 0x811c9dc5;
}
```

### Epilogue
```cpp
void epilogue(std::uint32_t& value) {
	value *= 0x2001;
	value = (value ^ (value >> 0x7)) * 0x9;
	value = (value ^ (value >> 0x11)) * 0x21;
}
```

### Loop / fnv1a
```cpp
void fnv1a(std::uint32_t& value, std::span<std::byte const> bytes) {
	for (auto const& byte : bytes) {
		value ^= static_cast<std::uint32_t>(byte);
		value *= 0x1000193;
	}
}
```

## How hashes are computed
Thumper never explicitly affixes an input string into the hash, rather this is implemented by invoking the internal loop for each section of the hash. Hash inputs may be non ascii. When implementing a hash function, make sure it can handle non-ascii.

Current there are 1, 2 and 7 known iteration counts for hashing.

An example of a 1 iteration hash is `turn`. The prologue is called, the fnv1a is called once and the epilogue is called once.

For hashing file paths the most common situation is a 2 iteration hash. For example take `levels/demo.objlib`. First the prologue is invoked. Then fnv1a is called with `A`. fnv1a is then invoked again with `levels/demo.objlib`. *Important*: When multiple iterations are invoked, the prologue or epoligue are **not** invoked between them.

This is effectivly the same as directly hashing `Alevels/demo.objlib` but is faster compute without doing string concatenation.

The other known iteration case is 7: This is primarily seen with `.x` files.

For example to get the correct hash for `avatar/shell_right_eye_bulge.x`. Thumper will perform hashing in the following order: `A`, `avatar/shell_right_eye_bulge.x`, `\x9A\x99\x99\x3E`, `\x00\x00\x00\x00`, `\x00\x00\x00\x00`, `\x00`, `\x01\x00\x00\x00`. Effectivly the same as: `Aavatar/shell_right_eye_bulge.x\x9A\x99\x99\x3E\x00\x00\x00\x00\x00\x00\x00\x00\x00\x01\x00\x00\x00`

The specifics on why this happens are still unknown.

## Single function implementaiton
```cpp
void hash32(std::uint32_t& value, std::string_view bytes) {
    // Prologue
    std::uint32_t h = 0x811c9dc5;

    // fnv1a
    for (auto const& byte : bytes) {
        value = (value ^ static_cast<std::uint32_t>(byte)) * 0x1000193;
    }

    // Epilogue
    value *= 0x2001;

    value = value ^ (value >> 0x7);
    value *= 0x9;
    value = value ^ (value >> 0x11);
    value *= 0x21;
}
```

## Thumper Binary Details
After patching the thumper binary, the function entrypoints can be located at the following .text segment offsets:
* `thump_hash_prologue_811c9dc5 : 0x00007FF66AB1FA90`
* `thump_hash_loop : 0x00007FF66AB1FAB0`
* `thump_hash_epilogue : 0x00007FF66AB1FA70`
* `thump_hash_epilogue_stub : 00007FF66AB1FA50`

### Function signitures

## List of Magic Numbers
Here is a list of different magic numbers used in Thumper game files.
* [Hashed File Names](hashed_file_names.md)
* [Types of .objlib Files](objlib_gen_structure.md#types-of-objlib-files)
* [Object Types](object_types.md)
* [Object/Parameter Selectors](object_param_selectors.md)