# Mesh Format
Thumper's mesh files are a stripped down version of DirectX .x files. Meshes contain a raw memory dump of vertices and indices along with a few unknowns.

We know enough about the format to export thumper meshes and replace existing ones. We're unsure exactly how the hashes are computed from paths to mesh files.

In Thumper a mesh vertex contains a position, normal vector, texture coordinates, and colors. The colors seem to always be rgba of 0.

## Thumper Mesh Conventions

### UV Coodinate Space
While meshes use 2D texture coodinates, they all seem to lie on a flat line at `y = 0`. This means Thumper likely doesn't do any traditial texture mapping whatsoever and texture coodinates in your mesh will need to be tuned accordingly.

### Face Winding and Axis Orientation
Thumper meshes are typically in clockwise winding order. Only certain meshes care about face winding and it's uncertain what determines this. This is not standard in most mesh formats and winding may need to be adjusted.

Meshes have an inverted Y axis. 

## Tooling
With custom software we can take this data and export it into a usable format or take a mesh and replace it for our own custom meshes. [Aurora](tooling.md#aurora-thumper-cache-decompilation) has native support to do this.

## Format

### Vertex Structure
| Type      | Name     | Meaning                          |
| --------- | -------- | -------------------------------- |
| `f32vec3` | position | Position of the vertex           |
| `f32vec3` | normal   | Normal vector of the mesh        |
| `f32vec2` | texcoord | Texture coordinate of the vertex |
| `u8vec4`  | color    | Color of the vertex              |

### Triangle Structure
| Type     | Name    | Meaning                                 |
| -------- | ------- | --------------------------------------- |
| `u16[3]` | indices | The `3` indices that form the triangle. |

### Mesh Structure
| Type                      | Name            | Meaning            |
| ------------------------- | --------------- | ------------------ |
| `u32`                     | vertexCount     | *self explanatory* |
| `Vertex[vertexCount]`     | vertices        | *self explanatory* |
| `u32`                     | triangleCount   | *self explanatory* |
| `Triangle[triangleCount]` | triangles       | *self explanatory* |
| `u16`                     | _unknownField4 | Typically `1`      |

#### Known Values of `_unknownField4`
* `1`: This is the most common value
* `257`: This is the other known value for this field. We have no idea what this does currently.

All known values of `_unknownField4` are the same across LODs.

### Mesh File
| Type              | Name      | Meaning                  |
| ----------------- | --------- | ------------------------ |
| `u32`             | header    | Must have a value of `6` |
| `u32`             | meshCount | typically `1`            |
| `Mesh[meshCount]` | meshes    | *self explanatory*       |

#### Known Values for `meshCount`
* `1`: This is the most common case
* `2`, `3`, `4`: Used for LODs (May have other uses)
* `167`, `174`: These are used as the part of the header of other file types

## Where Meshes are Seen in-game
While it's not known where every mesh is used, here's a known list of mesh hashes and where they appear in game.

### Level 1 Crakhed Sections
* `6fb05486` - Top

### Level 2 Crakhed Sections
* `c45c2f8d` - Spikes
* `1b1d80a6` - Top
* `d431c102` - Middle
* `fbb9d827` - Bottom

### Level 4-9
* `fb5b011d` - Tunnel (Global)

### Level 7 Crakhed Sections
* `247c1e19` - Top

### Level 8 Crakhed Sections
* `25921ac9` - Top

### Level 9 Crakhed Sections
* `8cb8b1b0` - Crakhed

### Level 9-Infinity
* `ba01318a` - The smaller pyramids after first damage

### Avatar Sections
* `feecba3a` - Elytra / Shell
* `62a36fa5` - Elytra / Shell
* `80717d3d` - Elytra / Shell
* `8f0b6ae3` - Elytra / Shell
* `820a89` - Elytra / Shell
* `b32ff62c` - Elytra / Shell
* `ea4d6098` - Wing
* `6277f30c` - Eyes??
* `77bdd976` - Eyes??
* `65da49f0` - Leg / Mandible??
* `8da4788c` - Leg / Mandible??
* `b434566c` - Leg / Mandible??

### Avatar Track Effects
* `21eab766` - Used along edges of track while moving

### Tunnels
* `1571d820` - Level 1-1 Tunnel

### Track
* `23e0f9a6` - Left Railing
* `48dda1ca` - Right Railing

* `8181e627` - Track Related???
* `5d18a6d0` - Track GFX Related???
* `5a78fba0` - Railing Multilame termination?
* `7f6179e7` - Railing Multilame termination?

### Turns
* `8fe857` - Long turn midsection
* `9a879f8d` - Long turn midsection
* `5dac45eb` - Long turn end??
* `a6d88b36` - Long turn end??
* `62f144f5` - Track lane end GFX??
* `9b1b5db4` - Track lane end GFX??

## Pyramid
`bc09fd01` - Pyramid as seen in title and start of 9-infinity

### Other
* `4ea2877` - Checkpoint Section
* `5a1a0347` - Checkpoint Section???
* `f941ce4b` - Unknown Tunnel
* `dfb1f099` - Zillapede
* `ddde1463` - Crakhed, lower jaw
* `abea8990` - Crakhed, bottom
* `49cdb984` - Crakhed, middle
* `50f9cda3` - Crakhed, middle
* `92750fab` - Crakhed, middle
* `ea65656c` - Crakhed, middle
* `5c4bad17` - Crakhed Spikes
* `91b4e72b` - Crakhed Spikes
* `c971d1b7` - Crakhed Spikes
* `66ac3ee1` - Crakhed bottom
* `ba8f07b4` - Crakhed bottom
* `872bf749` - Crakhed top
* `844d496d` - Zillapede (nospike)