# .cam Decomp

```
06 00 00 00    = header 1
04 00 00 00    = header 2
03 00 00 00    = header 3
12 FB 8E 3C    = hash, "EditStateComp"
EE 19 27 F9    = hash?
08 00 00 00    = 8, unknown
01             = bool, unknown
0E 00 00 00    = 14, length of next string
6B 4E 75 6D 44 72 61 77 4C 61 79 65 72 73     = "kNumDrawLayers"
0D 00 00 00    = 13, length of next string
6B 42 75 63 6B 65 74 50 61 72 65 6E 74     = "kBucketParent"
00 00 00 00    = unknown
EB 61 E7 84    = hash?
01 00 00 00    = 1, unknown
18 00 00 00    = 24, length of next string
61 76 61 74 61 72 5F 73 68 61 64 6F 77 5F 70 61 74 68 2E 78 66 6D 65 72      = "avatar_shadow_path.xfmer", possible binding object? The camera is bound to this?
11 00 00 00    = 17, length of next string
6B 43 6F 6E 73 74 72 61 69 6E 74 50 61 72 65 6E 74      = "kConstraintBucket", supports the previous string purpose?
00 08 8D 3A 00 00 A0 C1 00 00 20 41      = no idea :)
00 00 80 3F    = 1
00 00 00 00    = 0
00 00 00 80    = -0
00 00 00 80    = -0
00 00 80 3F    = 1
00 00 00 00    = 0
00 00 00 00    = 0        VECTOR 3
00 00 00 00    = 0
00 00 80 3F    = 1
00 00 80 3F    = 1
00 00 80 3F    = 1
00 00 80 3F    = 1

00 00 80 3F    = 1
00 00 80 3F    = 1
39 46 71 3F    = likely a float, 0.942477762699127
00 00 80 40    = 4
00 20 4B 46    = float, 13000
```

```
====!!!! UNSURE IF RELATED TO CAM !!!!====
22 00 00 00    = 34, unknown
21 00 00 00    = 33, unknown
04 00 00 00    = 4, unknown
02 00 00 00    = 2, unknown
0A 9F 25 63    = possibly a float? 3.05517274436387E21
01 00 00 00    = 1, unknown
80 C4 7F 41    = possibly a float? 15.9854736328125
```