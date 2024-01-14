require "lib.apidef"

local SPC = "    "
local SPC2 = SPC:rep(2)


local gen_c_helper_code = [[
// lightuserdata  helper (modeled after luaL_check* functions in lauxlib.c)
static inline void *_checklightuserdata(lua_State *L, int narg) {
    void *ret = lua_touserdata(L, narg);
    if (ret == NULL && !lua_islightuserdata(L, narg)) {
        luaL_typerror(L, narg, lua_typename(L, LUA_TLIGHTUSERDATA));
    }
    return ret;
}

static inline size_t _checktable_getcount(lua_State *L, int narg) {
    if (lua_type(L, narg) != LUA_TTABLE) {
        fprintf(stderr, "Expected a list, got %s", lua_typename(L, narg));
        lua_error(L);
    }
    size_t cnt = lua_objlen(L, narg);
    return cnt;
}

// enum helpers
typedef struct EnumStrInt {
    const char *str;
    int value;
} EnumStrInt;

static int enumstring_to_int(EnumStrInt *vals, const char *str) {
    while (vals->str && (strcmp(str, vals->str)!=0)) vals++;
    return vals->value;
}
]]

local impl_c_top = [[
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>
#include <assert.h>

// NOTE:
// Edit and modify this file with the implementation details
// Rename the file and remove __EDIT__ from the filename

// #include NATIVELIBRARY_H_FILE

]]

-- keep in sync with apidef.lua variable TypeMaps
local CTypeMaps = {
    ["bool"] =    { c = "bool",          check_fn = "lua_toboolean",          push_fn = "lua_pushboolean" },
    ["int"] =     { c = "int",           check_fn = "luaL_checknumber",       push_fn = "lua_pushinteger" },
    ["float"] =   { c = "float",         check_fn = "luaL_checknumber",       push_fn = "lua_pushnumber" },
    ["double"] =  { c = "double",        check_fn = "luaL_checknumber",       push_fn = "lua_pushnumber" },
    ["string"] =  { c = "const char *",  check_fn = "luaL_checkstring",       push_fn = "lua_pushstring" },
    ["pointer"] = { c = "void *",        check_fn = "_checklightuserdata",    push_fn = "lua_pushlightuserdata" },
}


local function get_register_fn_name(NS)  return "register_" .. NS.name .. "_api" end

local function get_escaped_string(str)
    if str == '\\' then return '\\\\' end
    if str == '"' then return '\\"' end
    return str
end

local function get_local_enum_name(enumname, enumval)
    local function map_string(str)
        str = str:gsub("'", "TICK")
        str = str:gsub("`", "BACKTICK")
        str = str:gsub(",", "COMMA")
        str = str:gsub(";", "SEMICOLON")
        str = str:gsub("%.", "PERIOD")
        str = str:gsub("-", "DASH")
        str = str:gsub("/", "SLASH")
        str = str:gsub("\\", "BACKSLASH")
        str = str:gsub("=", "EQUAL")
        str = str:gsub("%[", "OPEN_BRACKET")
        str = str:gsub("]", "CLOSE_BRACKET")
        return str
    end

    -- local namemap = {
    --     [''] = '' -- TAKE FORM PREV CODE
    -- }
    return  "_" .. enumname:upper() .. "_" .. map_string(enumval):upper()
end

local function get_include_guard_name(filename) return "_" .. filename:gsub("[.]","_"):upper() .. "_INCLUDED_" end

local function is_type_enum(NS, name)
    for _, v in ipairs(NS.enums) do
        if v.name == name then return true end
    end
    return false
end

local function is_type_list(NS, name)
    for _, v in ipairs(NS.lists) do
        if v.name == name then return true end
    end
    return false
end

local function get_list_item_type(NS, name)
    if not is_type_list(NS, name) then error(name .. " is not a list.") end
    local ret
    for _, v in ipairs(NS.lists) do
        if v.name == name then ret = v.item_type end
    end
    return ret
end

local function get_list_item_max_count(NS, name)
    if not is_type_list(NS, name) then error(name .. " is not a list.") end
    local ret
    for _, v in ipairs(NS.lists) do
        if v.name == name then ret = v.max_count end
    end
    return ret
end

local function get_c_typed_var(NS, t, varname, is_ptr, is_arglist)
    local ret

    local is_enum =  is_type_enum(NS, t)
    local is_list = is_type_list(NS, t)

    if CTypeMaps[t] then
        ret = CTypeMaps[t].c
    elseif is_enum then
        if is_arglist then
            ret = "int"
        else
            ret = "const char *" .. varname .."_str; " .. "int"
        end
    elseif is_list then
        if is_arglist then
            ret =  get_list_item_type(NS, t) .. " *"  .. varname ..", " .. "size_t " .. varname .. "_count"
        else
            -- ret =  get_list_item_type(NS, t) .. " *"  .. varname .."; " .. "size_t " .. varname .. "_count"
            ret = get_list_item_type(NS, t) .. " " .. varname .. "[" .. get_list_item_max_count(NS, t) .. "] = {0}" .."; " .. "size_t " .. varname .. "_count"
        end
    else
        --ret =  "__" .. t .. "_UNKNOWN_";
        error("Unknown t: " .. t)
    end

    if not is_list then -- the variable name for is_list case is handled above (since it needs a pointer and a counter name)
        if ret:sub(-1) ~= "*" then -- const char *, void *, ...
            ret = ret .. " "
        end
        if is_ptr then ret = ret .. "*" end
        ret = ret .. varname
    end

    return ret
end

local function get_c_typed_args_and_rets(NS, fn, out_kind)
    local out = ""
    local sep = ";"
    local ret_is_ptr = false
    if out_kind == "arglist" then
        sep = ", "
        ret_is_ptr = true
    elseif out_kind == "declare" then
        sep = "; "
        ret_is_ptr = false
    else
        error("Unknown out_kind in typed args: " .. out_kind);
    end
    if #fn.args > 0  or #fn.rets > 0 then
        -- args
        for _i, a in ipairs(fn.args) do
            out = out .. get_c_typed_var(NS, a.type, a.name, false, out_kind=="arglist")
            -- ? set pointers to null
            -- if a.type == "string" and  out_kind=="declare" then
            --     out = out .. " = {0};"
            -- end
            if _i < #fn.args or #fn.rets > 0 then out = out .. sep end
        end
        -- rets
        for _i, r in ipairs(fn.rets) do
            out = out .. get_c_typed_var(NS, r.type, r.name, ret_is_ptr, out_kind=="arglist")
            -- ? set pointers to null
            if r.type == "string" and  out_kind=="declare" then
                out = out .. " = {0}"
            end
            if _i < #fn.rets then out = out .. sep end
        end
    end
    if out_kind == "arglist" and #fn.args == 0 and #fn.rets == 0 then
        out = out .. "void"
    end
    return out
end


--***********************************************************************************************************************************
--***********************************************************************************************************************************
--***********************************************************************************************************************************


local function  get_gen_func_base(NS, fn)
    local out = ""
    out = out .. "static int api_" .. fn.name .. "(lua_State *L) { // arity: " .. #fn.args .. " => " .. #fn.rets .. "\n"
    out = out .. SPC .. "(void)L; int err = 0;\n"

    if #fn.args > 0  or #fn.rets > 0 then
        out = out .. SPC
        out = out .. get_c_typed_args_and_rets(NS, fn, "declare");
        out = out .. ";\n"
    end

    ------ out = out .. SPC .. "// GET THE ARGS OUT OF THE STACK\n"
    for _i, a in ipairs(fn.args) do
        if is_type_list(NS, a.type) then
            local item_type = get_list_item_type(NS, a.type)
            -- out = out .. SPC .. "// BEGIN LIST : " .. item_type .. "\n"
            out = out .. SPC .. a.name .. "_count = " .. "_checktable_getcount(L, " .. _i .. ");\n"
            -- out = out .. SPC .. item_type .. " *" .. a.name .. " = alloca(sizeof(" .. item_type ..") * " .. a.name .. "_count);\n"
            -- out = out .. SPC .. a.name  .. " = {0};\n"
            out = out .. SPC .. "if (" .. a.name .. "_count > " ..  get_list_item_max_count(NS, a.type) .. ") {\n"
            out = out .. SPC2 .. 'fprintf(stderr, "Exceeded max count for list: expected: %d but got: %d\\n", ' .. get_list_item_max_count(NS, a.type) .. ', (int)' ..  a.name .. "_count"  .. '); \n'
            out = out .. SPC2 .. "lua_error(L);\n"
            out = out .. SPC .. "}\n"
            out = out .. SPC .. "for (size_t i=1; i<=" .. a.name .. "_count; i++) {\n"
            out = out .. SPC2 .. "lua_rawgeti(L, " .. _i .. ", i" .. ");\n"
            out = out .. SPC2 .. item_type .. " " .. a.name .. "_v = " .. CTypeMaps[item_type].check_fn .. "(L, -1);\n"
            out = out .. SPC2 .. "lua_pop(L, 1);\n"
            out = out .. SPC2 .. a.name .. "[i - 1] = " .. a.name .. "_v;\n"
            out = out .. SPC .. "}\n"

        elseif is_type_enum(NS, a.type) then
            -- get string out of stack
            out = out .. SPC .. a.name .. "_str = " .. CTypeMaps["string"].check_fn .. "(L, " .. _i .. ");\n"
            out = out .. SPC .. a.name .. " = enumstring_to_int(" .. NS.name .. "_" .. a.type  .. "_strings, " .. a.name .. "_str);\n"
        elseif not CTypeMaps[a.type] then
            error("Unknown type: " .. a.type)
        else
            out = out .. SPC .. a.name .. " = " .. CTypeMaps[a.type].check_fn .. "(L, " .. _i .. ");\n"
        end
    end


    ------ out = out .. SPC .. "// CALL IMPL\n"
    out = out .. SPC .. "err = _" .. fn.name .. "("
    -- args
    for _i, a in ipairs(fn.args) do
        out = out .. a.name
        if is_type_list(NS, a.type) then -- add count variable in list special case
            out = out .. ", " .. a.name .. "_count"
        end
        if _i < #fn.args or #fn.rets > 0 then out = out .. ", " end
    end
    -- rets
    for _i, r in ipairs(fn.rets) do
        -- Note: return values are returned in the param list with a pointer
        out = out .. "&" .. r.name
        if _i < #fn.rets then out = out .. ", " end
    end
    out = out .. ");\n"


    ------ out = out .. SPC .. "// PUT RETS INTO THE STACK\n"
    for _i, r in ipairs(fn.rets) do
        if not CTypeMaps[r.type] then
            error("Unknown return type: " .. r.type)
        end
        out = out .. SPC .. CTypeMaps[r.type].push_fn .. "(L, " .. r.name .. ");\n"
    end

    out = out .. SPC .. "(void)err; // TODO: handle when err is not 0\n"
    out = out .. SPC .. "return " .. #fn.rets .. "; // number of values returned in the stack\n"
    out = out .. "}\n"
    return out
end


--***********************************************************************************************************************************
--***********************************************************************************************************************************
--***********************************************************************************************************************************


local function get_gen_func_impl(NS, fn)
    local out = ""
    out = out .. "static inline int _" .. fn.name .. "("
    out = out .. get_c_typed_args_and_rets(NS, fn, "arglist");
    out = out .. ") {\n"
    -- func body
    if #fn.args > 0 then
        -- add (void)s for each arg (even if we end up using them later)
        out = out .. SPC
        for _i, a in ipairs(fn.args) do
            out = out .."(void)" .. a.name .. "; "
            if is_type_list(NS, a.type) then
                out = out .."(void)" .. a.name .. "_count; "
            end
        end
        out = out -- .. "\n"
    end
    out = out .. "int err = 0;\n"
    out = out .. SPC .. "err = NATIVEFN_" .. fn.name .. "("
    for _i, a in ipairs(fn.args) do
        out = out .. a.name
        if is_type_list(NS, a.type) then -- add count variable in list special case
            out = out .. ", " .. a.name .. "_count"
        end
        if _i < #fn.args or #fn.rets > 0 then out = out .. ", " end
    end
    for _i, r in ipairs(fn.rets) do
        out = out .. r.name
        if _i < #fn.rets then out = out .. ", " end
    end
    out = out .. ");\n"
    out = out .. SPC .. "return err;\n"
    out = out .. "}\n"
    return out
end


--***********************************************************************************************************************************
--***********************************************************************************************************************************
--***********************************************************************************************************************************


local function gen_api_base(NS, filename, header_file_name, impl_file_name)
    print("---> gen_api_base")
    local out = "// generated -- do not edit\n"
    out = out .. "// ==== begin: " .. filename .. " ====\n\n"
    ---------------------------------------------------------------------------------------------------
    out = out .. "#include <lua.h>\n"
    out = out .. "#include <lauxlib.h>\n"
    out = out .. "#include <stdbool.h>\n"
    -- out = out .. "#include <alloca.h>\n"
    out = out .. '#include "' .. header_file_name .. '"\n'
    out = out .. '#include "' .. impl_file_name .. '"\n'
    out = out .. "\n"
    ---------------------------------------------------------------------------------------------------
    out = out .. gen_c_helper_code

    -- ENUMS
    for _i, x in ipairs(NS.enums) do
        -- EnumStrInt lyte_UniformType_strings[] = {
        out = out .. "EnumStrInt " .. NS.name .. "_" .. x.name .. "_strings[] = {\n"
        for _j, y in ipairs(x.values) do
            out = out .. SPC .. '{"' .. get_escaped_string(y) .. '", ' ..  get_local_enum_name(x.name, y) .. '},\n'
        end
        out = out .. SPC .. "{NULL, -1},\n"
        out = out .. "};\n"
    end
    out = out .. "\n"

    -- FUNCTIONS
    for _i, x in ipairs(NS.functions) do
        out = out .. get_gen_func_base(NS, x)
    end
    out = out .. "\n"

    ---------------------------------------------------------------------------------------------------

    -- Lua function names to native funcs map (used in registering)
    out = out .. "static const struct luaL_Reg " .. NS.name .. "_api_functions[] = {\n"
    for _i, x in ipairs(NS.functions) do
        out = out .. SPC .. '{"' .. x.name  ..  '", api_' .. x.name .. "},\n"
    end
    out = out .. SPC .. '{NULL, NULL} // sentinel\n'
    out = out .. "};\n"

    -- Exported "register" function
    out = out .. "\nint " .. get_register_fn_name(NS) .. "(lua_State *L) {\n"
    out = out .. SPC .. 'luaL_register(L, "' .. NS.name .. '", ' ..  NS.name .. "_api_functions);\n"
    out = out .. SPC .. "lua_settop(L, 0);\n"
    out = out .. SPC .. "return 0;\n"
    out = out .. "} \n"

    ---------------------------------------------------------------------------------------------------
    out = out .. "\n// ==== end: " .. filename .. " ====\n"

    return out
end

--***********************************************************************************************************************************
--***********************************************************************************************************************************
--***********************************************************************************************************************************

local function gen_api_impl(NS, filename)
    print("---> gen_api_impl")
    local out =  "// generated template: edit this file\n"
    local include_guard = get_include_guard_name(filename:gsub("__EDIT__", ""))
    out = out .. "#ifndef " .. include_guard .. "\n"
    out = out .. "#define " .. include_guard .. "\n\n"
    out = out .. "// This file is included in another code file directly. Do not include this as a seperate compile unit.\n"
    out = out .. "// Keep functions static so that they can be inlined if possible.\n"
    out = out .. "// ==== begin: " .. filename .. " ====\n\n"
    ---------------------------------------------------------------------------------------------------
    out = out .. impl_c_top .. "\n"

    -- FUNCTIONS
    for _i, x in ipairs(NS.functions) do
        out = out .. get_gen_func_impl(NS, x)
    end
    out = out .. "\n"


    -- ENUMS
    out = out .. "// LOCAL ENUMS. Edit values to map from local names to actual native impl values\n"
    for _i, x in ipairs(NS.enums) do
        -- doesn't need a name
        -- out = out .. "typedef enum _" .. x.name .. " {\n"
        out = out .. "enum {\n"
        for _j, y in ipairs(x.values) do
            local enum_name = get_local_enum_name(x.name, y)
            local enum_value = "NATIVEENUM" .. enum_name -- hardcoding these.. changable with simple copy paste
            out = out .. SPC .. enum_name .. " = " .. enum_value .. ", /* order: " .. _j-1 .. " string: '" ..  y .. "' */\n"
        end
        -- doesn't need a name
        -- out = out .. "} _" .. x.name .. ";\n"
        out = out .. "};\n"
    end


    ---------------------------------------------------------------------------------------------------
    out = out .. "\n// ==== end: " .. filename .. " ====\n"
    out = out .. "#endif // " .. include_guard .. "\n"
    return out
end

--***********************************************************************************************************************************
--***********************************************************************************************************************************
--***********************************************************************************************************************************

local function gen_header(NS, filename)
    print("---> gen_api_header")
    local out = "// generated -- do not edit\n"
    local include_guard = get_include_guard_name(filename)
    out = out .. "#ifndef " .. include_guard .. "\n"
    out = out .. "#define " .. include_guard .. "\n\n"
    out = out .. "// ==== begin: " .. filename .. " ====\n\n"
    ---------------------------------------------------------------------------------------------------
    out = out .. "#include <lua.h>\n"
    out = out .. "\n"
    out = out .. "int " .. get_register_fn_name(NS) .. "(lua_State *L);\n"
    ---------------------------------------------------------------------------------------------------
    out = out .. "\n// ==== end: " .. filename .. " ====\n"
    out = out .. "#endif // " .. include_guard .. "\n"
    return out
end

--***********************************************************************************************************************************
--***********************************************************************************************************************************
--***********************************************************************************************************************************

local function generate_api_native(NS, output_folder)
    print("-> begin")

    local header_file_name =  "api_" .. NS.name .. "_gen.h"
    local base_file_name =    "api_" .. NS.name .. "_gen.c"
    local impl_file_name_edit =    "api_" .. NS.name .. ".impl__EDIT__.c"
    local impl_file_name = impl_file_name_edit:gsub("__EDIT__", "")

    local header_src = gen_header(NS, header_file_name)
    local base_src = gen_api_base(NS, base_file_name, header_file_name, impl_file_name)
    local impl_src = gen_api_impl(NS, impl_file_name)

    local header_file = io.open(output_folder .. "/" .. header_file_name, "w")
    header_file:write(header_src)
    header_file:close()

    local base_file = io.open(output_folder .. "/" .. base_file_name, "w")
    base_file:write(base_src)
    base_file:close()

    local impl_file = io.open(output_folder .. "/" .. impl_file_name_edit, "w")
    impl_file:write(impl_src)
    impl_file:close()

    print("-> end")
end

return generate_api_native
