---@module "aurora"

local Reader = Aurora.extension("reader")
local Writer = Aurora.extension("writer")
local hashtable = Aurora.extension("hashtable")
dofile("structs.lua")

local listed_files = Aurora.list_files("mods")

for i = #listed_files, 1, -1 do
    if not listed_files[i]:match(".zip$") then
        table.remove(listed_files, i)
    end
end

local function load_localization()
    local locFiles = {
        "ui/strings.da.loc",
        "ui/strings.de.loc",
        "ui/strings.en.loc",
        "ui/strings.es-la.loc",
        "ui/strings.fi.loc",
        "ui/strings.fr-ca.loc",
        "ui/strings.fr.loc",
        "ui/strings.it.loc",
        "ui/strings.ja.loc",
        "ui/strings.ko.loc",
        "ui/strings.nl.loc",
        "ui/strings.no.loc",
        "ui/strings.pl.loc",
        "ui/strings.pt-br.loc",
        "ui/strings.ru.loc",
        "ui/strings.sv.loc",
        "ui/strings.tr.loc",
        "ui/strings.zh-s.loc",
        "ui/strings.zh-t.loc",
    }

    local locs = {}

    for _, loc in ipairs(locFiles) do
        locs[loc] = dofile("mods/thumper/_Localization/" .. loc .. ".lua")
    end

    return locs

end

local function build_content(file)
    local unzipped = Aurora.unzip("mods/" .. file)

    local name
    local author
    local objlibdata
    local secdata

    for _, value in pairs(unzipped) do
        if value.name:match(".TCL$") and type(value.content) == "table" then
           name = value.content.level_name
           author = value.content.author
        end

        if value.name:match(".objlib$") and type(value.content) == "string" then
           objlibdata = value.content
        end

        if value.name:match(".sec$") and type(value.content) == "string" then
           secdata = value.content
        end
    end

    if name == nil then error("Invalid metadata name: " .. file) end
    if author == nil then error("Invalid metadata author: " .. file) end
    if objlibdata == nil then error("Invalid objlibdata: " .. file) end
    if secdata == nil then error("Invalid secdata: " .. file) end

    
    -- thumper is seen to have mismatching cases for levellib names, its somewhat implied tolower is applied or a manual error occured during the thumper build process
    -- to mimick this behavior, we will assume a lowercase conversion happens, the level objlib itself will use the unmodified path name
    local objlibTarget = string.lower("levels/custom/" .. author .. "/" .. name .. ".objlib")
    local objlibFile = string.format("%x.pc", Aurora.fnv1a("A" .. objlibTarget))

    local secTarget = string.lower("levels/custom/" .. author .. "/".. name .. ".sec")
    local secFile = string.format("%x.pc", Aurora.fnv1a("A" .. secTarget))

    Aurora.write_binary("build/" .. objlibFile, objlibdata)
    Aurora.write_binary("build/" .. secFile, secdata)

    local vanillaLevelListing = dofile("mods/thumper/_Levels/ui/thumper.levels.lua")

    local levelKey = "custom." .. string.lower(author .. "." .. name)

    local locs = load_localization()

    -- apply localization to each lang
    for _, value in pairs(locs) do
        table.insert(value.keys, {
            key = levelKey,
            value = name,
        })
    end

    table.insert(vanillaLevelListing.entries, {
        unknown1 = 0,
        triggersCredits = false,
        unknown2 = true,
        unlocks = "",
        colorIndexes = {
        0,
        10
        },
        defaultLocked = false,
        key = levelKey,
        path = objlibTarget,
    })
    

    
local LevelListingStruct_List = [=[
LevelListingStruct_Entry entries[]
]=]

local LevelListingStruct_Entry = [=[
sstr key
u32 _
sstr path
sstr unlocks
bool defaultLocked
bool _
bool triggersCredits
u32 colorIndexes[2]
]=]

    local writer = Writer.new()

    writer["LevelListingStruct_Entry"] = function(writer, value)
        write_structure(writer, LevelListingStruct_Entry, value)
    end
    writer["LevelListingStruct_List"] = function(writer, value)
        write_structure(writer, LevelListingStruct_List, value)
    end

    

    
    for filename, value in pairs(locs) do

        local writer = Writer.new()

        writer["LocalizationStruct"] = function(writer, value)
        --[[
-- REFERENCE STRUCT --
u32 filetype
@noimport u32 numKeys
@noimport u32 numBytes
cstr strings[numKeys]
{
    u32 key
    u32 byteOffset
} values[numKeys]
]]--

        local byteCount = 0
        for _, iKey in ipairs(value.keys) do
            byteCount = byteCount + #iKey.value + 1
        end

        writer:u32(value.filetype)
        writer:u32(#value.keys)
        writer:u32(byteCount)

        for _, iKey in ipairs(value.keys) do
            writer:cstr(iKey.value)
        end

        local byteOffset = 0

        for _, iKey in ipairs(value.keys) do
            if type(iKey.key) == "string" then
                writer:u32(Aurora.fnv1a(iKey.key))
            else
                writer:u32(iKey.key)
            end

            writer:u32(byteOffset)
            byteOffset = byteOffset + #iKey.value + 1
        end
    

        end

        writer["LocalizationStruct"](writer, value)
        local binary = writer:finish()
        Aurora.write_binary(string.format("build/%x.pc", Aurora.fnv1a("A" .. filename)), binary)

        --todo write file
    end

    writer:u32(0x10)
    writer["LevelListingStruct_List"](writer, vanillaLevelListing)
    local data = writer:finish()
    Aurora.write_binary(string.format("build/%x.pc", Aurora.fnv1a("Aui/thumper.levels")), data)

end

local function update()
    if (ImGui.Begin("Build")) then

        ImGui.SeparatorText("Mods")
        for _, file in ipairs(listed_files) do
            if ImGui.Button(file) then
                build_content(file)
            end
        end

    end
    ImGui.End()
end

return {
    update = update
}