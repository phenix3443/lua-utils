-- -*-coding:utf-8-unix -*-
-- author:刘尚亮

local function script_path()
   local str = debug.getinfo(2, "S").source:sub(2)
   return str:match("(.*/)")
end


local script_dir = script_path()
local project_dir = script_dir

package.path = package.path ..";/home/lsl/github/lua-utils/src/?.lua"
