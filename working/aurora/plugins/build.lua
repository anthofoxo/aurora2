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

local function build()
    local level_listing = dofile("mods/thumper/_Levels/ui/thumper.levels.lua")
    local localization = load_localization()

    for _, file in ipairs(listed_files) do
        local unzipped = Aurora.unzip("mods/" .. file)
        local name
        local author
        local objlibdata
        local secdata

        for _, value in pairs(unzipped) do
            if value.name:match(".TCL$") and type(value.content) == "table" then
                name = value.content.level_name
                author = value.content.author
            elseif value.name:match(".objlib$") and type(value.content) == "string" then
                objlibdata = value.content
            elseif value.name:match(".sec$") and type(value.content) == "string" then
                secdata = value.content
            end
        end

        if name == nil then error("Invalid metadata name: " .. file) end
        if author == nil then error("Invalid metadata author: " .. file) end
        if objlibdata == nil then error("Invalid objlibdata: " .. file) end
        if secdata == nil then error("Invalid secdata: " .. file) end

        for _, value in pairs(unzipped) do
            if value.name:match(".pc$") and type(value.content) == "string" then
                Aurora.write_binary("build/" .. value.name, value.content)
            end
        end

        -- thumper is seen to have mismatching cases for levellib names, its somewhat implied tolower is applied or a manual error occured during the thumper build process
        -- to mimick this behavior, we will assume a lowercase conversion happens, the level objlib itself will use the unmodified path name
        local objlibTarget = string.lower("levels/custom/" .. author .. "/" .. name .. ".objlib")
        local objlibFile = string.format("%x.pc", Aurora.fnv1a("A" .. objlibTarget))

        local secTarget = string.lower("levels/custom/" .. author .. "/".. name .. ".sec")
        local secFile = string.format("%x.pc", Aurora.fnv1a("A" .. secTarget))

        Aurora.write_binary("build/" .. objlibFile, objlibdata)
        Aurora.write_binary("build/" .. secFile, secdata)

        local levelKey = "custom." .. string.lower(author .. "." .. name)

        -- apply localization to each lang
        for _, value in pairs(localization) do
            table.insert(value.keys, {
                key = levelKey,
                value = name,
            })
        end

        -- insert at end of level listing
        table.insert(level_listing.entries, {
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
    end
    
    for filename, value in pairs(localization) do
        local writer = Writer.new()

        writer["LocalizationStruct"] = function(writer, value)
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
        Aurora.write_binary(string.format("build/%x.pc", Aurora.fnv1a("A" .. filename)), writer:finish())
    end

    local writer = Writer.new()
    writer["LevelListingStruct_Entry"] = function(writer, value) write_structure(writer, LevelListingStruct_Entry, value) end
    writer["LevelListingStruct_List"] = function(writer, value) write_structure(writer, LevelListingStruct_List, value) end
    writer:u32(0x10)
    writer["LevelListingStruct_List"](writer, level_listing)
    Aurora.write_binary(string.format("build/%x.pc", Aurora.fnv1a("Aui/thumper.levels")), writer:finish())
end


local function update()
    if (ImGui.Begin("Build")) then
        for _, file in ipairs(listed_files) do
            ImGui.TextUnformatted(file)
        end
    
        if ImGui.Button("Build All") then
            build()
        end
    end
    ImGui.End()
end

return {
    update = update
}