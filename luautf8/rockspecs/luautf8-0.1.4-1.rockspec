package = "luautf8"
version = "0.1.4-1"
source = {
   url = "https://github.com/starwing/luautf8/archive/refs/tags/0.1.4.tar.gz",
   dir = "luautf8-0.1.4"
}
description = {
   summary = "A UTF-8 support module for Lua",
   detailed = [[
   This module adds UTF-8 support to Lua. It's compatible with Lua "string" module.
]],
   homepage = "http://github.com/starwing/luautf8",
   license = "MIT"
}
dependencies = {
   "lua >= 5.1"
}
build = {
   type = "builtin",
   modules = {
      ["lua-utf8"] = "lutf8lib.c"
   }
}
