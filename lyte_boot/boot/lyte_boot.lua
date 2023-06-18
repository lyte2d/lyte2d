--[[ (c) mg ]]

lyte = lyte or {}

-- lua 5.1 vs others
table.unpack = table.unpack or unpack
unpack = unpack or table.unpack

--




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

-- if not LYTE_APP_MODULENAME then
--     error("Internal error: Expecting LYTE_APP_MODULENAME. Not found")
-- end

-- require(LYTE_APP_MODULENAME)






local error_title = "Error"

-- TODO: global or under lyte
-- this will be used to help dev time
-- errors will be visible on the window instead of crashing/cmdline

local tick_error = function(dt, WW, HH)

    local error_text = _G.LYTE_ERROR_TEXT
    local SC = 1.5
    local PAD = 20

    lyte.cls(0, 0, 0, 1)

    if (error_text) then
        local w = lyte.get_text_width(error_title)
        local h = lyte.get_text_height(error_title)
        local w2 = lyte.get_text_width(error_text)
        local h2 = lyte.get_text_height(error_text)

        local wr = math.max(w, w2) + PAD
        local hr = h + h2 + PAD

        lyte.translate(WW/2 - SC*wr/2, HH/2 - SC*hr/2)

        lyte.scale(SC, SC)

        lyte.set_color(1, 1, 0, 1)
        lyte.draw_text(error_title, PAD/2, PAD/2)
        lyte.set_color(1, 1, 1, 1)
        lyte.draw_text(error_text, PAD/2, PAD/2 + SC * h)
        lyte.set_color(1,0,0,1)

        lyte.draw_rect_line(0,0, wr, hr)
    end
end

if not lyte.tick then
    _G.LYTE_ERROR_TEXT = "function lyte.tick should be implemented"
    lyte.tick = tick_error
end



local tick_loading = function(dt, w, h)
    -- this can be overridden (carefully) in conf
    -- lyte.cls(1, 1, 0, 1)
    lyte.set_color(1, 1, 1, 1)
    lyte.draw_text("loading", w/2-10, h/2-5)
end


-- try to see if a "config.lua/fnl" file exists here.. it may set up window before everything else
local loaded_cfg, _cfg = pcall(require, "config")

-- DEFAULTS
local _def = {
    W = _cfg.window_width or 800,
    H = _cfg.window_height or 500,
    title = _cfg.window_title or "Lyte2D app",
    fullscreen = _cfg.fullscreen or false,
    vsync = _cfg.window_vsync or true,
    default_filtermode = "nearest",
    default_blendmode = "blend",
}

-- hidden feature: config.lua can set this
if not lyte.tick_loading then
    lyte.tick_loading = tick_loading
end


lyte.set_window_size(_def.W, _def.H)
lyte.set_window_title(_def.title)
lyte.set_window_vsync(_def.vsync)
lyte.set_default_filtermode(_def.default_filtermode)
lyte.set_default_blendmode(_def.default_blendmode)

lyte.set_window_icon_file("lyte_boot_assets/icon.png")

local default_font = lyte.load_font("/lyte_boot_assets/monogram-extended.ttf", 24)

function lyte.reset_font()
    lyte.set_font(default_font)
end


lyte.reset_font()

