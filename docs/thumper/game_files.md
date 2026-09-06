# Game Files
## Documentation Conventions
* The byte offset of a value represents the address of the value in the file: the number of bytes between the beginning of the file and where the value can be found. They are expressed in hexadecimal numbers. For simplicity, they are only specified at the beginning of major sections.
* Lengths are specified in terms of number of bytes.
* Magic numbers are specified in little-endian byte order. They are always expressed in hex values, so the prefix 0x is omitted.

## .objlib Files
* boss/
* * boss_7/
* * boss_array/
* * boss_fingers/
* * boss_frac/
* * boss_jump/
* * boss_spiral/
* * boss_spirograph/
* * boss_tube/
* * boss_tunnel/
* * crakhed_fingers/
* * gate_diamond/
* * gate_triangle/
* decorators/
* * barriers/
* * decorative/
* * * sequins/
* * gameplay_objects/
* * jump_high/
* * jumper/
* * level_fingers/
* * obstacles/
* * * wurms/
* * * * sequins/ (decorators/obstacles/wurms/sequins/)
* * entity/
* global/
* * ambient_decorators/
* * boss_shield/
* * damage_flash/
* * electric_effect/
* * ending_sequence/
* * explosion_spikes/
* * geometric_chunks/
* * global_caves/
* * global_lattices/
* * global_scaffolds/
* * global_tubes/
* * god_rays/
* * grind/
* * pellet_fx/
* * pound_slowdown/
* * scrape_effect/
* * spiral_rise/
* * thump_miss/
* * turn_fx/
* levels/
* * Level2/
* * Level3/
* * Level4/
* * Level5/
* * Level6/
* * Level7/
* * Level8/
* * Level9/
* props/
* skybox/
* ui/