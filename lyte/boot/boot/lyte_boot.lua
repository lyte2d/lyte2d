--[[ (c) mg ]]

local TAB_WIDTH = 4
local TAB_WHITESPACE = (" "):rep(TAB_WIDTH)
local LINES_PATTERN = "([^\n]*)[\n]?"

do
    local _has, _dbg = pcall(require, "lldebugger")
    if _has then
        print("(Debugger Enabled)")
        _dbg.start()
    -- else
    --     print "(no debugger)"
    end
end


lyte = lyte or {}

-- lua 5.1 vs others
table.unpack = table.unpack or unpack
unpack = unpack or table.unpack

--



local error_title = "Error"

-- TODO: global or under lyte
-- this will be used to help dev time
-- errors will be visible on the window instead of crashing/cmdline


-- _G.LYTE_TEAL_LAX_MODE = true
_G.LYTE_TEAL_LAX_MODE = false

_G.LYTE_TICK_ERROR_FUNC = function(dt, WW, HH)

    local error_text = _G.LYTE_ERROR_TEXT or "unknown"
    local SC = 1
    local PAD = 20

    lyte.cls(0, 0, 0, 1)

    if (error_text) then
        local h = lyte.get_text_height(error_title)
        local h2 = lyte.get_text_height(error_text)

        -- lyte.translate(WW/2 - SC*wr/2, HH/2 - SC*hr/2)
        lyte.translate(PAD, PAD/2)

        lyte.scale(SC, SC)

        if _G.LYTE_ERROR_LINE then
            local prefix_width = lyte.get_text_width(_G.LYTE_ERROR_LINE.prefix)
            local prefix_x = PAD/2
            local error_x = prefix_x + prefix_width

            lyte.set_color(1,1,0,1)
            lyte.draw_text(_G.LYTE_ERROR_LINE.prefix, prefix_x, 0)


            lyte.set_color(1,1,1,1)
            lyte.draw_text(_G.LYTE_ERROR_LINE.line, error_x, 0)

            local underline_y = h2 * 0.6

            lyte.set_color(1,0,0,1)
            lyte.draw_text(_G.LYTE_ERROR_LINE.underline, error_x, underline_y)

            lyte.translate(0, h2 + PAD)
        end

        lyte.set_color(1, 1, 0, 1)
        lyte.draw_text(error_title, PAD/2, 0)
        lyte.set_color(1, 1, 1, 1)

        local y = 0
        local max_line_width = 0

        for error_line in error_text:gmatch(LINES_PATTERN) do
            max_line_width = math.max(max_line_width, lyte.get_text_width(error_line))
            error_line = error_line:gsub("\t", TAB_WHITESPACE)
            lyte.draw_text(error_line, PAD/2, (SC + y) * h2)
            y = y + 1
        end

        lyte.set_color(1,0,0,1)

        local wr = max_line_width + PAD
        local hr = h + h2 * y + PAD

        lyte.draw_rect_line(0,0, wr, hr)
    end
end


local function get_error_line(text)
    local path, line_num = text:match("^(.-):(%d*):.-\n")

    if not path or not line_num then
        return
    end

    line_num = tonumber(line_num)

    local file = lyte.load_textfile(path)
    local line_i = 1
    for line in file:gmatch(LINES_PATTERN) do
        if line_i == line_num then
            line = line:match("^[%s]*(.-)[%s]*$")
            local prefix = path .. ":" .. line_num .. ": "

            return {
                prefix = prefix,
                line = line,
                underline = ("~"):rep(#line),
            }
        end

        line_i = line_i + 1
    end
end


_G.LYTE_SET_ERROR_TEXT_AND_LINE = function(text)
    _G.LYTE_ERROR_TEXT = text
    _G.LYTE_ERROR_LINE = get_error_line(text)
end


if not lyte.tick then
    _G.LYTE_ERROR_TEXT = "function lyte.tick should be implemented"
    _G.LYTE_ERROR_LINE = nil
    lyte.tick = LYTE_TICK_ERROR_FUNC
end




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


local function run_many(codestr, filename, ...)
    local x,y,a,b,c,d,e,f,g
    x,y,a,b,c,d,e,f,g = pcall(loadstring(codestr, "@"..filename), ...)
    if x then
        return y, a, b, c, d, e, f, g
    else
        print("Error: " .. y)
        _G.LYTE_SET_ERROR_TEXT_AND_LINE(y)
        lyte.tick = LYTE_TICK_ERROR_FUNC
        return y
    end
end


-- loaders (note: lua loader is also here!)
-- BOTH LUA AND FENNEL LUADERS HERE

local fnl_file = "/lyte_boot_libs/fennel_lib.lua"
local fnl_src = lyte.load_textfile(fnl_file)
_G.fennel = loadstring(fnl_src, fnl_file)()

local lulpeg_file = "/lyte_boot_libs/lulpeg.lua"
local lulpeg_src = lyte.load_textfile(lulpeg_file)
_G.lpeg = loadstring(lulpeg_src, lulpeg_file)()

local tl_file = "/lyte_boot_libs/tl.lua"
local tl_src = lyte.load_textfile(tl_file)
_G.tl = loadstring(tl_src, tl_file)()


-- TODO: lyte.file_exists() API to get rid of file not exists warnings
local function load_lua_file_or_dir_module(modulename, ext)
    local filename = modulename:gsub("%.", "/")  .. "." .. ext
    local code_str = lyte.load_textfile(filename)
    if not code_str then
        -- try "dir/init.lua" variation
        filename = modulename:gsub("%.", "/")  .. "/init." .. ext
        code_str = lyte.load_textfile(filename)
    end
    return code_str, filename
end

local function lyte_lua_loader(modulename)
    local filename = nil
    local code_str = nil
    code_str, filename = load_lua_file_or_dir_module(modulename, "lua")
    -- filename = modulename:gsub("%.", "/")  .. ".lua"
    -- code_str = lyte.load_textfile(filename)
    if code_str then
        return function(...)
            return run_many(code_str, filename, ...)
        end, filename
    end
end


local function make_lyte_searcher(env)
    local function loader_lyte(modulename)
        local filename = nil
        local code_str= nil
        local lang = nil
        local languages = {"fnl", "tl"}

        for _, ext in ipairs(languages) do
            -- filename = modulename:gsub("%.", "/")  .. "." .. ext
            -- code_str = lyte.load_textfile(filename)
            code_str, filename = load_lua_file_or_dir_module(modulename, ext)
            if code_str then
                lang = ext
                break
            end
        end

        -- if lang == "lua" then
        --     return function(...)
        --         return run_many(code_str, filename, ...)
        --     end, filename
        --
        -- elseif...
        if lang == "fnl" then
            return function(...)
                -- macro loader vs function loader
                if env == "_COMPILER" then
                    -- macro loadewr
                    return fennel.eval(code_str, {correlate=true, env=env, filename="@"..filename, moduleName=modulename}, ...)
                else
                    local x, y = pcall(fennel.compileString, code_str, {correlate=true, env=env, filename="@"..filename, moduleName=modulename})
                    return run_many(y, filename, ...)
                end
                -- END NOTENOTE: this should be the same between different file types
            end, filename
        elseif lang == "tl" then
            return function(...)
                    local done, result = pcall(tl.process_string, code_str, _G.LYTE_TEAL_LAX_MODE, nil, "@"..filename, modulename)
                    if (not done) then
                        _G.LYTE_ERROR_TEXT = "<teal error> " .. result
                        _G.LYTE_ERROR_LINE = get_error_line(result)
                        print ("tl.process_string failed. file: " .. filename .. ", error: " .. result)
                    end
                    if (#result.syntax_errors > 0) then
                        _G.LYTE_ERROR_TEXT = "<teal Syntax error> file: " .. filename
                        _G.LYTE_ERROR_LINE = get_error_line(result)
                        print("errors:")
                        for k,v in ipairs(result.syntax_errors) do print (k, fennel.view(v)) end
                        error(_G.LYTE_ERROR_TEXT)
                    end
                    local lua_code = tl.pretty_print_ast(result.ast)
                    return run_many(lua_code, filename, ...)
            end, filename
        else
            print("Internal error: Unknown/incorrectly configured lang: " .. lang)
        end

    end
    return loader_lyte
end

table.insert(package.loaders, 2, lyte_lua_loader)

table.insert(package.loaders, 3, make_lyte_searcher(nil))
table.insert(fennel["macro-searchers"], 1 ,make_lyte_searcher("_COMPILER"))



-- REPL helpers

_G.LYTE_REPL_EVAL_FENNEL = function(str)
    return fennel.eval(str, {correlate=true, env=nil, filename="@lyte_repl", moduleName="lyte_repl"})
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

_G.debug_traceback_save = debug.traceback

_G.LYTE_SET_REPL_LUA = function()
    debug.traceback = _G.debug_traceback_save
    _G.LYTE_REPL_TOSTRING = tostring
    _G.LYTE_REPL_EVAL = _G.LYTE_REPL_EVAL_LUA
end


_G.LYTE_SET_REPL_FENNEL = function()
    _G.LYTE_REPL_TOSTRING = fennel.view
    debug.traceback = fennel.traceback
    _G.LYTE_REPL_EVAL = _G.LYTE_REPL_EVAL_FENNEL
end


if LYTE_REPL_REQUESTED == "fennel" or LYTE_REPL_REQUESTED == "fnl" then
    _G.LYTE_SET_REPL_FENNEL()
else
    -- tl (teal) based repl doesn't make much sense
    _G.LYTE_SET_REPL_LUA()
end

-- APP LOADER

-- if not LYTE_APP_MODULENAME then
--     error("Internal error: Expecting LYTE_APP_MODULENAME. Not found")
-- end

-- require(LYTE_APP_MODULENAME)






local tick_loading = function(dt, w, h)
    -- this can be overridden (carefully) in conf
    -- lyte.cls(1, 1, 0, 1)
    lyte.set_color(1, 1, 1, 1)
    lyte.draw_text("loading", w/2-10, h/2-5)
end


-- try to see if a "config.lua/fnl" file exists here.. it may set up window before everything else
local loaded_cfg, _cfg = pcall(require, "config")
-- local _cfg = require("config")

-- DEFAULTS
local _def = {
    W = _cfg.window_width or 800,
    H = _cfg.window_height or 500,
    title = _cfg.window_title or "Lyte2D app",
    fullscreen = _cfg.fullscreen or false,
    vsync = _cfg.window_vsync ~= false ,
    resizable = _cfg.window_resizable ~= false,
    default_filtermode = _cfg.default_filtermode or "nearest",
    default_blendmode = _cfg.default_blendmode or "blend",
}

-- hidden feature: config.lua can set this
if not lyte.tick_loading then
    lyte.tick_loading = tick_loading
end

-- before window opens
lyte.set_window_resizable(_def.resizable)
-- window opens below
lyte.set_window_size(_def.W, _def.H)
lyte.set_window_title(_def.title)
lyte.set_window_vsync(_def.vsync)
lyte.set_default_filtermode(_def.default_filtermode)
lyte.set_default_blendmode(_def.default_blendmode)
lyte.set_fullscreen(_def.fullscreen)

lyte.set_window_icon_file("lyte_boot_assets/icon.png")

local default_font = lyte.load_font("/lyte_boot_assets/monogram-extended.ttf", 26)

function lyte.reset_font()
    lyte.set_font(default_font)
end


lyte.reset_font()
