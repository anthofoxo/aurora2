# Undocumented Headers
<div class="warning">
This page is entirely WIP and the information here is activly being studied and is not complete!
</div>

## Headers
Headers are defined as set of u32. The headers are not known set since their structures are not layed out yet.

* `.anim` - `[0x07, 0x02]`, `[0x21, 0x04, 0x02]`, `[0x13, 0x15]`
* `.flow` - `[0x13, 0x15]`, `[0x16, 0x04, 0x02]`
*  `.spn` - `[0x13, 0x15, 0x04, 0x01]`
*  `.mat` - `[0x21, 0x04, 0x01]`, `[0x13, 0x15]`, `[0x03, 0x13, 0x15]`
*  `.xfm` -  *none*
* `.cube` - `[0x05, 0x04, 0x01]`
*  `.ent` - `[0x26, 0x04, 0x02]`, `[0x13, 0x15]`
*  `.lvl` - `[0x33, 0x21, 0x04, 0x02]`
* `.leaf` - `[0x22, 0x21, 0x04, 0x02]`
* `.mesh` - `[0x13, 0x15]`, `[0x0F, 0x04, 0x03]`
*  `.txt` - `[0x0D, 0x04, 0x05]`
*  `.tex` - `[0x03, 0x04, 0x01]`
*  `.cam` - `[0x06, 0x03, 0x04]`
* `.settings` - `???`

## `.xfm` is a special case without an empty object definition
| Type     | Name  | Meaning       |
| -------- | ----- | ------------- |
| `u8[0]`  | empty | No definition |


## `.mesh`
| Type        | Name           | Meaning                                  |
| ----------- | -------------- | ---------------------------------------- |
| `u32[...]`  | header         | Header, possible header values not known |
| `u32[13]`   | _unknownField2 | *Unknown*                                |
| `str`       | _unknownField3 | This is a layer trait                    |
| `str`       | _unknownField4 | This is a bucket trait                   |
| `...`       | _unknownField5 | *Unknown*                                |

## `.anim`
There seems to be multiple different types of anim, so this struct will not match all instances of anim you encounter.

| Type        | Name           | Meaning                                  |
| ----------- | -------------- | ---------------------------------------- |
| `u32[...]`  | header         | Header, possible header values not known |
| `str`       | _unknownField2 | *Unknown*, Seems to always be `phase`    |
| `u8[8]`     | _unknownField3 | *Unknown*                                |
| `str`       | _unknownField4 | *Unknown*, Seems to always be `speed`    |
| `...`       | _unknownField5 | *Unknown*                                |