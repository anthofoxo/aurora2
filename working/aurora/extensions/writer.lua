local Writer = {}
Writer.__index = Writer

function Writer.new()
    return setmetatable({
        data = {},
    }, Writer)
end

function Writer:u8(value)
    self.data[#self.data + 1] = string.pack("<I1", value)
end

function Writer:i8(value)
    self.data[#self.data + 1] = string.pack("<i1", value)
end

function Writer:u16(value)
    self.data[#self.data + 1] = string.pack("<I2", value)
end

function Writer:i16(value)
    self.data[#self.data + 1] = string.pack("<i2", value)
end

function Writer:u32(value)
    self.data[#self.data + 1] = string.pack("<I4", value)
end

function Writer:i32(value)
    self.data[#self.data + 1] = string.pack("<i4", value)
end

function Writer:u64(value)
    self.data[#self.data + 1] = string.pack("<I8", value)
end

function Writer:i64(value)
    self.data[#self.data + 1] = string.pack("<i8", value)
end

function Writer:f32(value)
    self.data[#self.data + 1] = string.pack("<f", value)
end

function Writer:f64(value)
    self.data[#self.data + 1] = string.pack("<d", value)
end

function Writer:bool(value)
    self:u8(value and 1 or 0)
end

function Writer:vec2f(value)
    self.data[#self.data + 1] = string.pack(
        "<ff",
        value[1],
        value[2]
    )
end

function Writer:vec3f(value)
    self.data[#self.data + 1] = string.pack(
        "<fff",
        value[1],
        value[2],
        value[3]
    )
end

function Writer:vec4f(value)
    self.data[#self.data + 1] = string.pack(
        "<ffff",
        value[1],
        value[2],
        value[3],
        value[4]
    )
end

function Writer:transform(value)
    self:vec3f(value.pos)
    self:vec3f(value.rotx)
    self:vec3f(value.roty)
    self:vec3f(value.rotz)
    self:vec3f(value.scale)
end

function Writer:bytes(value)
    self.data[#self.data + 1] = value
end

function Writer:sstr(value)
    self:u32(#value)
    self:bytes(value)
end

function Writer:cstr(value)
    self:bytes(value)
    self:u8(0)
end

function Writer:tell()
    local size = 0

    for _, chunk in ipairs(self.data) do
        size = size + #chunk
    end

    return size
end

function Writer:finish()
    return table.concat(self.data)
end

function write_structure(writer, struct, value)
    local unknown = 0

    for line in struct:gmatch("[^\n]+") do
        local type, name = line:match("^%s*(%S+)%s+(%S+)%s*$")

        if type and name then
            local array_type, array_size = name:match("^(.-)%[(%d*)%]$")

            if array_type then
                name = array_type

                if name == "_" then
                    unknown = unknown + 1
                    name = "unknown" .. unknown
                end

                local list = value[name]

                if not list then
                    error("missing array field: " .. name)
                end

                if array_size == "" then
                    -- Dynamic array: write the count first.
                    writer:u32(#list)

                    for i = 1, #list do
                        if not writer[type] then
                            error("unknown writer function: " .. type)
                        end

                        writer[type](writer, list[i])
                    end
                else
                    -- Fixed array: size is part of the structure.
                    local count = tonumber(array_size)

                    if #list ~= count then
                        error(string.format(
                            "array field '%s' expected %d elements, got %d",
                            name,
                            count,
                            #list
                        ))
                    end

                    for i = 1, count do
                        if not writer[type] then
                            error("unknown writer function: " .. type)
                        end

                        writer[type](writer, list[i])
                    end
                end
            else
                if name == "_" then
                    unknown = unknown + 1
                    name = "unknown" .. unknown
                end

                if not writer[type] then
                    error("unknown writer function: " .. type)
                end

                local field = value[name]

                if field == nil then
                    error("missing field: " .. name)
                end

                writer[type](writer, field)
            end
        end
    end
end

Writer.write_structure = write_structure

return Writer