# AUR_tcle_localization

## Contact
* AnthoFoxo (@AnthoFoxo)

## Contributors
* AnthoFoxo

## Status
Draft

## Version
Last Modified Date: September 5, 2026
<br>
Revision 2

## Dependencies
Written based on the wording of the Aurora 0.3 specification.

## Overview
TML was written during a time where the localization system was not well understood and as a result TCLE was written with the same lack of awareness.

This resulted in non English players having the `SYM` text appear where you should see level names.

This extension resolves this by doing 2 things.

1. Specify how unresolved localization keys should handled if they don't exist.
2. Allow TCLE levels to specify localizations if the authors wish to do so.

## Additions to the Spec
All localization keys should be collected and iterated after target generation completes. For every non-English language that doesn't contain one of the collected keys. Copy the value from the English localization into the non-English localization.

## Additions to .TCL
Add optional field `localization` with the following optional keys:

* `da`
* `de`
* `en`
* `es-la`
* `fi`
* `fr-ca`
* `fr`
* `it`
* `ja`
* `ko`
* `nl`
* `no`
* `pl`
* `pt-br`
* `ru`
* `sv`
* `tr`
* `zh-s`
* `zh-t`

The values of these keys are the values to be used in the related localization tables.

* If `nil`. The value will be copied from the `en` key.
* If the key `en` is `nil`. It's value is copied from the `level_name` field.

## Errors
A mod is ill-formed if `localizations` is not a table while the extension is enabled.

## Usage Example
```lua
{
    extensions = {
        enabled = {
            "AUR_tcle_localization",
        }
    },
    localization = {
        en = "level",
        es = "nivel",
        ko = "수준",
    }
}
```

## Issues
1. How should unspecified localization pull default values. Should `en` always be the fallback?

RESOLVED: Yes. `en` is established as the baseline. And all localizations are easily accesible. Theres no reason to introduce complex dependency trees.

2. If the `en` localization field is `nil`. Should the level be considered ill-formed or should the level name be used as fallback.

RESOLVED: Fallback for the `en` key should copy from the `level_name` field. This provides better forward compatability with minimal effort.

## Revision History
### September 6 2026 (Revision 2)
- Specify fallback behavior for unspecified keys
### September 5 2026
- Initial draft