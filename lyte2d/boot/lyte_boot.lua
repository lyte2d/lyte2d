--[[ (c) mg ]]

lyte = lyte or {}


lyte.mathx = require "bootlibs.mathx"


lyte.tween = require "bootlibs.tween"

require "bootlibs.graphics"
require "bootlibs.classic"

require "bootlibs.libraries"

fennel = require "fennel"


table.unpack = table.unpack or unpack
unpack = unpack or table.unpack

_G.tostring_lua = function(n) return tostring(n) end
_G.tostring_fennel = function(n) return fennel.view(n) end


_G.tool_eval_fennel = function(str, fn)
    fn = fn or "(repl)"
    str = str or ""
    return unpack { fennel.eval(str, {correlate=true, filename=fn, allowedGlobals=false}) };
end



lyte.window.icon = "bootassets/icon.png"


----------------------------
-- Copy "direct" api over lyte
-- will remove. maybe.
-----------------------------
-- for k,v in pairs(_lyte_direct_api) do
--     lyte[k] = v
-- end

-- -- GLOBALS
-- for k,v in pairs(lyte) do
--     _G[k] = v
-- end

-- temporary frame (for repl)

lyte.frame = function()
    lyte.clear(0.1,0.1,0.1,0)
    lyte.set_color(0.8,0.8,0.8,1)
    local w, h = lyte.draw_text("GURU MEDITATION", 7, 10)
    local w2, h2 = lyte.draw_text("Couldn't find 'lyte.frame' function", 7, 32)
    lyte.set_color(0.9,0,0,1)
    lyte.draw_rect(4,12, math.max(w, w2) + 6, h2 + 30)
end