# Object/Parameter Selectors

## Where Used
* [Sequencer Objects](seqin_objects.md)
* [.gate Objects](gate.md)
* Set Trait Script Nodes

## Values

### Object Parameters
| Data Type                          | Value (little-endian) | Sub-Object/Parameter Name | Main Object              |
| ---------------------------------- | --------------------- | ------------------------- | ------------------------ |
| [float32](data_types.md#float32)   | `e04f3144`            | layer_volume              | [.lvl Objects](lvl.md)   |
| [float32](data_types.md#float32)   | `90db6c5c`            | pitch                     | [.leaf Objects](leaf.md) |
| [float32](data_types.md#float32)   | `461da26a`            | roll                      | [.leaf Objects](leaf.md) |
| [float32](data_types.md#float32)   | `659c0bb8`            | turn                      | [.leaf Objects](leaf.md) |
| [float32](data_types.md#float32)   | `1e470b5d`            | turn_auto                 | [.leaf Objects](leaf.md) |
| [float32](data_types.md#float32)   | `b44b9ff1`            | scale_x                   | [.leaf Objects](leaf.md) |
| [float32](data_types.md#float32)   | `5c01c2b9`            | scale_y                   | [.leaf Objects](leaf.md) |
| [float32](data_types.md#float32)   | `2794bcce`            | scale_z                   | [.leaf Objects](leaf.md) |
| [float32](data_types.md#float32)   | `2e08b151`            | offset_x                  | [.leaf Objects](leaf.md) |
| [float32](data_types.md#float32)   | `fa4ab34f`            | offset_y                  | [.leaf Objects](leaf.md) |
| [float32](data_types.md#float32)   | `1ff804bc`            | offset_z                  | [.leaf Objects](leaf.md) |
| [bool](data_types.md#bool)         | `48697144`            | visibla01                 | [.leaf Objects](leaf.md) |
| [bool](data_types.md#bool)         | `842a58fa`            | visibla02                 | [.leaf Objects](leaf.md) |
| [bool](data_types.md#bool)         | `a444acf9`            | visible                   | [.leaf Objects](leaf.md) |
| [bool](data_types.md#bool)         | `93dcfe04`            | visiblz01                 | [.leaf Objects](leaf.md) |
| [bool](data_types.md#bool)         | `7ce4037d`            | visiblz02                 | [.leaf Objects](leaf.md) |
| [float32](data_types.md#float32)   | `7ec6de5f`            | sequin_speed              | Avatar .objlib Objects   |
| [bool](data_types.md#bool)         | `45e125b3`            | win                       | Avatar .objlib Objects   |
| [bool](data_types.md#bool)         | `f31f3243`            | win_checkpoint            | Avatar .objlib Objects   |
| [bool](data_types.md#bool)         | `d37839a4`            | win_checkpoint_silent     | Avatar .objlib Objects   |
| [bool](data_types.md#bool)         | `82bb9c74`            | play                      | .samp Objects            |
| [bool](data_types.md#bool)         | `7a2ec56d`            | play_clean                | .samp Objects            |
| [bool](data_types.md#bool)         | `a21622fa`            | pause                     | .samp Objects            |
| [bool](data_types.md#bool)         | `0bb8ea4b`            | resume                    | .samp Objects            |
| [bool](data_types.md#bool)         | `9fa68571`            | stop                      | .samp Objects            |
| rgba                               | `13bdaa3b`            | emissive_color            | .mat Objects             |
| rgba                               | `7d06b11c`            | ambient_color             | .mat Objects             |
| rgba                               | `3dfe8a74`            | diffuse_color             | .mat Objects             |
| rgba                               | `d7b602ce`            | specular_color            | .mat Objects             |
| rgba                               | `1ca08372`            | reflectivity_color        | .mat Objects             |
| [float32](data_types.md#float32)   | `52a06bf4`            | alpha                     | .mat Objects             |
| [float32](data_types.md#float32)   | `b3b5d9f1`            | frame                     | .anim Objects            |

### Playable (Interactive) Objects
| Data Type                  | Value (little-endian) | Sub-Object/Parameter Name    | Main Object                                                       |
| -------------------------- | --------------------- | ---------------------------- | ----------------------------------------------------------------- |
| [bool](data_types.md#bool) | `52d7447a`            | thump_rails.a01              | .spn Objects: decorators/thump_rails.objlib                       |
| [bool](data_types.md#bool) | `583cc8c2`            | thump_rails.a02              | .spn Objects: decorators/thump_rails.objlib                       |
| [bool](data_types.md#bool) | `4477bbd4`            | thump_rails.ent              | .spn Objects: decorators/thump_rails.objlib                       |
| [bool](data_types.md#bool) | `dc12888d`            | thump_rails.z01              | .spn Objects: decorators/thump_rails.objlib                       |
| [bool](data_types.md#bool) | `bbf22741`            | thump_rails.z02              | .spn Objects: decorators/thump_rails.objlib                       |
| [bool](data_types.md#bool) | `897c516b`            | thump_checkpoint.ent         | .spn Objects: decorators/thump_rails.objlib                       |
| [bool](data_types.md#bool) | `adfa9f2c`            | thump_rails_fast_activat.ent | .spn Objects: decorators/thump_rails.objlib                       |
| [bool](data_types.md#bool) | `4733a5e6`            | thump_boss_bonus.ent         | .spn Objects: decorators/thump_rails.objlib                       |
| [bool](data_types.md#bool) | `51b93243`            | grindable_still.ent          | .spn Objects: decorators/thump_grindable.objlib                   |
| [bool](data_types.md#bool) | `cf53c501`            | left_multi.a01               | .spn Objects: decorators/thump_grindable.objlib                   |
| [bool](data_types.md#bool) | `becb71fa`            | left_multi.a02               | .spn Objects: decorators/thump_grindable.objlib                   |
| [bool](data_types.md#bool) | `6e5b2576`            | left_multi.ent               | .spn Objects: decorators/thump_grindable.objlib                   |
| [bool](data_types.md#bool) | `d528868a`            | left_multi.z01               | .spn Objects: decorators/thump_grindable.objlib                   |
| [bool](data_types.md#bool) | `b9e107fc`            | center_multi.a02             | .spn Objects: decorators/thump_grindable.objlib                   |
| [bool](data_types.md#bool) | `ed5a7e91`            | center_multi.ent             | .spn Objects: decorators/thump_grindable.objlib                   |
| [bool](data_types.md#bool) | `e27b6c3c`            | center_multi.z01             | .spn Objects: decorators/thump_grindable.objlib                   |
| [bool](data_types.md#bool) | `99f4653e`            | right_multi.a02              | .spn Objects: decorators/thump_grindable.objlib                   |
| [bool](data_types.md#bool) | `1e0ae961`            | right_multi.ent              | .spn Objects: decorators/thump_grindable.objlib                   |
| [bool](data_types.md#bool) | `03fd4938`            | right_multi.z01              | .spn Objects: decorators/thump_grindable.objlib                   |
| [bool](data_types.md#bool) | `73b0f245`            | right_multi.z02              | .spn Objects: decorators/thump_grindable.objlib                   |
| [bool](data_types.md#bool) | `3e774af9`            | grindable_quarters.ent       | .spn Objects: decorators/thump_grindable_multi.objlib             |
| [bool](data_types.md#bool) | `73af2bae`            | grindable_double.ent         | .spn Objects: decorators/thump_grindable_multi.objlib             |
| [bool](data_types.md#bool) | `2216f6df`            | grindable_thirds.ent         | .spn Objects: decorators/thump_grindable_multi.objlib             |
| [bool](data_types.md#bool) | `8b3738a4`            | grindable_with_thump.ent     | .spn Objects: decorators/thump_grindable_multi.objlib             |
| [bool](data_types.md#bool) | `c933e313`            | ducker_crak.ent              | .spn Objects: decorators/ducker.objlib                            |
| [bool](data_types.md#bool) | `0743418a`            | jumper_1_step.ent            | .spn Objects: decorators/jumper/jumper_set.objlib                 |
| [bool](data_types.md#bool) | `2eb30851`            | jumper_boss.ent              | .spn Objects: decorators/jumper/jumper_set.objlib                 |
| [bool](data_types.md#bool) | `8d55abe4`            | jumper_6_step.ent            | .spn Objects: decorators/jumper/jumper_set.objlib                 |
| [bool](data_types.md#bool) | `b886b204`            | jump_high.ent                | .spn Objects: decorators/jump_high/jump_high_set.objlib           |
| [bool](data_types.md#bool) | `9b004f93`            | jump_high_2.ent              | .spn Objects: decorators/jump_high/jump_high_set.objlib           |
| [bool](data_types.md#bool) | `cdfddfc4`            | jump_high_4.ent              | .spn Objects: decorators/jump_high/jump_high_set.objlib           |
| [bool](data_types.md#bool) | `10be3b0b`            | jump_high_6.ent              | .spn Objects: decorators/jump_high/jump_high_set.objlib           |
| [bool](data_types.md#bool) | `0ef04fb0`            | jump_boss.ent                | .spn Objects: decorators/jump_high/jump_high_set.objlib           |
| [bool](data_types.md#bool) | `601c9d22`            | swerve_off.a01               | .spn Objects: decorators/obstacles/wurms/millipede_half.objlib    |
| [bool](data_types.md#bool) | `d881767c`            | swerve_off.a02               | .spn Objects: decorators/obstacles/wurms/millipede_half.objlib    |
| [bool](data_types.md#bool) | `3f602426`            | swerve_off.ent               | .spn Objects: decorators/obstacles/wurms/millipede_half.objlib    |
| [bool](data_types.md#bool) | `c92199c0`            | swerve_off.z01               | .spn Objects: decorators/obstacles/wurms/millipede_half.objlib    |
| [bool](data_types.md#bool) | `0d0004b1`            | swerve_off.z02               | .spn Objects: decorators/obstacles/wurms/millipede_half.objlib    |
| [bool](data_types.md#bool) | `43eae5dd`            | millipede_half.a01           | .spn Objects: decorators/obstacles/wurms/millipede_half.objlib    |
| [bool](data_types.md#bool) | `ce42c1bf`            | millipede_half.a02           | .spn Objects: decorators/obstacles/wurms/millipede_half.objlib    |
| [bool](data_types.md#bool) | `be018127`            | millipede_half.ent           | .spn Objects: decorators/obstacles/wurms/millipede_half.objlib    |
| [bool](data_types.md#bool) | `b01d4126`            | millipede_half.z01           | .spn Objects: decorators/obstacles/wurms/millipede_half.objlib    |
| [bool](data_types.md#bool) | `45b829c9`            | millipede_half.z02           | .spn Objects: decorators/obstacles/wurms/millipede_half.objlib    |
| [bool](data_types.md#bool) | `bf2a2b2a`            | millipede_half_phrase.a01    | .spn Objects: decorators/obstacles/wurms/millipede_half.objlib    |
| [bool](data_types.md#bool) | `cacf6bea`            | millipede_half_phrase.a02    | .spn Objects: decorators/obstacles/wurms/millipede_half.objlib    |
| [bool](data_types.md#bool) | `bbaf4e32`            | millipede_half_phrase.ent    | .spn Objects: decorators/obstacles/wurms/millipede_half.objlib    |
| [bool](data_types.md#bool) | `f53455f0`            | millipede_half_phrase.z01    | .spn Objects: decorators/obstacles/wurms/millipede_half.objlib    |
| [bool](data_types.md#bool) | `f28e0216`            | millipede_half_phrase.z02    | .spn Objects: decorators/obstacles/wurms/millipede_half.objlib    |
| [bool](data_types.md#bool) | `366799e4`            | millipede_quarter.a01        | .spn Objects: decorators/obstacles/wurms/millipede_quarter.objlib |
| [bool](data_types.md#bool) | `40b25fd4`            | millipede_quarter.a02        | .spn Objects: decorators/obstacles/wurms/millipede_quarter.objlib |
| [bool](data_types.md#bool) | `1703ae12`            | millipede_quarter.ent        | .spn Objects: decorators/obstacles/wurms/millipede_quarter.objlib |
| [bool](data_types.md#bool) | `66ac1596`            | millipede_quarter.z01        | .spn Objects: decorators/obstacles/wurms/millipede_quarter.objlib |
| [bool](data_types.md#bool) | `db0dba2f`            | millipede_quarter.z02        | .spn Objects: decorators/obstacles/wurms/millipede_quarter.objlib |
| [bool](data_types.md#bool) | `041539b3`            | millipede_quarter_phrase.a01 | .spn Objects: decorators/obstacles/wurms/millipede_quarter.objlib |
| [bool](data_types.md#bool) | `4c1c613a`            | millipede_quarter_phrase.a02 | .spn Objects: decorators/obstacles/wurms/millipede_quarter.objlib |
| [bool](data_types.md#bool) | `1d2ce5f4`            | millipede_quarter_phrase.ent | .spn Objects: decorators/obstacles/wurms/millipede_quarter.objlib |
| [bool](data_types.md#bool) | `0bc1ab97`            | millipede_quarter_phrase.z01 | .spn Objects: decorators/obstacles/wurms/millipede_quarter.objlib |
| [bool](data_types.md#bool) | `1e48e54e`            | millipede_quarter_phrase.z02 | .spn Objects: decorators/obstacles/wurms/millipede_quarter.objlib |
| [bool](data_types.md#bool) | `f1e67274`            | sentry.ent                   | .spn Objects: decorators/sentry.objlib                            |
| [bool](data_types.md#bool) | `8792db5a`            | level_9.ent                  | .spn Objects: decorators/sentry.objlib                            |
| [bool](data_types.md#bool) | `32eb179b`            | level_5.ent                  | .spn Objects: decorators/sentry.objlib                            |
| [bool](data_types.md#bool) | `476dfd28`            | level_8.ent                  | .spn Objects: decorators/sentry.objlib                            |
| [bool](data_types.md#bool) | `32e9a51e`            | sentry_boss.ent              | .spn Objects: decorators/sentry.objlib                            |
| [bool](data_types.md#bool) | `bfeb686e`            | level_7.ent                  | .spn Objects: decorators/sentry.objlib                            |
| [bool](data_types.md#bool) | `ac58b0b9`            | level_6.ent                  | .spn Objects: decorators/sentry.objlib                            |
| [bool](data_types.md#bool) | `c70f3afd`            | sentry_boss_multilane.ent    | .spn Objects: decorators/sentry.objlib                            |
| [bool](data_types.md#bool) | `b4034d58`            | level_8_multi.ent            | .spn Objects: decorators/sentry.objlib                            |
| [bool](data_types.md#bool) | `b87c60e8`            | level_9_multi.ent            | .spn Objects: decorators/sentry.objlib                            |

### Decorative Objects
| Data Type                  | Value (little-endian) | Sub-Object/Parameter Name | Main Object                                                       |
| -------------------------- | --------------------- | ------------------------- | ----------------------------------------------------------------- |
| [bool](data_types.md#bool) | `a8d60562`            | trees.ent                 | .spn Objects: decorators/jump_high/jump_high_big_trees_set.objlib |
| [bool](data_types.md#bool) | `bb63511d`            | trees_16.ent              | .spn Objects: decorators/jump_high/jump_high_big_trees_set.objlib |
| [bool](data_types.md#bool) | `c5af922f`            | trees_4.ent               | .spn Objects: decorators/jump_high/jump_high_big_trees_set.objlib |
| [bool](data_types.md#bool) | `1e7bd174`            | speed_streaks_short.ent   | .spn Objects: entity/ambient_fx.objlib                            |
| [bool](data_types.md#bool) | `87cdcba8`            | speed_streaks_RGB.ent     | .spn Objects: entity/ambient_fx.objlib                            |
| [bool](data_types.md#bool) | `c66f96dd`            | smoke.ent                 | .spn Objects: entity/ambient_fx.objlib                            |
| [bool](data_types.md#bool) | `d7843636`            | death_shatter.ent         | .spn Objects: entity/ambient_fx.objlib                            |
| [bool](data_types.md#bool) | `55a80a99`            | speed_streaks.ent         | .spn Objects: entity/ambient_fx.objlib                            |
| [bool](data_types.md#bool) | `76414bb7`            | data_streaks_radial.ent   | .spn Objects: entity/ambient_fx.objlib                            |
| [bool](data_types.md#bool) | `49113923`            | boss_7_tunnel_enter.ent   | .spn Objects: entity/ambient_fx.objlib                            |
| [bool](data_types.md#bool) | `db619bed`            | boss_damage_stage4.ent    | .spn Objects: entity/ambient_fx.objlib                            |
| [bool](data_types.md#bool) | `a28811db`            | crakhed_damage.ent        | .spn Objects: entity/ambient_fx.objlib                            |
| [bool](data_types.md#bool) | `6f02512b`            | win_debris.ent            | .spn Objects: entity/ambient_fx.objlib                            |
| [bool](data_types.md#bool) | `a8bd36c8`            | crakhed_destroy.ent       | .spn Objects: entity/ambient_fx.objlib                            |
| [bool](data_types.md#bool) | `71dc045d`            | stalactites.ent           | .spn Objects: entity/ambient_fx.objlib                            |
| [bool](data_types.md#bool) | `6ac944d0`            | aurora.ent                | .spn Objects: entity/ambient_fx.objlib                            |
| [bool](data_types.md#bool) | `01a07bd9`            | vortex_decorator.ent      | .spn Objects: entity/ambient_fx.objlib                            |
| [bool](data_types.md#bool) | `718ff746`            | boss_damage_stage3.ent    | .spn Objects: entity/ambient_fx.objlib                            |
| [bool](data_types.md#bool) | `d8258d1a`            | boss_damage_stage1.ent    | .spn Objects: entity/ambient_fx.objlib                            |
| [bool](data_types.md#bool) | `b00a87d0`            | boss_damage_stage2.ent    | .spn Objects: entity/ambient_fx.objlib                            |
| [bool](data_types.md#bool) | `d8e402da`            | black                     | skybox_colors.flow (levels/demo.objlib)                           |
| [bool](data_types.md#bool) | `1411f1a3`            | crakhed                   | skybox_colors.flow (levels/demo.objlib)                           |
| [bool](data_types.md#bool) | `4bb91040`            | dark_blue                 | skybox_colors.flow (levels/demo.objlib)                           |
| [bool](data_types.md#bool) | `fa50813b`            | dark_green                | skybox_colors.flow (levels/demo.objlib)                           |
| [bool](data_types.md#bool) | `30656178`            | dark_red                  | skybox_colors.flow (levels/demo.objlib)                           |
| [bool](data_types.md#bool) | `c0c8325a`            | light_blue                | skybox_colors.flow (levels/demo.objlib)                           |
| [bool](data_types.md#bool) | `3b652d19`            | light_green               | skybox_colors.flow (levels/demo.objlib)                           |
| [bool](data_types.md#bool) | `a7aa53f0`            | light_red                 | skybox_colors.flow (levels/demo.objlib)                           |
### SFX Objects
| Data Type                  | Value (little-endian) | Sub-Object/Parameter Name | Main Object                                                |
| -------------------------- | --------------------- | ------------------------- | ---------------------------------------------------------- |
| [bool](data_types.md#bool) | `e5745bf3`            | fire                      | turn_anticipation.flow (levels/Level6/level_6.objlib)      |
| [bool](data_types.md#bool) | `e073575f`            | diss11                    | dissonant_bursts.flow (global/dissonant_bursts.objlib)     |
| [bool](data_types.md#bool) | `79603dd3`            | french12                  | french_horn_chords.flow (global/french_horn_chords.objlib) |

### Bosses ([.gate Objects](gate.md) only)
| Data Type | Value (little-endian) | Sub-Object/Parameter Name | Main Object                                           |
| --------- | --------------------- | ------------------------- | ----------------------------------------------------- |
| N/A       | `8c0dd639`            | tutorial_thumps.ent       | .spn Objects: boss/gate_triangle/triangle_boss.objlib |
| N/A       | `c7c056e2`            | boss_gate_pellet.ent      | .spn Objects: boss/boss_spiral/gate_spiral.objlib     |