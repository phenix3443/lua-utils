-- -*-coding:utf-8-unix -*-
-- author:刘尚亮
local string = string

local export = {}


export.hex2bin = function (hex_str)
        return (hex_str:gsub('..', function (cc) return string.char(tonumber(cc, 16)) end))
end

export.bin2hex = function (binstr)
    return (binstr:gsub('.', function (c) return string.format('%02x', string.byte(c)) end))
end

export.startswith = function(str, start)
    return string.sub(str,1,string.len(start)) == start
end

export.copy_table = function(orig)
    local copy = {}
    for orig_key, orig_value in pairs(orig) do
        copy[orig_key] = orig_value
    end
    return copy
end

export.load_json_file = function(json_file)
    local cjson = require("cjson")
    local f = io.open(json_file, "r")
    local contents = f:read("*a")
    io.close(f)
    local json_content = cjson.decode(contents)
    return json_content
end

return export
