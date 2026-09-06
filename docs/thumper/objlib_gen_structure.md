# General Structure of .objlib Files
Game object library (.objlib) files are game files in a custom-made format, created and edited in [Drool's Editor](drools_editor.md). They are arguably the most important type of game files, defining and controlling various interactive and decorative visual elements and audio elements in the game.

## Types of .objlib Files
In each .objlib file, after the first 4 bytes containing the [file type identifier](overall_structure.md#file-types), the next 4 bytes contain a ["magic number"](magic_numbers.md) identifying what type of .objlib file it is. The following table lists all possible values and their meanings.

| Value (big-endian) | Value (little-endian) | Number of Files | Meaning | Example |
|--------------------|-----------------------|-----------------|---------|---------|
| `4314a51b` | `1ba51443` | 296 | GFX library. Most .objlib files that do not fit into the other types are in this category, including .objlib files that contain UI objects, bosses, VFX, skyboxes, interactive visual objects, and decorative visual objects with simple animations. | vr_toggle.objlib (c71afe7f.pc) |
| `484595b0` | `b0954548` | 90 | Sequin library. These are .objlib files that contain decorative visual objects with complex animations that require more sequencing control. | ducker_ring_sequin.objlib (69e6e7e2.pc) |
| `19621c9d` | `9d1c6219` | 17 | Obj library. These are .objlib files that control the audio aspect of the game, including channels and SFX, and VR playspace scale. | vr_playspace.objlib (ae6469be.pc) |
| `9e4d370b` | `0b374d9e` | 10 | [Level library.](objlib_level_structure.md) These are .objlib files that control the sequence and timing of objects appearing in a level. | demo.objlib (673863f9.pc)|
| `4f6274e6` | `e674624f` | 1 | Avatar library. This is the .objlib file that control the appearance of the beetle and its reactions to input and obstacles. | avatar.objlib (cd2c1ec.pc) |

## File Format
Each .objlib file is divided into six main sections.

### Header
This section contains the [file type identifier](overall_structure.md#file-types) `8`, which stands for .objlib, and the specific type of .objlib file. It also contains a few [int32](data_types.md#int32) values, of which the purposes are unclear at the moment. These [int32](data_types.md#int32) values are probably not important in the grand scheme of things, as all .objlib files of the same type seem to contain the same set of values. The [int32](data_types.md#int32) values included are slightly different between different types of .objlib files. See the examples above for the specific [int32](data_types.md#int32) values included in each type of .objlib file.

### Global Library List
This section lists the global .objlib files referenced by the current .objlib file. Objects defined in the Object Definition section can reference any of the objects contained in these global .objlib files. These global .objlib files can contain more global .objlib files, whose objects can be referenced by the current .objlib file as well.

### File Information
This section contains the original file path of the current .objlib file.

### Object List
This section lists the external objects referenced by the current .objlib file, and the objects defined within the current .objlib file. For each external object, the [object type](object_types.md), object name and the original file path of the .objlib file containing that object are specified. For each object defined within the current file, the [object type](object_types.md) and object name are specified.

### Object Definition
This section contains the definition of each object listed in the Object List section. The objects in this section are defined in the same order as they are listed in the Object List section. There is no clear marker to separate the boundary between two objects. Fortunately, most objects contain the following 32-bit section marker near the beginning:

| Value (big-endian) | Value (little-endian) | Meaning |
|--------------------|-----------------------|---------|
| `12fb8e3c` | `3c8efb12` | Start of the main definition section of the current object. |

For objects that have an empty main definition section, such as .xfm/.xfmer Objects, this marker is optional and may be omitted.

### Footer
This section contains data and objects related to the .objlib file itself. The specific types of data and objects included depend on the type of .objlib file.