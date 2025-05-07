-- mg

-- TODO: cleanup globals

function classnew_ctor(ctor_method_name)
    ctor_method_name = ctor_method_name or "__new"
    assert(type(ctor_method_name == "string"))

    local classnew = function(tbl, ...)
        tbl.__index = tbl.__index or tbl
        local inst = {}
        -- dtor (with the name __gc)
        -- this works with types defined in lua tables in 5.1 via "newproxy(true)" hack
        if tbl["__gc"] then
            local proxy_for_gc = newproxy(true)
            getmetatable(proxy_for_gc).__gc = function()
                local ok, err = pcall(tbl.__gc, inst)
                if  not ok then
                    print(err)
                end
            end
            inst[proxy_for_gc] = true
        end
        inst = setmetatable(inst, tbl)
        -- ctor (with the given name. __new if nothing given)
        if tbl[ctor_method_name] then
            local ok, err = pcall(tbl[ctor_method_name], inst, ...)
            if  not ok then
                print(err)
                error(err)
            end
        end
        return inst
    end

    return classnew
end

classnew = classnew_ctor("__new")


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


local error_title = "Error"

-- TODO: global or under lyte
-- this will be used to help dev time
-- errors will be visible on the window instead of crashing/cmdline

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

    local file = lyte_core.load_textfile(path)
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


-- TODO/Consider: lyte.file_exists() API to get rid of file not exists warnings
--   not visible in gui version of windows build (which is the "production" build) so lower priority
local function load_lua_file_or_dir_module(modulename, ext)
    local filename = modulename:gsub("%.", "/")  .. "." .. ext
    local code_str = lyte_core.load_textfile(filename)
    if not code_str then
        -- try "dir/init.lua" variation
        filename = modulename:gsub("%.", "/")  .. "/init." .. ext
        code_str = lyte_core.load_textfile(filename)
    end
    return code_str, filename
end

local function lyte_lua_loader(modulename)
    local filename = nil
    local code_str = nil
    code_str, filename = load_lua_file_or_dir_module(modulename, "lua")
    -- filename = modulename:gsub("%.", "/")  .. ".lua"
    -- code_str = lyte_core.load_textfile(filename)
    if code_str then
        return function(...)
            return run_many(code_str, filename, ...)
        end, filename
    end
end



local function lyte_library_loader(modulename)
    local filename = modulename:gsub("%.", "/")
    modulename = filename:match("[^/]*$")

    return package.loadlib(filename, "luaopen_" .. modulename), filename
end



table.insert(package.loaders, 2, lyte_lua_loader)
table.insert(package.loaders, 3, lyte_library_loader)

-- load  generated APIs
local req_gen_code, err_gen_code = pcall(require, "api_lyte_gen") -- Lua part of the generated API code
if not req_gen_code then
    print("Internal error: " .. err_gen_code)
end


_G.debug_traceback_save = debug.traceback

-- this function can be overridden (carefully) in conf
local tick_loading = function(dt, w, h)
    lyte.set_color(1, 1, 1, 1)
    lyte.draw_text("loading", w/2-10, h/2-5)
end


local loaded_cfg, _cfg = pcall(require, "config")

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
lyte_core.set_window_resizable(false)
lyte_core.set_window_resizable(_def.resizable)

-- window opens below
lyte.set_window_size(_def.W, _def.H)
lyte.set_window_title(_def.title)
lyte.set_window_vsync(_def.vsync)
lyte.set_default_filtermode(_def.default_filtermode)
lyte.set_default_blendmode(_def.default_blendmode)
lyte.set_fullscreen(_def.fullscreen)
lyte.set_window_icon_file("lyte_boot_assets/icon.png")

lyte._default_font = lyte._default_font or lyte.load_font("/lyte_boot_assets/monogram-extended.ttf", 13 * 2)
lyte.reset_font()
