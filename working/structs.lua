function parse_structure(reader, struct)
    local value = {}
    local unknown = 0

    for line in struct:gmatch("[^\n]+") do
        local type, name = line:match("^%s*(%S+)%s+(%S+)%s*$")

        if type and name then
            local array_type, array_size = name:match("^(.-)%[(%d*)%]$")

            if array_type then
                name = array_type

                if array_size == "" then
                    -- Dynamic array: read the count first.
                    local count = reader:u32()
                    local list = {}

                    for i = 1, count do
                        list[i] = reader[type](reader)
                    end

                    if name == "_" then
                        unknown = unknown + 1
                        name = "unknown" .. unknown
                    end

                    value[name] = list
                else
                    -- Fixed array: the size is part of the structure.
                    local count = tonumber(array_size)
                    local list = {}

                    for i = 1, count do
                        list[i] = reader[type](reader)
                    end

                    if name == "_" then
                        unknown = unknown + 1
                        name = "unknown" .. unknown
                    end

                    value[name] = list
                end
            else
                if name == "_" then
                    unknown = unknown + 1
                    name = "unknown" .. unknown
                end

                if not reader[type] then
                    error("unknown parser function: " .. type)
                end

                value[name] = reader[type](reader)
            end
        end
    end

    return value
end

--[[
// unknownTransitionName //
In all customs and all vanilla levels this is an empty string Level 7 is the
exception, it is seen with this value set to `crakhed_pellet_trans.lvl` in
the gate `crakhed.gate`
]]--
local SequinGateStruct = [=[
u32 header[2]
complist comp
sstr entitySpawnerName
ParamPath params[]
SequinGate.BossPattern patterns[]
sstr preLevelName
sstr postLevelName
sstr restartLevelName
sstr unknownTransitionName
sstr sectionType
f32 _
sstr randomType
]=]

local SequinGateStruct_BossPattern = [=[
u32 nodeHash
sstr levelName
bool _
sstr sentryType
u32 _
u32 bucketNum
]=]

local XfmerStruct = [=[
u32 header[2]
complist comps
]=]

local PathStruct = [=[
u32 header[2]
complist comps
vec3f _
vec3f unknownScale
u32 _
sstr mesh
bool _
sstr interp
u8 _[6]
sstr decorators[]
bool _
]=]

local SequinLevelStruct_SubPath = [=[
sstr path
u32 _
]=]

local SequinLevelStruct_Entry = [=[
u32 _
u32 beatCount
bool _
sstr leafName
sstr mainPath
SequinLevel.SubPath subpaths[]
sstr stepGameplay
u32 totalBeatToThisPoint
transform transform
u8 _
u8 _
]=]

local SequinLevelStruct_Loop = [=[
sstr sampName
u32 beatsPerLoop
u32 _
]=]

local ParamPathStruct = [=[
u32 hash
u32 index
]=]

local TraitStruct = [=[
sstr objName
ParamPath params[]
DataPointList datapoints
u32 _[5]
sstr _
sstr _
bool _
bool _
u32 _
f32 _[5]
bool _
bool _
bool _
]=]

local SequinMasterStruct_Entry = [=[
sstr lvlName
sstr gateName
bool hasCheckpoint
sstr checkpointLeaderLvlName
sstr restLvlName
bool _
bool _
u32 _
bool _
bool playPlus
]=]

local SequinMasterStruct = [=[
u32 header[3]
complist comps
u32 _
f32 _
sstr skybox
sstr introLevel
SequinMaster.Entry levels[]
bool _
bool _
u32 _
u32 _
u32 _
u32 _
f32 footer7
f32 footer8
f32 footer9
sstr checkpointLvl
sstr pathGameplay
]=]

local Tex2DStruct = [=[
u32 header[2]
complist comps
sstr compression
u8 _
u8 _
u8 _
u8 _
u8 _
sstr path
]=]

local TraitAnimStruct = [=[
u32 header[2]
complist comps
Trait traits[]
u32 _
]=]

local EnvStruct = [=[
u32 header[2]
complist comps
vec3f _
f32 _
sstr lit[]
vec3f _
vec2f _
]=]

local CamStruct = [=[
u32 header[2]
complist comps
vec3f extra
]=]

local MeshStruct = [=[
u32 header[2]
complist comps
sstr material
bool _
u32 _
sstr mesh
u8 extra[17]
]=]

local SequinPulseStruct = [=[
u32 header[3]
complist comps
Trait traits[]
vec3f _
sstr _[5]
bool _
bool _
]=]

local PathDecoratorStruct = [=[
u32 header[2]
complist comp
PathDecorator.Cap caps[]
PathDecorator.Cond stencils[]
u8 _[9]
]=]

local PathDecoratorStruct_Cap = [=[
PathDecorator.Cond cond
bool unknown2
sstr pathScaleInterp
bool unknown3
bool unknown4
f32 unknown5
f32 unknown6
f32 unknown7
bool unknown8
]=]

local PathDecoratorStruct_Cond = [=[
sstr condition
u32 unknown
sstr mesh
]=]

local SampleStruct = [=[
u32 header[2]
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

local EntitySpawnerStruct = [=[
u32 header[2]
complist comps
u32 _
sstr path
sstr bucket
]=]

local SequinDrawerStruct = [=[
u32 header[2]
complist comps
]=]

local MatStruct = [=[
u32 header[2]
complist comps
sstr diffuseTexture0
sstr diffuseTexture1
sstr cube
sstr unknownTexture
sstr blendMode
u32 unknown4
sstr cullMode
sstr depthTest
bool unknown5
bool unknown6
sstr textureFilter
f32 unknown7[22]
sstr specular
sstr xfmOption
f32 unknown8[16]
u8 unknown10
sstr vig
u8 unknown9
]=]

local SequinLeafStruct = [=[
u32 header[3]
complist comp
Trait traits[]
u32 _
vec3f beatFooter[]
vec3f finalFooter
]=]

local CreditsStruct_Section = [=[
sstr header
sstr items[]
]=]

local CreditsStruct_Heading = [=[
    sstr decoration
    sstr text
]=]

local CreditsStruct_HeadingGroup = [=[
    CreditsStruct_Heading headings[]
]=]

local CreditsStruct = [=[
u32 filetype
CreditsStruct_HeadingGroup headings[]
CreditsStruct_Section credits[]
]=]

LevelListingStruct_List = [=[
    LevelListingStruct_Entry entries[]
]=]

LevelListingStruct_Entry = [=[
sstr key
u32 _
sstr path
sstr unlocks
bool defaultLocked
bool _
bool triggersCredits
u32 colorIndexes[2]
]=]

local EditStateCompStruct = [=[
]=]

local XfmCompStruct = [=[
u32 _
sstr name
sstr constraint
transform transform
]=]

local DrawCompStruct = [=[
u32 _
bool visible
sstr layer
sstr bucket
sstr context[]
]=]

local PollCompStruct = [=[
u32 _
]=]

local AnimCompStruct = [=[
u32 _
f32 _
sstr timeUnit
]=]

local ApproachAnimCompStruct = [=[
u32 _
f32 _
sstr timeBeats
u32 _
u32 approachBeats
]=]

local GfxLibImportStruct_Group = [=[
ParamPath params[]
sstr type
DataPoint dataoint
]=]

local GfxLibImportStruct = [=[
u32 header[2]
bool _
GfxLibImport.Group groupings[]
complist comps
]=]

-- when a gfxlibimport is processed (example skybox_cube)
-- drawcomp is used but it doesnt contain the last context list
-- whats the deal with this?

local function make_comp_parser(struct, name)
    return function (reader)
        local value = parse_structure(reader, struct)
        value.type = name
        return value
    end
end

local compTypes = {
    [Aurora.fnv1a("EditStateComp")] = make_comp_parser(EditStateCompStruct, "EditStateComp"),
    [Aurora.fnv1a("XfmComp")] = make_comp_parser(XfmCompStruct, "XfmComp"),
    [Aurora.fnv1a("DrawComp")] = make_comp_parser(DrawCompStruct, "DrawComp"),
    [Aurora.fnv1a("PollComp")] = make_comp_parser(PollCompStruct, "PollComp"),
    [Aurora.fnv1a("AnimComp")] = make_comp_parser(AnimCompStruct, "AnimComp"),
    [Aurora.fnv1a("ApproachAnimComp")] = make_comp_parser(ApproachAnimCompStruct, "ApproachAnimComp"),
}

local function parse_complist(reader)
    local valuelist = {}

    for i = 1, reader:u32() do
        local type = reader:u32()
        local generator = compTypes[type]

        if generator then
            table.insert(valuelist, generator(reader))
        else
            error(string.format("unknown comp type %x at offset %x", type, reader.position - 1))
        end
    end

    return valuelist
end

function injectReaderThumperStructs(reader)
    reader["complist"] = parse_complist
    reader["SequinMaster.Entry"] = function(reader) return parse_structure(reader, SequinMasterStruct_Entry) end
    reader["SequinMaster"] = function(reader) return parse_structure(reader, SequinMasterStruct) end
    reader["Tex2D"] = function(reader) return parse_structure(reader, Tex2DStruct) end
    reader["SequinDrawer"] = function(reader) return parse_structure(reader, SequinDrawerStruct) end
    reader["Mat"] = function(reader) return parse_structure(reader, MatStruct) end
    reader["SequinLeaf"] = function(reader) return parse_structure(reader, SequinLeafStruct) end
    reader["SequinLevel.SubPath"] = function(reader) return parse_structure(reader, SequinLevelStruct_SubPath) end
    reader["SequinLevel.Entry"] = function(reader) return parse_structure(reader, SequinLevelStruct_Entry) end
    reader["SequinLevel.Loop"] = function(reader) return parse_structure(reader, SequinLevelStruct_Loop) end
    reader["Xfmer"] = function(reader) return parse_structure(reader, XfmerStruct) end
    reader["TraitAnim"] = function(reader) return parse_structure(reader, TraitAnimStruct) end
    reader["Env"] = function(reader) return parse_structure(reader, EnvStruct) end
    reader["Cam"] = function(reader) return parse_structure(reader, CamStruct) end
    reader["Mesh"] = function(reader) return parse_structure(reader, MeshStruct) end
    reader["PathDecorator"] = function(reader) return parse_structure(reader, PathDecoratorStruct) end
    reader["PathDecorator.Cap"] = function(reader) return parse_structure(reader, PathDecoratorStruct_Cap) end
    reader["PathDecorator.Cond"] = function(reader) return parse_structure(reader, PathDecoratorStruct_Cond) end
    reader["SequinPulse"] = function(reader) return parse_structure(reader, SequinPulseStruct) end
    reader["SequinGate"] = function(reader) return parse_structure(reader, SequinGateStruct) end
    reader["Sample"] = function(reader) return parse_structure(reader, SampleStruct) end
    reader["EntitySpawner"] = function(reader) return parse_structure(reader, EntitySpawnerStruct) end
    reader["LevelListingStruct_List"] = function(reader) return parse_structure(reader, LevelListingStruct_List) end
    reader["LevelListingStruct_Entry"] = function(reader) return parse_structure(reader, LevelListingStruct_Entry) end

    reader["CreditsStruct_Section"] = function(reader) return parse_structure(reader, CreditsStruct_Section) end
    reader["CreditsStruct_Heading"] = function(reader) return parse_structure(reader, CreditsStruct_Heading) end
    reader["CreditsStruct_HeadingGroup"] = function(reader) return parse_structure(reader, CreditsStruct_HeadingGroup) end
    reader["CreditsStruct"] = function(reader) return parse_structure(reader, CreditsStruct) end

    reader["LocalizationStruct"] = function(reader)
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

        local obj = {}
        obj.filetype = reader:u32()
        local numKeys = reader:u32()
        reader:u32() -- numBytes
        obj.keys = {}

        for i = 1, numKeys do
            table.insert(obj.keys, { value = reader:cstr() })
        end

        for i = 1, numKeys do
            local key = reader:u32()
            key = Aurora.extension("hashtable")[key] or key
            obj.keys[i].key = key
            --keys[i].offset = reader:u32()
            reader:u32() -- dont care about offset
        end

        return obj
    end

    reader["SequinGate.BossPattern"] = function(reader)
        local obj = parse_structure(reader, SequinGateStruct_BossPattern)
        obj.nodeHash = Aurora.extension("hashtable")[obj.nodeHash] or obj.nodeHash
        return obj
    end
    reader["ParamPath"] = function(reader)
        local obj = parse_structure(reader, ParamPathStruct)
        obj.hash = Aurora.extension("hashtable")[obj.hash] or obj.hash
        return obj
    end
    reader["Trait"] = function(reader) return parse_structure(reader, TraitStruct) end
    reader["Path"] = function(reader) return parse_structure(reader, PathStruct) end
    reader["SequinLevel"] = function(reader)
        local obj = {}

        local a = [=[
        u32 header[3]
        complist comps
        Trait traits[]
        u32 _
        sstr phase
        u32 _
        ]=]

        for key, value in pairs(parse_structure(reader, a)) do
            obj[key] = value
        end

        obj.enteries = {}
        while reader:bool() do
            table.insert(obj.enteries, reader["SequinLevel.Entry"](reader))
        end

        local b = [=[
        SequinLevel.Loop loops[]
        bool _
        f32 volume
        sstr startFlow
        ParamPath unknownParams[]
        sstr traitType
        bool inputAllowed
        sstr tutorialType
        vec3f startAngleFracs
        ]=]

        for key, value in pairs(parse_structure(reader, b)) do
            obj[key] = value
        end

        return obj
    end
    reader["DataPointList"] = function(reader)
        local function readTraitType(reader, traitType)
            local obj = {}
            obj.time = reader:f32()
            
            if traitType == 0 then obj.data = reader:s32()
            elseif traitType == 1 then obj.data = reader:bool()
            elseif traitType == 2 then obj.data = reader:f32()
            elseif traitType == 3 then obj.data = reader:vec4f()
            elseif traitType == 4 then obj.data = reader:sstr()
            elseif traitType == 5 then obj.data = reader:vec3f()
            elseif traitType == 8 then obj.data = reader:bool()
            else
                error("unsupported traittype: " .. traitType)
            end

            obj.interp = reader:sstr()
            obj.ease = reader:sstr()
            return obj
        end

        local obj = {}
        obj.traitType = reader:u32()
        obj.datapoints = {}
        obj.editorDatapoints = {}

        for i = 1, reader:u32() do
            table.insert(obj.datapoints, readTraitType(reader, obj.traitType))
        end

        for i = 1, reader:u32() do
            table.insert(obj.editorDatapoints, readTraitType(reader, obj.traitType))
        end

        return obj
    end

    return reader
end