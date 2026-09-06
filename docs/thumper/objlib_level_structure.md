# Structure of Level .objlib Files
Level .objlib files are some of the largest .objlib files, each containing hundreds of objects. The purpose of this type of .objlib files is to define what visual and audio elements appear in an entire level, and at what time these elements appear.

## File Format
See [General Structure of .objlib Files](objlib_gen_structure.md).

## Object Hierarchy
The majority of objects in a level .objlib file are used to sequence the things and events happening in a level. These objects follow the hierarchical structure in the below.

* [.master Object](master.md) are at the top of the hierarchy. They contain [.lvl Objects](lvl.md) and/or [.gate Objects](gate.md).
* [.gate Objects](gate.md) contain [.lvl Objects](lvl.md).
* [.lvl Objects](lvl.md) contain [.leaf Objects](leaf.md).