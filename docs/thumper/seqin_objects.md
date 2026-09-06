# Sequencer Objects
A Sequencer Object (or TraitLine Object) is an object edited on a single track of the sequencer in [Drool's Editor](drools_editor.md). Sequencer Objects usually represent certain parameters of some other objects being modulated or turned on/off over time. They contain one or more data points, representing how the values of those parameters change over time. Sequencer Objects are almost ubiquitous and can reside in many different kinds of main objects, such as [.lvl Objects](lvl.md) and [.leaf Objects](leaf.md).

## Format

### Header
| Length   | Data Type                        | Meaning                                                  |
| -------- | -------------------------------- | -------------------------------------------------------- |
| variable | [string](data_types.md#string) | Name of the main object where the parameter can be found |
| 4        | [int32](data_types.md#int32)   | Number of sub-levels under the main object to get to the specific sub-object/parameter. In general, if this number is `1`, the parameter belongs directly to the main object; otherwise the parameter belongs to one of the sub-objects. |

### For each sub-level:
| Length | Data Type                      | Meaning                                                                        |
| ------ | ------------------------------ | ------------------------------------------------------------------------------ |
| 4      | N/A                            | The ["magic number"](magic_numbers.md) identifying which sub-object or parameter is to be selected |
| 4      | [int32](data_types.md#int32) | If mutiple sub-objects share the same ["magic number"](magic_numbers.md), this number \\(n\\) selects the \\(n\\)th sub-object, using zero-based numbering. If the ["magic number"](magic_numbers.md) can uniquely identify a sub-object or parameter, this number is set to `-1`. |

### After the sub-levels:
| Length | Data Type                      | Meaning |
| ------ | ------------------------------ | ------- |
| 4      | [int32](data_types.md#int32) | The index identifying the data type of the values in the data points. See [Trait Type Trait](trait_values.md#trait-type) for a list of allowed values. The data type depends on the parameter being modulated. |

### Data Points
| Length | Data Type                      | Meaning                     |
| ------ | ------------------------------ | --------------------------- |
| 4      | [int32](data_types.md#int32) | Total number of data points |

### For each data point:
| Length   | Data Type                                                       | Meaning                                       |
| -------- | --------------------------------------------------------------- | --------------------------------------------- |
| variable | any of the [Data Point Types](data_types.md#data-point-types) | The value of the parameter at a specific time |

The data type is defined in the header. All data points in the same Sequencer Object have the same data type.

### After the data points:
| Length | Data Type                          | Meaning |
| ------ | ---------------------------------- | ------- |
| 4      | [int32](data_types.md#int32)     | Total number of displayed UI elements for data points on [Drool's Editor](./drools_editor.md). These are typically intervals represented by pairs of starting points and ending points. Each interval has a displayed value that is being applied over the entire interval. The displayed value should be equal to the sum of all values from the data points above that are within the interval. Typical examples are the pitch and turn parameters in a [.leaf Object](leaf.md). The displayed values in these UI elements do not affect the actual data point values above. If this number is `0`, the data points above are displayed "as is" (no special handling for display is required). |

### For each interval:
| Length   | Data Type                                                         | Meaning |
| -------- | ----------------------------------------------------------------- | ------- |
| variable | any of the [Data Point Types](data_types.md#data-point-types) | The starting point of an interval. This contains the value of the parameter displayed on [Drool's Editor](drools_editor.md) starting from a specific time. |
| variable | any of the [Data Point Types](data_types.md#data-point-types) | The ending point of an interval. Only the time is important; the value is meaningless.

All UI elements have the same data type as the data points.

### Footer
| Length   | Data Type | Meaning                                                                                   |
| -------- | --------- | ----------------------------------------------------------------------------------------- |
| 4        | int32     | *Unknown*                                                                                 |
| 4        | int32     | *Unknown*                                                                                 |
| 4        | int32     | *Unknown*                                                                                 |
| 4        | int32     | *Unknown*                                                                                 |
| 4        | int32     | *Unknown*                                                                                 |
| variable | string    | *Unknown*. See [Intensity Trait](trait_values.md#intensity) for a list of allowed values. |
| variable | string    | *Unknown*. See [Intensity Trait](trait_values.md#intensity) for a list of allowed values. |
| 1        | bool      | *Unknown*                                                                                 |
| 1        | bool      | *Unknown*                                                                                 |
| 4        | int32     | *Unknown*                                                                                 |
| 4        | float32   | *Unknown*                                                                                 |
| 4        | float32   | *Unknown*                                                                                 |
| 4        | float32   | *Unknown*                                                                                 |
| 4        | float32   | *Unknown*                                                                                 |
| 4        | float32   | *Unknown*                                                                                 |
| 1        | bool      | *Unknown*                                                                                 |
| 1        | bool      | *Unknown*                                                                                 |
| 1        | bool      | *Unknown*                                                                                 |