---@module "aurora"

local extensions = {}

Aurora.extension = function(name)
    if extensions[name] then return extensions[name] end
    extensions[name] = dofile("aurora/extensions/" .. name .. ".lua")
    if extensions[name] then return extensions[name] end
    error("unknown extension: " .. name)
end

local plugins = {}

print("Loading Plugins...")

local function load_plugin(name)
    local environment = {}

    local globals = setmetatable({}, {
        __index = _G,

        __newindex = function(_, key, _)
            error("attempt to modify global '" .. tostring(key) .. "'", 2)
        end,

        __metatable = false,
    })

    environment._G = globals

    setmetatable(environment, { __index = globals })

    local chunk, err = loadfile("aurora/plugins/" .. name .. ".lua", "t", environment)

    if not chunk then error(err) end

    plugins[name] = chunk()
end

local function load_plugin_safe(name)
    print(name .. "...")
    local ok, err = pcall(load_plugin, name)
    if not ok then print("Plugin error: " .. tostring(err)) end
end

load_plugin_safe("hasher")
load_plugin_safe("dump_test")
load_plugin_safe("build")
load_plugin_safe("decomp_test")
load_plugin_safe("level_parse")

print("OK")

function Update()
    for key, value in pairs(plugins) do
        if value.update then
            local ok, err = pcall(value.update)
            if not ok then print("Plugin error: " .. tostring(err)) end
        end
    end
end