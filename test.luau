--!strict
local bib = require("./bib")

local scheme = bib.scheme({
    Name = "string"
})

local data = {
    Name = "Bib"
}

local encoded = scheme:encode(data)
local decoded = scheme:decode(encoded)

print(decoded.Name == "Bib")
