# Other Dicts

This page contains misc information from the tiddlyhost.

## DefaultGroupDict
```
start://Start of the default group section?//
default-group://Default group?//
```

### DrawCompDict
```
start:Start of the draw definition section
first://Unknown//
visible:Visible
layer:Draw layer. See [[Layer Trait]] for a list of allowed values.
bucket:Render bucket. See [[Bucket Trait]] for a list of allowed values.
draw-children-count:Number of draw children
draw-child-name:Draw child name
```

## gateBossDict
```
name-hash:[[Gate Level Script Node|Gate Level Script Nodes]] name hash
lvl:Boss pattern [[.lvl|.lvl Objects]] object name
bool://Unknown//
sentry:Gate sentry type. See [[Gate Sentry Trait]] for a list of allowed values.
hash://Unknown//
int32:Bucket number
```

## gateObjectDict
```
spn:[[.spn|.spn Objects]] object name
pattern-count:Number of boss patterns
pre-boss-lvl:Pre-boss .lvl object name
post-boss-lvl:Post-boss .lvl object name
restart-lvl:Restart .lvl object name
int32://Unknown//
section-type:Section type. See [[Section Type Trait]] for a list of allowed values.
float32://Unknown//
level-random-type:Level random type. See [[Level Random Type Trait]] for a list of allowed values.
```

## leafObjectDict
```
version:Version number of ~SequinLeaf (.leaf Object)
beat-count:Total number of beats in this .leaf Object
```

## leafTimeCompDict
```
start:Start of the ~AnimComp (animation component) section
int32:Version number of ~AnimComp (animation component)
float32:Frame
time-unit:Unit of time. See [[Time Trait]] for a list of allowed values.
```

## LevelLibDict
```
world-cam:World cam
handheld-cam:Handheld cam
portrait-cam:Portrait cam
avatar:Avatar
bpm:BPM
sequin-drawer:Sequin drawer
sequin-master:Sequin master
```

## lvlChildDict
```
header-first://Unknown//
header-move-phase://Unknown//. See [[Move Phase Trait]] for a list of allowed values.
header-last://Unknown//
start:Start of a new [[.leaf Object|.leaf Objects]]
int32-1://Unknown//
beat-count:Total number of beats in this [[.leaf Object|.leaf Objects]]
bool-2://Unknown//
leaf:Name of the [[.leaf Object|.leaf Objects]]
path://Unknown .path object name//
sub-path-count://Unknown//
sub-path://Unknown .path object name//
sub-path-last://Unknown//
step://Unknown//. See [[Step Trait]] for a list of allowed values.
int32-2:Offset between the current and previous [[.leaf Objects]]
pos://Position?//
rot-x://Rotation x?//
rot-y://Rotation y?//
rot-z://Rotation z?//
scale://Scale?//
end:End of .leaf sequence
```

## lvlObjectDict
```
footer-bool-1://Unknown//
footer-volume:Volume
footer-int32-1://Unknown//
footer-int32-2://Unknown//
footer-trait-type:Trait type. See [[Trait Type Trait]] for a list of allowed values.
footer-input-allowed:Input allowed
footer-tutorial-type:Tutorial type. See [[Tutorial Type Trait]] for a list of allowed values.
footer-start-angle-fracs:Start angle fracs
```

## lvlSampleDict
```
sample:Sample object name
beat-count:Number of beats per loop
last://Unknown//
```

## lvlTimeCompDict
```
start:Start of the approach animation definition section
int32://Unknown//
float32://Unknown//
time-unit:Unit of time. See [[Time Trait]] for a list of allowed values.
int32-2://Unknown//
int32-3:Approach beats
```

## masterGroupingDict
```
lvl:[[.lvl|.lvl Objects]] object name
gate:[[.gate|.gate Objects]] object name
checkpoint:Checkpoint
checkpoint-leader-lvl:Checkpoint leader [[.lvl|.lvl Objects]] object name
rest-lvl:Rest [[.lvl|.lvl Objects]] object name
play-plus:PLAY +
```

## masterObjectDict
```
first://Unknown//
second://Unknown//
skybox:Skybox object name
intro-lvl:Intro [[.lvl|.lvl Objects]] object name
grouping-count:Number of groupings of [[.lvl|.lvl Objects]]/[[.gate|.gate Objects]] Objects
footer-bool-1://Unknown//
footer-bool-2://Unknown//
footer-int32-1://Unknown//
footer-int32-2://Unknown//
footer-int32-3://Unknown//
footer-int32-4://Unknown//
footer-float32-1://Unknown//
footer-float32-2://Unknown//
footer-float32-3://Unknown//
checkpoint-lvl:Checkpoint .lvl object name
path-gameplay://Unknown//
```

## matObjectDict
```
decal-map://Decal map?//
emissive-map://Emissive map?//
specular-map://Specular map?//
reflectivity-map://Reflectivity map?//
reflection-map://Reflection map?//
emissive-color://Emissive color?//
ambient-color://Ambient color?//
diffuse-color://Diffuse color?//
specular-color://Specular color?//
reflectivity-color://Reflectivity color?//
tex-pos://Texture pos?//
tex-scale://Texture scale?//
tex-rot://Texture rot?//
alpha://Alpha?//
blending:Blending. See [[Blend Trait]] for a list of allowed values.
cull-mode:Cull mode. See [[Cull Mode Trait]] for a list of allowed values.
z-mode:Z mode. See [[Z Mode Trait]] for a list of allowed values.
stencil-channel:Stencil channel. See [[Stencil Channel Trait]] for a list of allowed values.
mat-filtering:Material filtering. See [[Material Filtering Trait]] for a list of allowed values.
mat-lighting:Material lighting. See [[Material Lighting Trait]] for a list of allowed values.
tex-xfm-mode:Texture transform mode. See [[Texture Transform Mode Trait]] for a list of allowed values.
alpha-temp:|[[float32]] |`52a06bf4` |alpha |Controls the opacity of the tunnel or lattice around the track. The allowed values for alpha $$a$$ are: $$\{a∈\mathbb {R}\ |\ 0\leq a \leq 1\}$$.  |
```

## playspaceObjectDict
```
world-scale:World scale
eye-distance-scale:Eye distance scale
near-x-min:Near x min
near-x-max:Near x max
near-y-min:Near y min
near-y-max:Near y max
near-z-min:Near z min
near-z-max:Near z max
near-recenter-secs:Near recenter secs
far-x-min:Far x min
far-x-max:Far x max
far-y-min:Far y min
far-y-max:Far y max
far-z-min:Far z min
far-z-max:Far z max
far-recenter-secs:Far recenter secs
recenter-max-velocity:Recenter max velocity
```

## sampObjectDict
```
mode:Sample play mode. See [[Sample Mode Trait]] for a list of allowed values.
int32-1://Unknown//
path:Path
int32-2://Loop count?//
stream://Stream?//
volume:Volume
pitch:Pitch
pan:Pan
offset:Offset (ms)
channel-group:Channel group
```

## SequencerObjectDict
```
version:Version number of ~TraitAnim (trait animation)
main-object:Name of the main object where the parameter can be found
sub-level-count:Number of sub-levels under the main object to get to the specific sub-object/parameter
sub-object:The [["magic number"|Object/Parameter Selectors]] identifying which sub-object is to be selected
parameter:The [["magic number"|Object/Parameter Selectors]] identifying which parameter is to be selected
sub-object-index-prefix:Selects the
sub-object-index-suffix:sub-object, using zero-based numbering
header-last:The index identifying the data type of the values in the data points. See [[Trait Type Trait]] for a list of allowed values.
data-point-count:Total number of data points
editor-data-point-count:Total number of displayed UI elements for data points on [[Drool's Editor|What We Know about Drool's Editor]]
footer-1://Unknown//
footer-2://Unknown//
footer-3://Unknown//
footer-4://Unknown//
footer-5://Unknown//
footer-6://Unknown//. See [[Intensity Trait]] for a list of allowed values.
footer-7://Unknown//. See [[Intensity Trait]] for a list of allowed values.
footer-8://Unknown//
footer-9://Unknown//
footer-10://Unknown//
footer-11://Unknown//
footer-12://Unknown//
footer-13://Unknown//
footer-14://Unknown//
footer-15://Unknown//
footer-16://Unknown//
footer-17://Unknown//
footer-18://Unknown//
```

## ObjectDict
```
int32-0://Unknown//
int32-1://Unknown//
int32-2://Unknown//
version:Version number of Obj
section-count:Number of section markers
main-start:Start of the ~EditStateComp (edit state component) section
```

## envObjectDict
```
ambient-color:Ambient color
light-count:Number of lights
light-name:Name of light
fog-color:Fog color
fog-density:Fog density
```

## DataPointTemplate
| Length | Data Type | Meaning |
|-|-|-|
| 4	|float32|	At what time (in beats) this data point occurs.|
| variable	|variable|	The value this data point holds. The specific meaning of this value depends on the data type and the context.|
| variable|	string|	What interpolation method is applied on this data point with its neighboring data points. See Interpolation Trait for a list of allowed values.|
| variable |string|	What easing method is applied on this data point with its neighboring data points. See Easing Trait for a list of allowed values. |

## float32DataPoint
|Length|	Data Type	|Meaning|
|-|-|-|
|4	|float32|	At what time (in beats) this data point occurs. For float32DataPoint, the allowed values for time depend on the context.|
|4	|float32|	The floating-point value this data point holds. The specific meaning of this value depends on the context.|
|variable|	string|	What interpolation method is applied on this data point with its neighboring data points. See Interpolation Trait for a list of allowed values.|
|variable|	string|	What easing method is applied on this data point with its neighboring data points. See Easing Trait for a list of allowed values. |