--[[ (c) mg ]]

lyte = lyte or {}

-- lua 5.1 vs others
table.unpack = table.unpack or unpack
unpack = unpack or table.unpack

-- default icon
lyte.set_window_icon_file("lyte_boot_assets/icon.png")

-- default font
local default_font = lyte.load_font("/lyte_boot_assets/monogram-extended.ttf", 24)

function lyte.reset_font()
    lyte.set_font(default_font)
end

lyte.reset_font()

-- shader helper (ShaderDef interface)

lyte.new_shader = function(def)
    assert(def.uniforms)
    assert(def.vert)
    assert(def.frag)
    local sb = lyte.new_shaderbuilder()
    for k,v in pairs(def.uniforms) do
        sb:uniform(k, v)
    end
    sb:vertex(def.vert)
    sb:fragment(def.frag)
    local shader = sb:build()
    return shader;
end


-- default 'lyte.tick' function

local error_title = "Issue"
local error_text = "Couldn't find 'lyte.tick' function"
lyte.tick = function()
    lyte.cls(0.1,0.1,0.1,0)
    lyte.set_color(0.8,0.8,0.8,1)
    local w = lyte.get_text_width(error_title)
    local h = lyte.get_text_height(error_title)
    lyte.draw_text(error_title, 7, 10)
    local w2 = lyte.get_text_width(error_text)
    local h2 = lyte.get_text_height(error_text)
    lyte.draw_text(error_text, 7, 32)
    lyte.set_color(0.9,0,0,1)
    lyte.draw_rect_line(4,12, math.max(w, w2) + 6, h2 + 30)
end


-- loaders (note: lua loader is also here!)
-- BOTH LUA AND FENNEL LUADERS HERE
local fnl_file = "/lyte_boot_libs/fennel_lib.lua"
local fnl_src = lyte.load_textfile(fnl_file)
_G.fennel = loadstring(fnl_src, fnl_file)()
debug.traceback = fennel.traceback
local function make_lyte_searcher(env)
    local function loader_fnl(modulename)
        local filename = nil
        local code_str= nil

        -- LUA LOADER
        filename = modulename:gsub("%.", "/")  .. ".lua"
        code_str = lyte.load_textfile(filename)
        if code_str then
            return function(...)
                return  loadstring(code_str, filename)(...)
            end, filename
        else
            -- FENNEL LOADER
            filename = modulename:gsub("%.", "/")  .. ".fnl"
            code_str = lyte.load_textfile(filename)
            if (code_str) then
                return function(...)
                    return fennel.eval(code_str, {correlate=true, env=env, filename="@"..filename, moduleName=modulename}, ...)
                end, filename
            end
       end
       if not code_str then
            print("'app' module mot found");
            if not LYTE_APP_MODULENAME then
                error("Internal Error: Expecting LYTE_APP_MODULENAME. Not found")
            end
            if not LYTE_REPL_REQUESTED then
                error("Lyte entry module not found: " .. LYTE_APP_MODULENAME);
            else
                print("REPL mode: " .. LYTE_REPL_REQUESTED);
                return function(...)
                    return ""
                end, filename
            end
       end

    end
    return loader_fnl
end

table.insert(package.loaders, 2, make_lyte_searcher(_G))
table.insert(fennel["macro-searchers"], 1 ,make_lyte_searcher("_COMPILER"))



-- REPL helpers

_G.LYTE_REPL_EVAL_FENNEL = function(str)
    return fennel.eval(str, {correlate=true, env=env, filename="@lyte_repl", moduleName="lyte_repl"})
end

_G.LYTE_REPL_EVAL_LUA  = function(str)
    if (str == nil or str == "") then str = " " end
    local code
    if (str:sub(1,1) == "=") then
        code = "return " .. str:sub(2)
    else
        code = str;
    end
    return loadstring(code, "lyte_repl")()

end

_G.LYTE_SET_REPL_LUA = function()
    _G.LYTE_REPL_TOSTRING = tostring
    _G.LYTE_REPL_EVAL = _G.LYTE_REPL_EVAL_LUA
end

_G.LYTE_SET_REPL_FENNEL = function()
    _G.LYTE_REPL_TOSTRING = fennel.view
    _G.LYTE_REPL_EVAL = _G.LYTE_REPL_EVAL_FENNEL
end

if LYTE_REPL_REQUESTED == "fennel" or LYTE_REPL_REQUESTED == "fnl" then
    _G.LYTE_SET_REPL_FENNEL()
else
    _G.LYTE_SET_REPL_LUA()
end

-- APP LOADER

if not LYTE_APP_MODULENAME then
    error("Internal error: Expecting LYTE_APP_MODULENAME. Not found")
end

require(LYTE_APP_MODULENAME)
