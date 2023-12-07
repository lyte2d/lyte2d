local inspect = require "lib.inspect"

local defs = require "defs_lyte";

print("-- begin\nreturn " .. inspect(defs, {indent="    "}) .. "\n-- end\n")
