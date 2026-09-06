local Reader = Aurora.extension("reader")
local hashtable = Aurora.extension("hashtable")

--[[
local function ends_with(str, ending)
    return ending == "" or string.sub(str, -string.len(ending)) == ending
end

local files = Aurora.list_files(cachePath)

for _, file in ipairs(files) do
    if not ends_with(file, ".bak") then
        
        local bytes = Aurora.load_binary(cachePath .. "/" .. file)
        local reader = Reader.new(bytes)
        
        local filetype = reader:u32()

        if filetype == 6 then
            print("loc: " .. file)
        end
    end
end

]]--

local cachePath = "C:/Program Files (x86)/Steam/steamapps/common/Thumper/cache/"


local text = ""

local function ends_with(str, ending)
    return ending == "" or string.sub(str, -string.len(ending)) == ending
end

local matches = {}

return {
    update = function()
        if ImGui.Begin("Fuzzy Search") then
            text = ImGui.InputText("Search Pattern", text)
            if ImGui.Button("Search (May Freeze For a Minute or Two)") then
                local files = Aurora.list_files("C:/Program Files (x86)/Steam/steamapps/common/Thumper/cache")
                matches = {}

                for _, file in ipairs(files) do
                    if not ends_with(file, ".bak") then
                        
                        local bytes = Aurora.load_binary(cachePath .. file)

                        local start_idx, end_idx = string.find(bytes, text, 1, true)

                        if start_idx then
                            table.insert(matches, {
                                offset = start_idx - 1,
                                file = file,
                            })
                        end
                        
                        
                    end
                end
            end

            for _, match in ipairs(matches) do

                local hashed = tonumber(match.file:match("(.+)%..+$"), 16)
                local hashmatch = hashtable[hashed]

                
                ImGui.TextUnformatted(string.format("%s:0x%x (%s)", match.file, match.offset, hashmatch))
            end
        end
        ImGui.End()
    end
}