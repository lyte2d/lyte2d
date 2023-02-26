
fennel = require "libs.fennel"
_G.tostring_fennel = function(n) return fennel.view(n) end
_G.tool_eval_fennel = function(str, fn)
    fn = fn or "(repl)"
    str = str or ""
    return unpack { fennel.eval(str, {correlate=true, filename=fn, allowedGlobals=false}) };
end

require "main"