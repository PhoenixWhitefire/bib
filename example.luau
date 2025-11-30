--!strict

local bib = require("./bib.luau")

local data = {
    Name = "Hello",
    Type = 12,
    Attributes = {
        BreathesFire = true,
        Explodes = true,
        ExplosionRadius = 21,
        Size = vector.create(2, 15, 2)
    },
    Boolean1 = true,
    Boolean2 = true,
    Boolean3 = false,
    Boolean4 = true,
    Boolean5 = true,
    Boolean6 = false,
    Boolean7 = true,
    Boolean8 = true,
}

local scheme = bib.scheme({
    Name = "string",
    Type = "uint8",
    Attributes = "{ [string]: any }",
    Boolean1 = "boolean",
    Boolean2 = "boolean",
    Boolean3 = "boolean",
    Boolean4 = "boolean",
    Boolean5 = "boolean",
    Boolean6 = "boolean",
    Boolean7 = "boolean",
    Boolean8 = "boolean"
})

local encoded = scheme:encode(data)

local decoded = scheme:decode(data)
