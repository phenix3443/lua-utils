-- -*-coding:utf-8-unix -*-
-- author:刘尚亮

local cjson = require("cjson")
local lu = require("luaunit")

local config = require("test_config")
local uu = require("url_utils")

_G["TestGetInfohash"] = {}

local http_url = "http://movie.baiduwen.com/vodd/猫和老鼠/猫和老鼠cd12.rmvb"
local bt_url = "bt://AF77E460682F9A3E237FECBF6E43DDA55F21EDBC"
local magnet_url = "magnet:?dn=test.txt&xl=1024&xt=urn:btih:2AE1E936F7062E1B4CFE202227A70688F563CE63"
local ed2k_url = "ed2k://|file|shuiye.rm|955667968|33C0CD60449C28E7AF8A4CBA43C7521C|/"


function TestGetInfohash:test_BTURL_OK()
    local ih = uu.get_infohash(bt_url)
    lu.assert_equals(ih,"AF77E460682F9A3E237FECBF6E43DDA55F21EDBC")
end

function TestGetInfohash:tset_Magnet_OK()

    local ih = uu.get_infohash(magnet_url)
    lu.assert_equals(ih,"2AE1E936F7062E1B4CFE202227A70688F563CE63")
end

function TestGetInfohash:test_ed2k_OK()
    local ih = uu.get_infohash(ed2k_url)
    lu.assert_equals(ih,"33C0CD60449C28E7AF8A4CBA43C7521C")
end

_G["TestGetInfo"] = {}

function TestGetInfo:test_Normal_OK()
    local info = uu.get_bt_info(http_url)
    lu.assert_equals(info.type,"http")
end

function TestGetInfo:test_BT_OK()
    local info = uu.get_bt_info(bt_url)
    lu.assert_equals(info.type,"bt")
    lu.assert_equals(info.infohash,"AF77E460682F9A3E237FECBF6E43DDA55F21EDBC")
end

function TestGetInfo:test_magnet_OK()
    local info = uu.get_magnet_info(magnet_url)
    lu.assert_equals(info.type,"magnet")
    lu.assert_equals(info.name,"test.txt")
    lu.assert_equals(info.size,1024)
    lu.assert_equals(info.infohash,"2AE1E936F7062E1B4CFE202227A70688F563CE63")
end

function TestGetInfo:test_ed2k_OK()
    local info = uu.get_ed2k_info(ed2k_url)
    lu.assert_equals(info.type,"ed2k")
    lu.assert_equals(info.name,"shuiye.rm")
    lu.assert_equals(info.size,955667968)
    lu.assert_equals(info.infohash,"33C0CD60449C28E7AF8A4CBA43C7521C")
end

function test_GetUrlType_OK()
    lu.assert_equals(uu.get_url_type(http_url),"http")
    lu.assert_equals(uu.get_url_type(bt_url),"bt")
    lu.assert_equals(uu.get_url_type(magnet_url),"magnet")
    lu.assert_equals(uu.get_url_type(ed2k_url),"ed2k")
end

os.exit(lu.LuaUnit.run())
