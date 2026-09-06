# Downpatching
Downpatching Thumper currently is not required. This guide is ported from an old google doc and is kept here in case we need to do this again in the future.

This guide will downpatch Thumper into a specific version and prevent steam from updating it.

Before starting you must own Thumper and have it up to date on steam. We will not provide Thumper binaries. Support the devs.

## Enable Stream Console
Search for `steam` in your start menu, right click the link that shows up and select `Open file location`. This will select the file in your file explorer.

Right click the selected file and select `Properties`. In the properties panel add ` -console` to the end of the `Target` field. The Target property should look along the lines of `SteamPath\Steam.exe -console`.

This only will modify the start menu link. Repeat the process for other Steam icons you use. When you restart Steam you will have a `CONSOLE` tab grouped with the `COMMUNITY` tab and your profile tab.

## Automatic Updates
To prevent Steam from automatically updating the game. Head into Thumper settings and configure Steam to `Only update this game when I launch it`. While this disables automatic updates, Steam will attempt to update the game on launch.

## .acf modification
We will modify the Steam `.acf` file for Thumper to not allow updates. Make sure Steam is shutdown and verify in Task Manager. The Thumper `acf` file is located in your Steam install path at `<SteamInstallPath>/steamapps/appmanifest_356400.acf`. `356400` is Thumper's Steam Game ID.

Open this file in any text editor. Inside this file make sure `StateFlags` is set to `4`. This is likely already the case. Save changes if needed.

## .acf Read-Only
Right click the `.acf` file and change it to be `Read-Only`. This will prevent Steam from writing to this file.

## Downloading an Older Version
Now that Steam cannot update the game, we can download a specific version. Click the new `CONSOLE` tab, run the following command `download_depot 356400 356401 3825907120909601454`.

* `356400` is Thumper's Steam Game ID
* `356401` is the depot ID, Thumper only uses one.
* `3825907120909601454` is the manifest ID, This targets the `26 May 2020` build.

This will download the game files into `<SteamInstallPath>/steamapps/content/app_356400/depot_356401`. This will contain the content of the downpatched version.

## Backup
Backup your current Thumper files. The next step involves overwritting Thumper data.

## Replace Game Build
Erase the contents of the Thumper game directory and copy or move the contents of the newly downloaded into it.

## Skip Updates
If the game is updated, you can run `@AllowSkipGameUpdate 1` in the `CONSOLE` tab to skip the update to prevent steam from replacing the game content.

## Run from URL
The game can be launched with the Run prompt `Win+R` with `steam://run/356400`. This may not be nessesary but should prevent Steam from trying to update the game.