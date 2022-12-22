--[[ (c) mg ]]

lyte = lyte or {}

lyte.mathx = require "bootlibs.mathx"
lyte.tween = require "bootlibs.tween"

require "bootlibs.graphics"
require "bootlibs.classic"

-- global namespace
for k,v in pairs(lyte) do
    _G[k] = v
end

set_windowicon("bootassets/icon.png")
