---@meta "aurora"

Aurora = {
    ---Loads the content of the file pointed to by `path` into a string
    ---@param path string
    ---@return string
    ---@throws If the file fails to be opened or otherwise unreadable
    ---@nodiscard
    load_binary = function(path) end,

    ---Performs a hash on the input value using Thumper's modified fnv1a hash function
    ---@param input string
    ---@return integer
    ---@nodiscard
    fnv1a = function(input) end,
}

ImGui = {
    ---@param text string
    TextUnformatted = function(text) end,

    ---@param title string
    ---@return boolean
    Begin = function(title) end,

    End = function() end,

    Separator = function() end,

    ---@param label string
    SeparatorText = function(label) end,
}