---@module "aurora"

local Reader = Aurora.extension("reader")

local hashtable = Aurora.extension("hashtable")
dofile("structs.lua")

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

local function compute()
    output = ""
    local path = string.format("C:/Program Files (x86)/Steam/steamapps/common/Thumper/cache/%x.pc", Aurora.fnv1a(input))
    local pcdata = Aurora.load_binary(path)
    append("Loaded %s", path)
    append("Loaded %d bytes", #pcdata)

    local reader = Reader.new(pcdata)
    reader = injectReaderThumperStructs(reader)

    assert(reader:u32() == 8) -- filetype
    assert(reader:u32() == Aurora.fnv1a("LevelLib"))

    local headerObj = {}

    -- ignore header values
    headerObj.unknownHeaderVals = {}
    for i = 1, 4 do
        table.insert(headerObj.unknownHeaderVals, reader:u32())
    end

    headerObj.imports = {}

    for i = 1, reader:u32() do
        table.insert(headerObj.imports, {
            unknown = reader:u32(),
            value = reader:sstr(),
        })
    end

    headerObj.origin = reader:sstr()
    
    local objectImports = {}
    headerObj.objectImports = {}

    for i = 1, reader:u32() do
        local value = {
            type = reader:u32(),
            name = reader:sstr(),
            unknown = reader:u32(),
            path = reader:sstr(),
        }

        append("%s : %s (%s)", value.name, value.path, libraryTypeLookup[value.type])

        table.insert(objectImports, value)

        local value2 = {
            typeHash = value.type,
            name = value.name,
            unknown = value.unknown,
            path = value.path,
        }

        value2.typeHash = hashtable[value2.typeHash] or value2.typeHash;
        
        table.insert(headerObj.objectImports, value2)
    end
    
    

    local objects = {}

    headerObj.localObjOrder = {}

    for i = 1, reader:u32() do
        local value = {
            type = reader:u32(),
            name = reader:sstr(),
        }

        table.insert(headerObj.localObjOrder, value.name)

        append("%s (%s)", value.name, declarationTypeLookup[value.type])

        table.insert(objects, value)
    end

    local generatedPathHead = string.format("mods/thumper/LevelLib/%s/header.lua", string.gsub(input:sub(2), "%.%w+$", ""))
    Aurora.write_binary(generatedPathHead, "return " .. Aurora.serialize(headerObj))

    append("Content Begin Offset: 0x%x", reader.position)
    local contentBegin = reader.position

    append("Skipping object import definitions (incomplete)")
    
    -- before going into the object definitions
    -- the object imports occur here however the structure isnt entirely known
    -- when we scan the first object just perform a bindump

    local lastObjOk = true

    local dumpNextObject = false
    local dumpOffset = reader.position
    local lastObjName = ""
    local isFirstObject = true

    for index, value in ipairs(objects) do
        local searchPattern

        lastObjOk = true

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
        if value.type == Aurora.fnv1a("SequinPulse") then searchPattern = "\x0F\x00\x00\x00\x21\x00\x00\x00\x04\x00\x00\x00" end

        local start_idx, end_idx

        if searchPattern then
            start_idx, end_idx = string.find(pcdata, searchPattern, reader.position, true)
            --error("unknown search pattern for type " .. declarationTypeLookup[value.type])
        end

        if isFirstObject then
            isFirstObject = false
            local binarydata = string.sub(pcdata, contentBegin, start_idx - 1)
            local generatedPath = string.format("mods/thumper/LevelLib/%s/%s.bin", string.gsub(input:sub(2), "%.%w+$", ""), "skybox_cube")
            Aurora.write_binary(generatedPath, binarydata)
        end

        
        if start_idx then
            local skipped = start_idx -  reader.position
            --reader.position = end_idx + 1
            reader.position = start_idx -- allow parser to consume header bytes
            
            if dumpNextObject then
                dumpNextObject = false

                local startoffset = dumpOffset
                local endoffset = reader.position - 1
                print(string.format("Dump obj 0x%x to 0x%x", dumpOffset, reader.position - 1))

                -- get the substring for pcdata at the start/end offsets
                local binarydata = string.sub(pcdata, startoffset, endoffset)
                local generatedPath = string.format("mods/thumper/LevelLib/%s/%s/%s.bin", string.gsub(input:sub(2), "%.%w+$", ""), "Flow", lastObjName)
                Aurora.write_binary(generatedPath, binarydata)
            end

            

            if skipped ~= 0 then
                append("0x%x in %s (skipped 0x%x bytes)", start_idx, value.name, skipped)
            else
                append("0x%x in %s", start_idx, value.name)
            end

            local typenames = {
                "Sample",
                "SequinMaster",
                "EntitySpawner",
                "Tex2D",
                "SequinDrawer",
                "Mat",
                "SequinLevel",
                "Path",
                "Xfmer",
                "SequinLeaf",
                "SequinGate",
                "TraitAnim",
                "Env",
                "Cam",
                "Mesh",
                "PathDecorator",
                "SequinPulse"
            }

            local typeparserFound = false

            for _, typename in ipairs(typenames) do
                if value.type == Aurora.fnv1a(typename) then
                    local parsed = reader[typename](reader)
                    local generatedPath = string.format("mods/thumper/LevelLib/%s/%s/%s.lua", string.gsub(input:sub(2), "%.%w+$", ""), typename, value.name)
                    Aurora.write_binary(generatedPath, "return " .. Aurora.serialize(parsed))
                    typeparserFound = true
                    break
                end
            end

            if not typeparserFound then
                print("obj not supported use bin dump: " .. value.name)
                print(string.format("starting offset: %x", reader.position))
                dumpNextObject = true
                dumpOffset = reader.position
                lastObjName = value.name
                
                
                

                lastObjOk = false
                -- if no parsing works then advance past the found bytes to allow searches to continue
                reader.position = end_idx + 1
            end

        else
            lastObjOk = false
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
            if value.type == Aurora.fnv1a("SequinPulse") then error("fail") end

            append("seq not found for %s", value.name)
            
        end


    end

    if lastObjOk then
        append("Last object was read, footer offset is known: 0x%x", reader.position)

        local structA =
        [=[
        u32 _
        complist comps
        ]=]

        local structB =
        [=[
        sstr camName
	    Cam camObject
	    sstr scene
	    sstr lowspecScene
	    sstr gameplayVrSettings
	    sstr environment
	    sstr cameraRef0
	    sstr nxCamera
	    sstr cameraRef1
	    f32 bpm
	    sstr avatarLib
	    sstr sequinMaster
	    sstr sequinDrawer
	    sstr masterCh
	    sstr baseCh
	    sstr timing
	    bool unknown1
        ]=]

        local val1 = parse_structure(reader, structA)
        local val2 = parse_structure(reader, structB)

        local generatedPath = string.format("mods/thumper/LevelLib/%s/footer.lua", string.gsub(input:sub(2), "%.%w+$", ""))
        Aurora.write_binary(generatedPath, "return " .. Aurora.serialize({ ObjLib = val1, LevelLib = val2 }))

        append("Final read result, ending cursor pos %x vs size %x", reader.position, #reader.data)
    else
        append("\n\nLast object body unknown, cannot read footer. Read Head Position: 0x%x", reader.position)
    end

end

local function update()
    if (ImGui.Begin("Unpacker")) then
        local edited;
        input, edited = ImGui.InputText("Input", input)

        if ImGui.Button("Parse") then

            local success, result = xpcall(compute, function(err)
                return debug.traceback(tostring(err), 2)
            end)

            if not success then print(result) end
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

return {
    update = update
}