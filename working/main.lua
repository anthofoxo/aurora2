---@module "aurora"

local Reader = Aurora.extension("reader.lua")

local input = "Alevels/demo.objlib"
local output = ""

local libraryTypeLookup = {
    [Aurora.fnv1a("LevelLib")] = "LevelLib",
    [Aurora.fnv1a("GfxLib")] = "GfxLib",
    [Aurora.fnv1a("AvatarLib")] = "AvatarLib",
    [Aurora.fnv1a("SequinLib")] = "SequinLib",
    [Aurora.fnv1a("ObjLib")] = "ObjLib",
}

local declarationTypeLookup = {
    [Aurora.fnv1a("SequinMaster")] = "SequinMaster",
    [Aurora.fnv1a("SequinLevel")] = "SequinLevel",
    [Aurora.fnv1a("SequinGate")] = "SequinGate",
    [Aurora.fnv1a("SequinLeaf")] = "SequinLeaf",
    [Aurora.fnv1a("EntitySpawner")] = "EntitySpawner",
    [Aurora.fnv1a("SequinDrawer")] = "SequinDrawer",
    [Aurora.fnv1a("Sample")] = "Sample",
    [Aurora.fnv1a("Path")] = "Path",
    [Aurora.fnv1a("Mesh")] = "Mesh",
    [Aurora.fnv1a("Flow")] = "Flow",
    [Aurora.fnv1a("Mat")] = "Mat",
    [Aurora.fnv1a("DSP")] = "DSP",
    [Aurora.fnv1a("Xfmer")] = "Xfmer",
    [Aurora.fnv1a("Tex2D")] = "Tex2D",
    [Aurora.fnv1a("Env")] = "Env",
    [Aurora.fnv1a("ChannelGroup")] = "ChannelGroup",
    [Aurora.fnv1a("PathDecorator")] = "PathDecorator",
    [Aurora.fnv1a("TraitAnim")] = "TraitAnim",
    [Aurora.fnv1a("Bender")] = "Bender",
    [Aurora.fnv1a("SequinPulse")] = "SequinPulse",
    [Aurora.fnv1a("Cam")] = "Cam",
    [Aurora.fnv1a("Scene")] = "Scene",
    [Aurora.fnv1a("VrSettings")] = "VrSettings",
    [Aurora.fnv1a("DSPChain")] = "DSPChain",
    [Aurora.fnv1a("Vibration")] = "Vibration",
    [Aurora.fnv1a("PostProcessPass")] = "PostProcessPass",
    [Aurora.fnv1a("DrawGroup")] = "DrawGroup",
    [Aurora.fnv1a("UICanvas")] = "UICanvas",
    [Aurora.fnv1a("Entity")] = "Entity",
    [Aurora.fnv1a("EntityAnim")] = "EntityAnim",
    [Aurora.fnv1a("GameSettings")] = "GameSettings",
    [Aurora.fnv1a("EntityVar")] = "EntityVar",
    [Aurora.fnv1a("TraitFilter")] = "TraitFilter",
    [Aurora.fnv1a("Steering")] = "Steering",
    [Aurora.fnv1a("Status")] = "Status",
    [Aurora.fnv1a("Light")] = "Light",
    [Aurora.fnv1a("TraitBinding")] = "TraitBinding",
    [Aurora.fnv1a("XfmFilter")] = "XfmFilter",
    [Aurora.fnv1a("PathCondition")] = "PathCondition",
    [Aurora.fnv1a("PathGameplay")] = "PathGameplay",
    [Aurora.fnv1a("Mastering")] = "Mastering",
    [Aurora.fnv1a("PostProcess")] = "PostProcess",
}

local function append(...)
    output = output .. string.format(...) .. '\n'
end

local function parseStructure(reader, struct)
    local value = {}
    local unknown = 0

    for line in struct:gmatch("[^\n]+") do
        local type, name = line:match("^%s*(%S+)%s+(%S+)%s*$")

        if type and name then
            local v = reader[type](reader)

            if name == "_" then
                unknown = unknown + 1
                name = "unknown" .. unknown
            end

            value[name] = v
        end
    end

    return value
end

local function XfmCompStruct()
return

end

local compTypes = {
    [Aurora.fnv1a("EditStateComp")] = function(reader)
        return {
            type = "EditStateComp"
        }
    end,
    [Aurora.fnv1a("XfmComp")] = function(reader)
        local struct =
        [=[
        u32 _
        sstr name
        sstr constraint
        transform transform
        ]=]

        local value = parseStructure(reader, struct)
        value.type = "XfmComp"
        return value
    end,
}

local function parse_complist(reader)
    local valuelist = {}

    for i = 1, reader:u32() do
        local type = reader:u32()
        local generator = compTypes[type]

        if generator then
            table.insert(valuelist, generator(reader))
        else
            error(string.format("unknown comp type %x", type))
        end
    end

    return valuelist
end

local function parse_sample(reader)
    local struct = [=[
    complist comps
    sstr mode
    u32 _
    sstr path
    u8 _
    u8 _
    u8 _
    u8 _
    u8 _
    f32 volume
    f32 pitch
    f32 pan
    f32 offset
    sstr channelGroup
    ]=]

    return parseStructure(reader, struct)
end

local function parse_EntitySpawner(reader)
    local struct = [=[
    complist comps
    u32 _
    sstr path
    sstr bucket
    ]=]

    return parseStructure(reader, struct)
end

local function compute()
    output = ""
    local path = string.format("C:/Program Files (x86)/Steam/steamapps/common/Thumper/cache/%x.pc", Aurora.fnv1a(input))
    local pcdata = Aurora.load_binary(path)
    append("Loaded %s", path)
    append("Loaded %d bytes", #pcdata)

    local reader = Reader.new(pcdata)

    -- hook special
    reader.complist = parse_complist

    assert(reader:u32() == 8) -- filetype
    assert(reader:u32() == Aurora.fnv1a("LevelLib"))

    -- ignore header values
    for i = 1, 4 do reader:u32() end

    append("Start offset 0x%x (validated previous bytes)", reader.position)

    append("%s", "--- Imports --- (unknown header values hidden)")
    for i = 1, reader:u32() do
        reader:u32()
        append("%s", reader:sstr())
    end

    append("Origin: %s", reader:sstr())

    local objectImports = {}

    for i = 1, reader:u32() do
        local value = {
            type = reader:u32(),
            name = reader:sstr(),
            unknown = reader:u32(),
            path = reader:sstr(),
        }

        append("%s : %s (%s)", value.name, value.path, libraryTypeLookup[value.type])

        table.insert(objectImports, value)
    end

    local objects = {}

    for i = 1, reader:u32() do
        local value = {
            type = reader:u32(),
            name = reader:sstr(),
        }

        append("%s (%s)", value.name, declarationTypeLookup[value.type])

        table.insert(objects, value)
    end

    append("Content Begin Offset: 0x%x", reader.position)

    append("Skipping object import definitions (incomplete)")
    
    for index, value in ipairs(objects) do
        local searchPattern

        if value.type == Aurora.fnv1a("Flow") then searchPattern = "\x16\x00\x00\x00\x04\x00\x00\x00" end
        if value.type == Aurora.fnv1a("SequinLeaf") then searchPattern = "\x22\x00\x00\x00\x21\x00\x00\x00\x04\x00\x00\x00" end
        if value.type == Aurora.fnv1a("SequinLevel") then searchPattern = "\x33\x00\x00\x00\x21\x00\x00\x00\x04\x00\x00\x00" end
        if value.type == Aurora.fnv1a("EntitySpawner") then searchPattern = "\x01\x00\x00\x00\x04\x00\x00\x00" end
        if value.type == Aurora.fnv1a("Mesh") then searchPattern = "\x0F\x00\x00\x00\x04\x00\x00\x00" end
        if value.type == Aurora.fnv1a("SequinGate") then searchPattern = "\x1A\x00\x00\x00\x04\x00\x00\x00" end
        if value.type == Aurora.fnv1a("TraitAnim") then searchPattern = "\x21\x00\x00\x00\x04\x00\x00\x00" end
        if value.type == Aurora.fnv1a("Sample") then searchPattern = "\x0C\x00\x00\x00\x04\x00\x00\x00" end
        if value.type == Aurora.fnv1a("Mat") then searchPattern = "\x21\x00\x00\x00\x04\x00\x00\x00" end
        if value.type == Aurora.fnv1a("Path") then searchPattern = "\x29\x00\x00\x00\x04\x00\x00\x00" end
        if value.type == Aurora.fnv1a("Tex2D") then searchPattern = "\x03\x00\x00\x00\x04\x00\x00\x00" end
        if value.type == Aurora.fnv1a("Env") then searchPattern = "\x09\x00\x00\x00\x04\x00\x00\x00" end
        if value.type == Aurora.fnv1a("SequinMaster") then searchPattern = "\x21\x00\x00\x00\x21\x00\x00\x00\x04\x00\x00\x00" end
        if value.type == Aurora.fnv1a("Cam") then searchPattern = "\x06\x00\x00\x00\x04\x00\x00\x00" end
        if value.type == Aurora.fnv1a("PathDecorator") then searchPattern = "\x25\x00\x00\x00\x04\x00\x00\x00" end
        if value.type == Aurora.fnv1a("Xfmer") then searchPattern = "\x04\x00\x00\x00\x04\x00\x00\x00" end
        if value.type == Aurora.fnv1a("SequinDrawer") then searchPattern = "\x07\x00\x00\x00\x04\x00\x00\x00" end

        local start_idx, end_idx

        if searchPattern then
            start_idx, end_idx = string.find(pcdata, searchPattern, reader.position, true)
            --error("unknown search pattern for type " .. declarationTypeLookup[value.type])
        end

        
        if start_idx then
            local skipped = start_idx -  reader.position
            reader.position = end_idx + 1
            append("0x%x in %s (skipped %x bytes)", start_idx, value.name, skipped)

            if value.type == Aurora.fnv1a("Sample") then
                local value2 = parse_sample(reader)
                local generatedPath = string.format("mods/thumper/levellib/%s/%s/%s.lua", string.gsub(input:sub(2), "%.%w+$", ""), declarationTypeLookup[value.type]:lower(), value.name)
                Aurora.write_binary(generatedPath, "return " .. Aurora.serialize(value2))
            end

            if value.type == Aurora.fnv1a("EntitySpawner") then
                local value2 = parse_EntitySpawner(reader)
                local generatedPath = string.format("mods/thumper/levellib/%s/%s/%s.lua", string.gsub(input:sub(2), "%.%w+$", ""), declarationTypeLookup[value.type]:lower(), value.name)
                Aurora.write_binary(generatedPath, "return " .. Aurora.serialize(value2))
            end

            
        else
            if value.type == Aurora.fnv1a("Flow") then error("fail") end
            if value.type == Aurora.fnv1a("SequinLeaf") then error("fail") end
            if value.type == Aurora.fnv1a("SequinLevel") then error("fail") end
            if value.type == Aurora.fnv1a("EntitySpawner") then error("fail") end
            if value.type == Aurora.fnv1a("Mesh") then error("fail") end
            if value.type == Aurora.fnv1a("SequinGate") then error("fail") end
            if value.type == Aurora.fnv1a("TraitAnim") then error("fail") end
            if value.type == Aurora.fnv1a("Sample") then error("fail") end
            if value.type == Aurora.fnv1a("Mat") then error("fail") end
            if value.type == Aurora.fnv1a("Path") then error("fail") end
            if value.type == Aurora.fnv1a("Tex2D") then error("fail") end
            if value.type == Aurora.fnv1a("Env") then error("fail") end
            if value.type == Aurora.fnv1a("SequinMaster") then error("fail") end
            if value.type == Aurora.fnv1a("Cam") then error("fail") end
            if value.type == Aurora.fnv1a("PathDecorator") then error("fail") end
            if value.type == Aurora.fnv1a("Xfmer") then error("fail") end
            if value.type == Aurora.fnv1a("SequinDrawer") then error("fail") end

            append("seq not found for %s", value.name)
        end


    end






    append("\n\nRead Head Position: 0x%x", reader.position)
end

function Update()
    if (ImGui.Begin("Unpacker")) then
        local edited;
        input, edited = ImGui.InputText("Input", input)

        if ImGui.Button("Parse") then
            compute()
        end

        if ImGui.Button("Parse All LevelLibs Seq") then
            local original = input
            input = "Alevels/title_screen.objlib"; compute()
            input = "Alevels/demo.objlib"; compute()
            input = "Alevels/level2/level_2a.objlib"; compute()
            input = "Alevels/level3/level_3a.objlib"; compute()
            input = "Alevels/level4/level_4a.objlib"; compute()
            input = "Alevels/level5/level_5a.objlib"; compute()
            input = "Alevels/level6/level_6.objlib"; compute()
            input = "Alevels/level7/level_7a.objlib"; compute()
            input = "Alevels/level8/level_8a.objlib"; compute()
            input = "Alevels/level9/level_9a.objlib"; compute()
            input = original
        end

        ImGui.TextUnformatted(output)
    end
    ImGui.End()
end

-- " { %s } "
-- ">{ %s }<"
-- "->{%s}<-"