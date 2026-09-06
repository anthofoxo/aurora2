# Trait Values

## Trait Type
| Index | Value             | Meaning                            |
| ----- | ----------------- | ---------------------------------- |
|   `0` | `kTraitInt`       | [int32](data_types.md#int32)       |
|   `1` | `kTraitBool`      | [bool](data_types.md#bool)         |
|   `2` | `kTraitFloat`     | [float32](data_types.md#float32)   |
|   `3` | `kTraitColor`     | rgba                               |
|   `4` | `kTraitObj`       | Object                             |
|   `5` | `kTraitVec3`      | [vector3f](data_types.md#vector3f) |
|   `6` | `kTraitPath`      | Path                               |
|   `7` | `kTraitEnum`      | Enum                               |
|   `8` | `kTraitAction`    | Action                             |
|   `9` | `kTraitObjVec`    | Object Vector                      |
|  `10` | `kTraitString`    | [string](data_types.md#sstr)       |
|  `11` | `kTraitCue`       | Cue                                |
|  `12` | `kTraitEvent`     | Event                              |
|  `13` | `kTraitSym`       | Symbol                             |
|  `14` | `kTraitList`      | List                               |
|  `15` | `kTraitTraitPath` | Trait Path                         |
|  `16` | `kTraitQuat`      | Quaternion                         |
|  `17` | `kTraitChildLib`  | Child Library                      |
|  `18` | `kTraitComponent` | Component                          |
|  `19` | `kNumTraitTypes`  | Default                            | 

## Interpolation
| Value                   | Meaning                 |
|-------------------------|-------------------------|
| `kTraitInterpLinear`    | Linear Interpolation    |
| `kTraitInterpQuadratic` | Quadratic Interpolation |
| `kTraitInterpCubic`     | Cubic Interpolation     |
| `kTraitInterpQuartic`   | Quartic Interpolation   |
| `kTraitInterpQuintic`   | Quintic Interpolation   |
| `kTraitInterpSine`      | Sine Interpolation      |
| `kTraitInterpStep`      | Step Interpolation      |
| `kTraitInterpNone`      | No Interpolation        |

## Easing
| Value        | Meaning     |
|--------------|-------------|
| `kEaseInOut` | Ease In Out |
| `kEaseIn`    | Ease In     |
| `kEaseOut`   | Ease Out    |

## Intensity
| Value             | Meaning   |
|-------------------|-----------|
| `kIntensityScale` | *Unknown* |
| `kIntensityAdd`   | *Unknown* |

## Time
| Value                  | Meaning                                                                             |
| ---------------------- | ----------------------------------------------------------------------------------- |
| `kTimeBeats`           | Use beats in relative time as the unit of time                                      |
| `kTimeSeconds`         | Use seconds in relative time as the unit of time                                    |
| `kTimeBeatsRealtime`   | Use beats in absolute time ([.master Object](master.md) time) as the unit of time   |
| `kTimeSecondsRealtime` | Use seconds in absolute time ([.master Object](master.md) time) as the unit of time |

## Move Phase
| Value                   | Meaning   |
|-------------------------|-----------|
| `kMovePhaseRepeatChild` | *Unknown* |
| `kMovePhaseRepeat`      | *Unknown* |

## Step
| Value           | Meaning   |
|-----------------|-----------|
| `kStepGameplay` | *Unknown* |
| `kStepProp`     | *Unknown* |

## Section
| Value                        | Meaning                    |
|------------------------------|----------------------------|
| `SECTION_LINEAR`             | Linear section             |
| `SECTION_BOSS_TRIANGLE`      | Triangle boss section      |
| `SECTION_BOSS_CIRCLE`        | Circle boss section        |
| `SECTION_BOSS_MINI`          | Mini boss section          |
| `SECTION_BOSS_CRAKHED`       | Crakhed boss section       |
| `SECTION_BOSS_CRAKHED_FINAL` | Crakhed final boss section |
| `SECTION_BOSS_PYRAMID`       | Pyramid boss section       |
| `SECTION_END`                | End section                |

## Gate Sentry
| Value                | Meaning            |
|----------------------|--------------------|
| `SENTRY_NONE`        | No sentry          |
| `SENTRY_SINGLE_LANE` | Single lane sentry |
| `SENTRY_MULTI_LANE`  | Multi-lane sentry  |

## Level Random Type
| Value                 | Meaning             |
|-----------------------|---------------------|
| `LEVEL_RANDOM_NONE`   | No level randomness |
| `LEVEL_RANDOM_BUCKET` | *Unknown*           |
| `LEVEL_RANDOM_PURE`   | *Unknown*           |

## Layer
| Value            | Meaning                                                                                 |
|------------------|-----------------------------------------------------------------------------------------|
| `kLayerWorld`    | World layer. An object with this layer trait is drawn first, behind all other objects.  |
| `kLayerUI`       | UI layer. An object with this layer trait is drawn last, in front of all other objects. |
| `kNumDrawLayers` | Default layer.                                                                          |

## Bucket
| Value               | Meaning                                                                                                                         |
|---------------------|---------------------------------------------------------------------------------------------------------------------------------|
| `kBucketTerrain`    | Terrain bucket. Objects with this trait value are drawn first, before objects in other buckets.                                 |
| `kBucketMain`       | Main bucket. Objects with this trait value are drawn after the terrain bucket objects and before the effect bucket objects.     |
| `kBucketEffect`     | Effect bucket. Objects with this trait value are drawn after the main bucket objects and before the post effect bucket objects. |
| `kBucketPostEffect` | Post effect bucket. Objects with this trait value are drawn last, after objects in other buckets.                               |
| `kBucketParent`     | Parent bucket. An object with this trait value is in the same bucket as its parent.                                             |

## Constraint
| Value                  | Meaning              |
|------------------------|----------------------|
| `kConstraintParent`    | Parent constraint    |
| `kConstraintBillboard` | Billboard constraint |
| `kConstraintSkybox`    | Skybox constraint    |

## Blend
| Value                     | Meaning   |
|---------------------------|-----------|
| `kSource`                 | *Unknown* |
| `kAdditive`               | *Unknown* |
| `kSubtractive`            | *Unknown* |
| `kSourceSubtractive`      | *Unknown* |
| `kAlphaSource`            | *Unknown* |
| `kAlphaSourceAdditive`    | *Unknown* |
| `kAlphaSourceSubtractive` | *Unknown* |
| `kStencilPortalBlending`  | *Unknown* |

## Z Mode
| Value       | Meaning     |
|-------------|-------------|
| `kZDisable` | Z Disable   |
| `kZTestOnly`| Z Test Only |
| `kZEnable`  | Z Enable    |

## Stencil Channel
| Value                    | Meaning   |
|--------------------------|-----------|
| `kStencilDisabled`       | *Unknown* |
| `kStencilPortal`         | *Unknown* |
| `kStencilPortalInside`   | *Unknown* |
| `kStencilPortalOutside`  | *Unknown* |
| `kStencilShadowDrawOnce` | *Unknown* |

## Material Filtering
| Value             | Meaning          |
|-------------------|------------------|
| `kFilteringNone`  | No filtering     |
| `kFilteringLinear`| Linear filtering |

## Material Lighting
| Value                      | Meaning                   |
|----------------------------|---------------------------|
| `kLightingNone`            | No lighting               |
| `kLightingVertex`          | Vertex lighting           |
| `kLightingPixel`           | Pixel lighting            |
| `kLightingEmissiveReflect` | Emissive Reflect lighting |

## Texture Transform Mode
| Value               | Meaning                      |
|---------------------|------------------------------|
| `kTexXfmDisable`    | Texture transform disable    |
| `kTexXfmEnable`     | Texture transform enable     |
| `kTexXfmReflection` | Texture transform reflection |

## Animation Type
| Value                         | Meaning   |
|-------------------------------|-----------|
| `kTraitAnimNormal`            | *Unknown* |
| `kTraitAnimStep`              | *Unknown* |
| `kTraitAnimStepFloatRange`    | *Unknown* |
| `kTraitAnimStepDuration`      | *Unknown* |
| `kTraitAnimStepDurationFixed` | *Unknown* |

## Path Scale Interpolation
| Value                   | Meaning                         |
|-------------------------|---------------------------------|
| `kPathScaleInterpNone`  | Path scale no interpolation     |
| `kPathScaleInterpLinear`| Path scale linear interpolation |

## Step Position
| Value        | Meaning   |
|--------------|-----------|
| `kStepFirst` | *Unknown* |
| `kStepLast`  | *Unknown* |
| `kStepAny`   | *Unknown* |

## Tile Position
| Value          | Meaning   |
|----------------|-----------|
| `kTileCurrent` | *Unknown* |
| `kTilePrev`    | *Unknown* |
| `kTileNext`    | *Unknown* |

## Sample Mode
| Value            | Meaning |
|------------------|---------|
| `kSampleOneOff`  | One-off |
| `kSampleDynamic` | Dynamic |