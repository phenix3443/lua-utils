-- -*-coding:utf-8-unix -*-
-- author:刘尚亮

local export = {}


function export.get_normal_info(normal_url)
    -- http://,https://,ftp://
    local info = {}
    info.type = export.get_url_type(normal_url)
    local s,e = normal_url:find("/",-1)
    info.name = normal_url:sub(e+1,-1)
    return info
end

function export.get_bt_info(bt_url)
    -- bt://
    local pattern= "^bt://(%x+)$"
    local info = {}
    info.type = "bt"
    info.infohash = bt_url:match(pattern)
    return info
end

function export.get_magnet_info(magnet_url)
    -- magnet:
    local info = {}
    info.type = "magnet"
    info.name = magnet_url:match('^magnet:%?.*dn=([^&]+).*')
    info.size = magnet_url:match('^magnet:%?.*xl=(%d+).*')
    info.infohash = magnet_url:match('^magnet:%?.*xt=urn:btih:(%w+)')

    if info.size then
        info.size = tonumber(info.size)
    end

    return info
end

function export.get_ed2k_info(ed2k_url)
    -- ed2k://
    local pattern = "^ed2k://|file|(.*)|(%d+)|(%w+)"
    local info = {}
    info.type = "ed2k"
    info.name, info.size, info.infohash = ed2k_url:match(pattern)
    if info.size then
        info.size = tonumber(info.size)
    end

    return info
end

function export.get_url_type(url)
    -- 获取 url 类型，主要是协议头部
    local proto = url:match("^(%w+):")
    return proto
end

function export.get_info(url)
    -- 获取从 url 中可以解析到的信息
    local info
    local m = {
        bt = export.get_bt_info,
        magnet = export.get_magnet_info,
        ed2k = export.get_ed2k_info,
    }
    local proto = export.get_url_type(url)
    local f = m[proto]
    if f then
        info = f(url)
    else
        info = export.get_normal_info(url)
    end
    return info
end

function export.get_infohash(url)
    -- 获取链接中的 infohash 内容
    local info = export.get_info(url)
    return info.infohash
end

function export.encode(url)
    -- url编码
    local s = string.gsub(url, "([^%w%.%- ])", function(c) return string.format("%%%02X", string.byte(c)) end)
    return string.gsub(s, " ", "+")
end

function export.decode(url)
    local s = string.gsub(url, '%%(%x%x)', function(h) return string.char(tonumber(h, 16)) end)
    return s
end

return export
