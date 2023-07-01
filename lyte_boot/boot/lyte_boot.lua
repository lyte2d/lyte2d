--[[ (c) mg ]]

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
        local w = lyte.get_text_width(error_title)
        local h = lyte.get_text_height(error_title)
        local w2 = lyte.get_text_width(error_text)
        local h2 = lyte.get_text_height(error_text)

        local wr = math.max(w, w2) + PAD
        local hr = h + h2 + PAD

        -- lyte.translate(WW/2 - SC*wr/2, HH/2 - SC*hr/2)
        lyte.translate(PAD, PAD)

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
    x,y,a,b,c,d,e,f,g = pcall(loadstring(codestr, filename), ...)
    if x then
        return y, a, b, c, d, e, f, g
    else
        print("Error: " .. y)
        _G.LYTE_ERROR_TEXT = y
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


local function make_lyte_searcher(env)
    local function loader_lyte(modulename)
        local filename = nil
        local code_str= nil
        -- LUA LOADER
        filename = modulename:gsub("%.", "/")  .. ".lua"
        code_str = lyte.load_textfile(filename)
        if code_str then
            return function(...)
                return run_many(code_str, filename, ...)
            end, filename
        else
            -- FENNEL LOADER
            filename = modulename:gsub("%.", "/")  .. ".fnl"
            code_str = lyte.load_textfile(filename)
            if (code_str) then
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
            else
                -- TEAL LOADER
                filename = modulename:gsub("%.", "/")  .. ".tl"
                code_str = lyte.load_textfile(filename)
                if (code_str) then
                    return function(...)
                            local done, result = pcall(tl.process_string, code_str, _G.LYTE_TEAL_LAX_MODE, nil, "@"..filename, modulename)
                            if (not done) then
                                _G.LYTE_ERROR_TEXT = "<teal error> " .. result
                                print ("tl.process_string failed. file: " .. filename .. ", error: " .. result)
                            end
                            if (#result.syntax_errors > 0) then
                                _G.LYTE_ERROR_TEXT = "<teal Syntax error> file: " .. filename
                                print("errors:")
                                for k,v in ipairs(result.syntax_errors) do print (k, fennel.view(v)) end
                                error(_G.LYTE_ERROR_TEXT)
                            end
                            local lua_code = tl.pretty_print_ast(result.ast)
                            return run_many(lua_code, filename, ...)
                    end, filename
                else
                    -- MOONSCRIPT LOADER
                    filename = modulename:gsub("%.", "/")  .. ".moon"
                    code_str = lyte.load_textfile(filename)
                    if (code_str) then
                        print("monoscript is not yet supported")
                    else

                        --handled below
                    end
                end
            end
            if not code_str then
                        if not LYTE_APP_MODULENAME then
                            error("\nInternal Error: expecting LYTE_APP_MODULENAME but not found")
                        end
                        print("\nLyte entry module not found: " .. LYTE_APP_MODULENAME);
                        if not LYTE_REPL_REQUESTED then
                            error("\nMissing entry module: " .. LYTE_APP_MODULENAME);
                        else
                            print("REPL mode: " .. LYTE_REPL_REQUESTED);
                            return function(...)
                                return ""
                            end, filename
                        end
                        if not LYTE_APP_MODULENAME then
                            error("\nInternal Error: expecting LYTE_APP_MODULENAME but not found")
                        end
                        print("\nLyte entry module not found: " .. LYTE_APP_MODULENAME);
                        if not LYTE_REPL_REQUESTED then
                            error("\nMissing entry module: " .. LYTE_APP_MODULENAME);
                        else
                            print("REPL mode: " .. LYTE_REPL_REQUESTED);
                            return function(...)
                                return ""
                            end, filename
                        end
            end
       end
    end
    return loader_lyte
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

-- TODO teal (and moonscript) versions
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
    vsync = _cfg.window_vsync ~= false ,
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

local default_font = lyte.load_font("/lyte_boot_assets/monogram-extended.ttf", 26)

function lyte.reset_font()
    lyte.set_font(default_font)
end


lyte.reset_font()

