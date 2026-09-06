local Reader = {}
Reader.__index = Reader

function Reader.new(data)
    return setmetatable({
        data = data,
        position = 1,
    }, Reader)
end

function Reader:u8()
    local value
    value, self.position = string.unpack("<I1", self.data, self.position)
    return value
end

function Reader:bool()
    local value
    value, self.position = string.unpack("<I1", self.data, self.position)
    if value == 0 then return false end
    return true
end

function Reader:i8()
    local value
    value, self.position = string.unpack("<i1", self.data, self.position)
    return value
end

function Reader:u16()
    local value
    value, self.position = string.unpack("<I2", self.data, self.position)
    return value
end

function Reader:i16()
    local value
    value, self.position = string.unpack("<i2", self.data, self.position)
    return value
end

function Reader:u32()
    local value
    value, self.position = string.unpack("<I4", self.data, self.position)
    return value
end

function Reader:i32()
    local value
    value, self.position = string.unpack("<i4", self.data, self.position)
    return value
end

function Reader:u64()
    local value
    value, self.position = string.unpack("<I8", self.data, self.position)
    return value
end

function Reader:i64()
    local value
    value, self.position = string.unpack("<i8", self.data, self.position)
    return value
end

function Reader:f32()
    local value
    value, self.position = string.unpack("<f", self.data, self.position)
    return value
end

function Reader:f64()
    local value
    value, self.position = string.unpack("<d", self.data, self.position)
    return value
end

function Reader:vec2f()
    local x, y
    x, y, self.position = string.unpack("<ff", self.data, self.position)
    return { x, y }
end

function Reader:vec3f()
    local x, y, z
    x, y, z, self.position = string.unpack("<fff", self.data, self.position)
    return { x, y, z }
end

function Reader:vec4f()
    local x, y, z, w
    x, y, z, w, self.position = string.unpack("<ffff", self.data, self.position)
    return { x, y, z, w }
end

function Reader:transform()
    return {
        pos = self:vec3f(),
        rotx = self:vec3f(),
        roty = self:vec3f(),
        rotz = self:vec3f(),
        scale = self:vec3f(),
    }
end

function Reader:bytes(count)
    local value = self.data:sub(
        self.position,
        self.position + count - 1
    )

    self.position = self.position + count

    return value
end

function Reader:sstr()
    local size = self:u32()
    return self:bytes(size)
end

function Reader:cstr()
    local terminator = self.data:find("\0", self.position, true)

    if not terminator then
        error(string.format("unterminated C string parsing at offset 0x%x", self.position - 1))
    end

    local value = self.data:sub(self.position, terminator - 1)
    self.position = terminator + 1

    return value
end

function Reader:seek(position)
    self.position = position
end

function Reader:skip(count)
    self.position = self.position + count
end

function Reader:tell()
    return self.position
end

function Reader:remaining()
    return #self.data - self.position + 1
end

return Reader