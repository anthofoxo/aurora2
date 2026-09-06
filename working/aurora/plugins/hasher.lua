---@module "aurora"

local input = "Alevels/demo.objlib"
local output = 0
local path = ""

local function compute()
    output = Aurora.fnv1a(input)
    path = string.format("C:/Program Files (x86)/Steam/steamapps/common/Thumper/cache/%x.pc", output)
end

compute()

local function update()
    if (ImGui.Begin("Hasher")) then
        local edited;
        input, edited = ImGui.InputText("Input", input)

        if edited then compute() end

        ImGui.TextUnformatted(string.format("%x", output))
        ImGui.TextUnformatted(path)
    end
    ImGui.End()
end

return {
    update = update
}