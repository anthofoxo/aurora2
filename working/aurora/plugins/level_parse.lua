local Reader = Aurora.extension("reader")
local hashtable = Aurora.extension("hashtable")
dofile("structs.lua")



local function perform_decomp()
    local function read_aui_thumper_levels(file)
        local path = string.format("C:/Program Files (x86)/Steam/steamapps/common/Thumper/cache/%x.pc", Aurora.fnv1a(file))
        local pcdata = Aurora.load_binary(path)
        local reader = injectReaderThumperStructs(Reader.new(pcdata))

        reader:u32() -- filetype == 0x10
        return reader["LevelListingStruct_List"](reader)
    end

    local function read_aui_strings_loc(file)
        local path = string.format("C:/Program Files (x86)/Steam/steamapps/common/Thumper/cache/%x.pc", Aurora.fnv1a(file))
        local pcdata = Aurora.load_binary(path)
        local reader = injectReaderThumperStructs(Reader.new(pcdata))

        return reader["LocalizationStruct"](reader)
    end

    local locFiles = {
        "Aui/strings.da.loc",
        "Aui/strings.de.loc",
        "Aui/strings.en.loc",
        "Aui/strings.es-la.loc",
        "Aui/strings.fi.loc",
        "Aui/strings.fr-ca.loc",
        "Aui/strings.fr.loc",
        "Aui/strings.it.loc",
        "Aui/strings.ja.loc",
        "Aui/strings.ko.loc",
        "Aui/strings.nl.loc",
        "Aui/strings.no.loc",
        "Aui/strings.pl.loc",
        "Aui/strings.pt-br.loc",
        "Aui/strings.ru.loc",
        "Aui/strings.sv.loc",
        "Aui/strings.tr.loc",
        "Aui/strings.zh-s.loc",
        "Aui/strings.zh-t.loc",
    }

    for _, locFile in ipairs(locFiles) do
        local parsed = read_aui_strings_loc(locFile)
        local generatedPath = string.format("mods/thumper/_Localization/%s.lua", locFile:sub(2))
        Aurora.write_binary(generatedPath, "return " .. Aurora.serialize(parsed))
    end

    pcall(function()
        local filename = "Aui/thumper.levels"
        local parsed = read_aui_thumper_levels(filename)
        local generatedPath = string.format("mods/thumper/_Levels/%s.lua", filename:sub(2))
        Aurora.write_binary(generatedPath, "return " .. Aurora.serialize(parsed))
    end)

    local creditFiles = {
        "Aui/thumper.da.credits",
        "Aui/thumper.de.credits",
        "Aui/thumper.en.credits",
        "Aui/thumper.es-la.credits",
        "Aui/thumper.fi.credits",
        "Aui/thumper.fr-ca.credits",
        "Aui/thumper.fr.credits",
        "Aui/thumper.it.credits",
        "Aui/thumper.ja.credits",
        "Aui/thumper.ko.credits",
        "Aui/thumper.nl.credits",
        "Aui/thumper.no.credits",
        "Aui/thumper.pl.credits",
        "Aui/thumper.pt-br.credits",
        "Aui/thumper.ru.credits",
        "Aui/thumper.sv.credits",
        "Aui/thumper.tr.credits",
        "Aui/thumper.zh-s.credits",
        "Aui/thumper.zh-t.credits",
    }

    local locFiles = {
        "Aui/strings.da.loc",
        "Aui/strings.de.loc",
        "Aui/strings.en.loc",
        "Aui/strings.es-la.loc",
        "Aui/strings.fi.loc",
        "Aui/strings.fr-ca.loc",
        "Aui/strings.fr.loc",
        "Aui/strings.it.loc",
        "Aui/strings.ja.loc",
        "Aui/strings.ko.loc",
        "Aui/strings.nl.loc",
        "Aui/strings.no.loc",
        "Aui/strings.pl.loc",
        "Aui/strings.pt-br.loc",
        "Aui/strings.ru.loc",
        "Aui/strings.sv.loc",
        "Aui/strings.tr.loc",
        "Aui/strings.zh-s.loc",
        "Aui/strings.zh-t.loc",
    }

    -- "Aui/thumper.scoring",

    local function read_aui_thumper_credits(file)
        local path = string.format("C:/Program Files (x86)/Steam/steamapps/common/Thumper/cache/%x.pc", Aurora.fnv1a(file))
        local pcdata = Aurora.load_binary(path)
        local reader = injectReaderThumperStructs(Reader.new(pcdata))
        return reader["CreditsStruct"](reader)
    end

    for _, creditFile in ipairs(creditFiles) do
        local parsed = read_aui_thumper_credits(creditFile)
        local generatedPath = string.format("mods/thumper/_Credits/%s.lua", creditFile:sub(2))
        Aurora.write_binary(generatedPath, "return " .. Aurora.serialize(parsed))
    end
end

return {
    update = function()
        if ImGui.Button("Decompile") then
            perform_decomp()
        end
    end

}