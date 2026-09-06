# Overall Structure of Game Files
Most of the game files, including 3D meshes, textures, audio samples and game object libraries, are located under the cache folder in the game's installation directory. All of them are cryptically named with 8 hex characters plus a .pc file extension. The cryptic file names are resulted from applying a [32-bit hash function](magic_numbers.md) to their original file paths. For game object libraries and audio samples, their original file paths or file names are stored within the game files themselves and can be extracted. See [Hashed File Names](hashed_file_names.md) for a list of known hashed file names and their original file names.

## File Types
The first 4 bytes of each game file is an [int32](data_types.md#int32) number identifying its file type. All possible values are listed in the table below.

<div class="warning">
The 12, 13, and 14 rows are incorrect. Value 12 is not known to contain textures. Value 13 Contains the 9 textures and Value 14 doesnt contain a level list, but instead contains all the other known textures. Value 14 doesn't include the level list.
</div>

| Value | Number of Files | Meaning |
| ----- | --------------- | ------- |
| `0`   |   1 | Scoring file. Defines the scoring rules, such as how many points are awarded for each type of action and no miss and no damage bonuses. |
| `4`   |   4 | Config files. |
| `5`   |   1 | A list of UI menus, such as the main menu (Credits, Level Select, Leaderboards, Options) and in-game pause screen. (Restart Checkpoint, Exit) |
| `6`   | 615 | [3D mesh files](mesh.md)[^xfile] and localization files. |
| `8`   | 414 | [Game object library (.objlib, custom format) files.](objlib_gen_structure.md) |
| `9`   |  28 | Credits files and level config files. |
| `12`  |   9 | Texture files.[^texfile] |
| `13`  | 997 | Audio sample files[^audiofile] and texture files.[^texfile] |
| `14`  |   1 | A list of levels. (Level 1 – Level 9) |
| `28`  |   2 | Shader files. |
| `93`  |  33 | *Unknown.* |

## Footnotes
[^xfile]: Documentation used to say 634, however this is inaccurate and included the headers of other file types.

[^texfile]: Textures use the .dds DirectDraw Surface format.

[^audiofile]: Audio files use FSB5 and FMOD Sample Banks.