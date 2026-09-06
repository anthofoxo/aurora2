
local Reader = Aurora.extension("reader")

local libraryTypeLookup = {
    [Aurora.fnv1a("LevelLib")] = "LevelLib",
    [Aurora.fnv1a("GfxLib")] = "GfxLib",
    [Aurora.fnv1a("AvatarLib")] = "AvatarLib",
    [Aurora.fnv1a("SequinLib")] = "SequinLib",
    [Aurora.fnv1a("ObjLib")] = "ObjLib",
}

local function readLevelObjLib(reader)
    local value = {}
    value.filetype = reader:u32()
    assert(value.filetype == 8)
    value.libraryType = reader:u32()
    assert(value.libraryType == Aurora.fnv1a("LevelLib"))

    -- unknown header fields, version control values maybe????
    reader:u32()
    reader:u32()
    reader:u32()
    reader:u32()

    local importCount = reader:u32()

    value.imports = {}

    for i = 1, importCount do
        table.insert(value.imports, {
            unknownField = reader:u32(),
            path = reader:sstr(),
        })
    end

    value.origin = reader:sstr()

    value.localobjcount = reader:u32()

    return value
end

local levelcontent

local message

--local data = Aurora.unzip("Legacy_Eight.zip")
--print("elements: " .. #data)

--[[for index, value in ipairs(data) do
    if value.error then
        print("Error in " .. value.name .. value.error)
    end
    if value.warn then
        print("Warning in " .. value.name .. value.warn)
    end
end
]]

return {
    update = function()
        if (ImGui.Begin("Unzip Test")) then
        local edited;
        target, edited = ImGui.InputText("Label", target)

        if edited then
            update_path(target)
        end

        ImGui.TextUnformatted(string.format("Target: %s (%x.pc)", target, targethash))
        ImGui.TextUnformatted("Target Path: " .. path)
        if ImGui.Button("Perform Decomp") then
            local pcdata = Aurora.load_binary(path)
            local reader = Reader.new(pcdata)
            levelcontent = readLevelObjLib(reader)
        end

        if levelcontent ~= nil then
            ImGui.SeparatorText("PC Import Info")

            ImGui.Separator()

            ImGui.TextUnformatted("File type:" .. levelcontent.filetype)
            ImGui.TextUnformatted("Objlib type:" .. string.format("%x (%s)", levelcontent.libraryType, libraryTypeLookup[levelcontent.libraryType]))
            ImGui.TextUnformatted("Import count: " .. #levelcontent.imports)

            ImGui.SeparatorText("Imports")

            for _, value in ipairs(levelcontent.imports) do
                ImGui.TextUnformatted("path: " .. value.path)
            end

            ImGui.TextUnformatted("Origin: " .. levelcontent.origin)
            ImGui.TextUnformatted(levelcontent.localobjcount)
        end
        
    end
    ImGui.End()
    end
}