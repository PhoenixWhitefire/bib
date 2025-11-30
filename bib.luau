-- bib.luau
-- Buffer serialization library by
-- @PhoenixWhitefire

--!strict
--!native

local bib = {}
local scheme = {}
scheme.__index = scheme

local encoders = {
    string = function(encoded: buffer, offset: number, value: string)
        buffer.writeu32(encoded, offset, #value)
        buffer.writestring(encoded, offset + 4, value)

        return offset + 4 + #value
    end
}

local decoders = {
    string = function(encoded: buffer, offset: number)
        local strlen = buffer.readu32(encoded, offset)
        offset += 4

        return offset + strlen, buffer.readstring(encoded, offset, strlen)
    end
}

export type Schema = { [string]: keyof<typeof(encoders)> }

type SchemeData = {
    Schema: Schema
}

export type Scheme = setmetatable<SchemeData, typeof(scheme)>

function bib.scheme(schema: Schema): Scheme
    return setmetatable({ Schema = schema }, scheme)
end

function scheme.encode(self: Scheme, data)
    local encoded = buffer.create(1000000)
    local offset = 0

    for name, type in self.Schema do
        offset = encoders[type](encoded, offset, data[name])
    end

    return encoded
end

function scheme.decode(self: Scheme, encoded: buffer): any
    local decoded = {}
    local offset = 0

    for name, type in self.Schema do
        offset, decoded[name] = decoders[type](encoded, offset)
    end

    return decoded
end

return bib
