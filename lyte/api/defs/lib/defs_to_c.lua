----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------
local D = require "defs_lyte";

local inspect = require "lib.inspect"

-- text will be stored in these variables

local T_api_h = ""
local T_api_c = ""
local T_enums_h = ""
local T_impls_c = ""


-- output file names

local output_path = "output/"
local filename_api_h =   output_path .. "api_generated.h"
local filename_api_c =   output_path .. "api_generated.c"
local filename_enums_h = output_path .. "api.enums.h"
local filename_impls_c = output_path .. "api.impl.c"


-- headers/footers

local _comment_line = "//---------------------------------------------------------------------------------------\n"
local header  = "// BEGIN: This file is generated\n"
local footer = "// EOF: This file is generated\n"
local dontedit = "// -- do not edit directly use code gen --\n"

-- header texts

T_api_h = T_api_h .. header .. dontedit .. _comment_line .. "\n"
T_api_c = T_api_c .. header .. dontedit .. _comment_line .. "\n"
T_enums_h = T_enums_h .. header .. "// -- do not add new names or change names. editing _values_ is ok (keep them unique) --\n"  .. _comment_line .. "\n"
T_impls_c = T_impls_c .. header .. "// -- do not add to this file as a compilation unit. 'api_generated.c' file directly includes this file --\n"
T_impls_c = T_impls_c .. "// -- fill in actual implementations inside the static inline functions --\n" .. _comment_line .. "\n"


-- whitespace

local WHITESPACE = 4
local S = (" "):rep(WHITESPACE)
local SS = S:rep(2)
local SSS= S:rep(3)

----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------

local enums_h_top = [[
#ifndef API_ENUMS_H_INCLUDED
#define API_ENUMS_H_INCLUDED

]]


local enums_h_bottom = [[

#endif  // API_ENUMS_H_INCLUDED

]]

---

local api_h_top = [[
#ifndef API_GENERATED_H_INCLUDED
#define API_GENERATED_H_INCLUDED

#include <stddef.h>
#include <stdint.h>
#include <stdbool.h>

#include "api.enums.h"

]]


local api_h_bottom = [[

#endif  // API_GENERATED_H_INCLUDED

]]

---

local api_c_top = [[
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <assert.h>

#include <lua.h>
#include <lauxlib.h>

#include "api_generated.h"

#include "api.impl.c"  // inline implementations in this file

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

local api_c_bottom = [[

// ---

]]

---

local impls_c_top = [[
#ifndef API_IMPL_C_INCLUDED
#define API_IMPL_C_INCLUDED

#include <stdbool.h>
#include <stdint.h>

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>
#include <assert.h>

#include "api_generated.h"

// implementation specific includes here:


]]


local impls_c_bottom = [[

#endif  // API_IMPL_C_INCLUDED

]]


----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------


T_api_h = T_api_h .. "// "  .. D._name .. " api header\n\n" .. api_h_top
T_api_c = T_api_c  .. "// "  .. D._name .. " api code\n\n" .. api_c_top
T_enums_h = T_enums_h .. "//  "  .. D._name .. " api enums\n\n" .. enums_h_top
T_impls_c = T_impls_c .. "//  "  .. D._name .. " api implementations\n\n" .. impls_c_top


----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------

----------------------------------
-- helpers
----------------------------------

local function get_enum_escaped_string(name, str)
    -- these values need escapeing for lyte
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

    str = D._name .. "_" .. name  .. "_" .. str

    str = str:upper()

    return str
end


local function get_tuple_info(name)
    for _,l in ipairs(D.tuples) do
        if l._name == name then return l end
    end
    error ("Internal: tuple not found: " .. name)
end



local function get_check_fn_for_table_args(name, vk, nt, idx, tbl_name, BASIC_FN)
    local ret = "";
    if vk == "tuple" then
        local info = get_tuple_info(name)
        local cntr = "val_count_" .. idx -- different for each variable in case there's more than one tuple arg
        ret = ret .. "&(" .. nt .."){0};\n"
        ret = ret .. S .. "// TABLE_" .. vk .. "_" .. "_" .. name .. "::" .. info.value_type.nativetype .. " Idx: " .. idx .. " max: " .. info.max_count.. "\n"
        ret = ret .. S .. "if (lua_type(L, " .. idx .. [[) != LUA_TTABLE) { fprintf(stderr, "Expected table, got:%s\n", lua_typename(L, ]] .. idx ..  [[));  lua_error(L); }; // todo: push error info to stack]] .. "\n"
        ret = ret .. S .. "size_t " ..  cntr .. " = lua_objlen(L, " .. idx .. ");\n"
        ret = ret .. S .. "if (" .. cntr .. " > " .. info.max_count .. ') { printf("Warning: too many items passed in the tuple. Ignoring extras"); ' .. cntr  .. ' = ' .. info.max_count .. '; }\n';
        ret = ret .. S .. tbl_name .. "->count = " .. cntr .. ";\n"
        ret = ret .. S .. "for (size_t i = 1; i <= " .. cntr .. "; i++) {\n"
        ret = ret .. SS .. "// iterate\n"
        ret = ret .. SS .. "lua_rawgeti(L, ".. idx .. ", i);\n"
        ret = ret .. BASIC_FN("listval", -1, info.value_type, SS);
        ret = ret .. SS .. "lua_pop(L, 1);\n"
        ret = ret .. SS .. "// insert into " .. tbl_name .. "...;\n"
        ret = ret .. SS .. tbl_name .. "->data[i - 1] = listval;\n"
        ret = ret .. S .. "}\n"

    elseif vk == "list" or vk == "dict" then
        -- list and dict types are NOT supported currently in the C API. use tuples and records
        local errtxt = "// !!!! Unsupported by C API, but supported by Lua API. this function should been skipped from the C api." .. name
        ret = ret .. "NULL; " .. errtxt
        -- error(errtxt)
    else
        error("Unsupported: '" .. vk .. "', name: '" .. name .. "'")
    end
    return ret
end

--[[
from lua.h

/*
** basic types
*/
#define LUA_TNONE		(-1)

#define LUA_TNIL		0
#define LUA_TBOOLEAN		1
#define LUA_TLIGHTUSERDATA	2
#define LUA_TNUMBER		3
#define LUA_TSTRING		4
#define LUA_TTABLE		5
#define LUA_TFUNCTION		6
#define LUA_TUSERDATA		7
#define LUA_TTHREAD		8

--]]

local luatype_ids = {
    boolean = 1,
    number = 3,
    string = 4,
    table = 5,
    userdata = 7,

    -- "nil" = 0,
    -- "lightuserdata" = 2,
    -- "function" = 6,
    -- "thread" = 8,
}

local function get_check_fn_for_variant_args(name, vk, nt, idx, var_name, BASIC_FN)
    local ret = ""
    -- find the variant type
    local typ
    for _, v in ipairs(D.variants) do
        if v._name == name then typ = v break; end
    end
    -- find the type of the item at the index
    ret = ret .. "{0}; // WIP: " .. var_name .. ";\n"
    ret = ret .. S .. "int luatype_id = lua_type(L, " .. idx ..");\n"
    --ret = ret .. S .. "const char *stack_type_name = lua_typename(L, lua_type(L, " .. idx .."));\n"
    --ret = ret .. S .. var_name .. " = SPECIAL_TODO_FOR___" .. typ._kind
    for i,o in ipairs(typ.options) do
        local lt = o.value_type.luatype
        local vk = o.value_type._kind
        local ltid = luatype_ids[lt] or -1
        ret = ret .. S .. "// opt: " .. i - 1 .. " -->  " .. lt .. ", " .. ltid ..";\n"
        ret = ret .. S .. "if (luatype_id == " .. ltid .. ") {\n"
        ret = ret .. SS .. var_name .. ".which = " .. i - 1 .. ";\n"
        ret = ret .. SS .. "// TODO\n"
        ret = ret .. BASIC_FN("val" , idx, o.value_type, SS);

        local ptr = ""
        if lt == "userdata" or vk == "list" or vk == "dict" or vk == "tuple" then
            ptr = "*"
        end

        ret = ret .. SS .. var_name .. ".options." .. o._name .. " = " .. ptr .. "val;\n";
        ret = ret .. S .. "}\n"
    end
    -- iterate over all variant options to see if there's a matching type
    return "" .. ret;
end


local function get_fn_push_line(name, value_type)
    local t = value_type.luatype
    local nt = value_type.nativetype
    local pushfn = "UNKNOWN_TODO"
    if t == "boolean" then pushfn = "lua_pushboolean"
    elseif t == "number" and nt == "int" then pushfn = "lua_pushinteger"
    elseif t == "number" then pushfn = "lua_pushnumber"
    elseif t == "string" then pushfn = "lua_pushstring"
    else
        -- error("WHAT TO PUSH FOR???????????? " .. t .. "---" .. name);
    end

    return S .. pushfn .. "(L, " .. name .. ");\n"
end


local function get_check_fn_for_basic(name, idx, value_type, space)
    space = space or S

    local vk = value_type._kind
    local vn = value_type.typename
    local t = value_type.luatype
    local nt = value_type.nativetype

    local lines = ""
    local check_fn = ""

    -- handle some special cases.
    -- enum: to lua it's a string. to C it's an int
    if vk == "enum" then
    -- enum?  type retrieved from lua stack is string, but C expects an int for enum
        lines = lines .. space .. "const char *" .. name  .. "_str = luaL_checkstring(L, " .. idx .. ");\n"
    end

    -- handle some special cases.
    -- if vk == "variant" then check_fn = check_fn .. "SPECIAL_TODO_FOR_ONEOF___" .. name
    if vk == "variant" then check_fn = check_fn .. get_check_fn_for_variant_args(vn,vk, nt, idx, name, get_check_fn_for_basic)
    elseif vk == "enum" then check_fn = check_fn .. "enumstring_to_int(" .. nt .. "_strings, " .. name  .. "_str);\n"  -- on enum, return
    elseif t == "userdata" then check_fn = check_fn .. "luaL_checkudata(L, " .. idx .. ', "' .. D._name .. "." .. vn .. '");\n'
    elseif t == "boolean" then check_fn = check_fn .. "lua_toboolean"
    elseif t == "number" and nt == "int" then check_fn = "luaL_checkinteger"
    elseif t == "number" then check_fn = check_fn .. "luaL_checknumber"
    elseif t == "string" then check_fn = check_fn .. "luaL_checkstring"
    elseif t == "table" then check_fn = check_fn .. get_check_fn_for_table_args(vn,vk, nt, idx, name, get_check_fn_for_basic)
    else
        error("Unknown lua type in get_check_fn: " .. t)
    end

    if vk ~= "enum" and  vk ~= "tuple" and t ~= "userdata" and vk ~= "variant" then
         check_fn = check_fn .. "(L, " .. idx ..");\n"
    end

    local ptr = " "
    if t == "userdata" or vk == "list" or vk == "dict" or vk == "tuple" then
        ptr = " *"
    end

    lines = lines .. space .. nt .. ptr .. name .. " = " .. check_fn

    return lines
end



local function get_fn_arg_line(arg, idx)
    assert(arg._kind == "arg", "arg kind expected to be 'arg', but is '" .. arg._kind .. "' name is '" .. arg._name.. "'")

    local arg_kind = arg._kind
    local value_type = arg.value_type

    local name = arg._name

    local vk = value_type._kind
    local vn = value_type.typename
    local t = value_type.luatype
    local nt = value_type.nativetype


    local arg_line = get_check_fn_for_basic(name, idx, value_type, S);

    return arg_line
end

local function get_fn_ret_line(ret, idx, is_ctor)
    assert(ret._kind == "ret", "ret kind expected to be 'ret', but is '" .. ret._kind .. "' name is '" .. ret._name.. "'")

    local arg_kind = ret._kind
    local value_type = ret.value_type

    local name = ret._name

    local vk = value_type._kind
    local vn = value_type.typename
    local t = value_type.luatype
    local nt = value_type.nativetype

    local ret_line =  S

    ret_line = ret_line .. ret.value_type.nativetype

    ret_line = ret_line .. " "

    if is_ctor then
        ret_line = ret_line .. "*"
    end

    ret_line = ret_line .. ret._name

    if is_ctor then
        ret_line = ret_line .. " = lua_newuserdata(L, sizeof(" .. nt .. "));\n"
    else
        ret_line = ret_line ..  " = {0};\n"
    end

    return ret_line
end


----------------------------------
-- enums
----------------------------------

for _,e in ipairs(D.enums) do

    -- name (begin)
    T_enums_h = T_enums_h .. "typedef enum " .. e._nativename .. " {\n"
    T_api_c = T_api_c .. "EnumStrInt " .. e._nativename .. "_strings[] = {\n"

    -- T_api_h = T_api_h .. S .. "type " .. e._name .. " = \n"
    for ic, c in ipairs(e.choices) do
        local str = get_enum_escaped_string(e._name, c)
        T_enums_h = T_enums_h .. S .. str .. ",// order: " .. (ic - 1) .. ", str: '"  .. c .. "'\n"
        local c_esc = c
        if c_esc == "'" then c_esc = "\\'" end
        if c_esc == "\\" then c_esc = "\\\\" end
        T_api_c = T_api_c .. S .. '{"' .. c_esc .. '", ' .. str .. "},\n"
    end
    -- ...._COUNT
    T_enums_h = T_enums_h .. S .. get_enum_escaped_string(e._name, "count") .. " = " .. #e.choices .. ",\n"
    -- ...._FORCE_UINT32
    T_enums_h = T_enums_h .. S .. get_enum_escaped_string(e._name, "force_uint32") .. " = 0x7FFFFFFF, // inspired by sokol_gfx enums\n"


    -- name (end)
    T_enums_h = T_enums_h .. "} " .. e._nativename .. ";\n"
    T_api_c = T_api_c .. S .. "{NULL, -1},\n"
    T_api_c = T_api_c .. "};\n"

end


----------------------------------
-- functions
----------------------------------

for _,f in ipairs(D.functions) do
    if not f._tags.c_api_skip then
        --------------------------------------
        local is_ctor = f._tags.ctor


        local arg_ret_lst = ""
        local void_lst = ""
        local call_args = ""
        local lib_call_args = ""
        local stack_view = ""
        local arg_decls = ""
        local ret_decls = ""

        -- args
        for ia, a in ipairs(f.args) do
            arg_ret_lst = arg_ret_lst .. a.value_type.nativetype .. " " .. a._name
            local ptr = ""
            local save_ref = a._tags and a._tags.save_to_registry
            if  a.value_type.luatype == "userdata" or
                a.value_type._kind == "tuple"
                then ptr = "*"
            end
            call_args = call_args .. ptr .. a._name
            lib_call_args = lib_call_args .. a._name
            stack_view = stack_view .. " " .. a.value_type.luatype .. " "
            arg_decls = arg_decls .. get_fn_arg_line(a, ia)
            if ia < #f.args or #f.rets > 0 then
                arg_ret_lst = arg_ret_lst .. ", "
                call_args = call_args .. ", "
                lib_call_args = lib_call_args .. ", "
            end
            void_lst = void_lst .. "(void)" .. a._name .. ";"
            
            if save_ref then
                local registry_lst = ""
                registry_lst = registry_lst .. S ..  "// save this value to registry to prevent it from being GC'd\n"
                registry_lst = registry_lst .. S .. "lua_pushvalue(L, -1); // duplicate the object\n"
                registry_lst = registry_lst .. S .. 'lua_setfield(L, LUA_REGISTRYINDEX, "' .. D._name .. "_" .. a._name .. '_SAVE");\n'
                arg_decls = arg_decls .. registry_lst
            end

        end

        stack_view = stack_view .. '-- '

        -- rets
        for ir, r in ipairs(f.rets) do
            arg_ret_lst = arg_ret_lst .. r.value_type.nativetype .. " *" .. r._name
            local amp = ""
            if not is_ctor then amp = "&" end
            call_args = call_args .. amp .. r._name
            lib_call_args = lib_call_args .. r._name
            stack_view = stack_view .. " " .. r.value_type.luatype .. " "
            ret_decls = ret_decls .. get_fn_ret_line(r, ir, is_ctor)
            if ir < #f.rets then
                arg_ret_lst = arg_ret_lst .. ", "
                call_args = call_args .. ", "
                lib_call_args = lib_call_args .. ", "
            end
            void_lst = void_lst .. "(void)" .. r._name .. ";"
        end

        -- if no args, "void"
        if arg_ret_lst == "" then
            arg_ret_lst = "void"
        end

        -- api (gen'd) code
        T_api_c = T_api_c .. "// " .. f._name  .. ": [" .. stack_view .. "]"
        if is_ctor then T_api_c = T_api_c .. " (ctor: true)" end
        T_api_c = T_api_c .. "\n"
        T_api_c = T_api_c .. "static int api_" .. f._name .. "(lua_State *L) {\n"
        T_api_c = T_api_c .. S ..  "(void)L;\n"
        T_api_c = T_api_c .. arg_decls
        T_api_c = T_api_c .. ret_decls
        T_api_c = T_api_c .. S ..  "int _err = _" .. f._name .. "(" .. call_args .. ");\n"
        T_api_c = T_api_c .. S ..  "(void)_err;  // TODO: handle '_err' in case it's not 0\n"
        if is_ctor then
            -- "already pushed" just set the metatable
            T_api_c = T_api_c .. S .. "// constructed value is already on top of the stack\n"
            T_api_c = T_api_c .. S .. 'luaL_getmetatable(L, "' ..  f.rets[1].value_type.metatable .. '");\n'
            T_api_c = T_api_c .. S .. 'lua_setmetatable(L, -2);\n'
        elseif #f.rets > 0 then
            -- push functions
            for ir, r in ipairs(f.rets) do
                T_api_c = T_api_c .. get_fn_push_line(r._name, r.value_type);
            end
        end
        T_api_c = T_api_c .. S ..  "return " .. #f.rets .. "; // number of return values\n"
        T_api_c = T_api_c .. "}\n"

        -- impl code
        T_impls_c = T_impls_c .. "static inline int _" .. f._name .. "(" .. arg_ret_lst .. ") {\n"
        if void_lst ~= "" then
            T_impls_c = T_impls_c .. S .. void_lst .. "\n"
        end
        T_impls_c = T_impls_c .. S .. "int _err = 0;\n"
        T_impls_c = T_impls_c .. S .. "_err = " .. D._name .. "_" .. f._name .. "(" .. lib_call_args .. ");\n"
        T_impls_c = T_impls_c .. S .. "return _err;\n"
        T_impls_c = T_impls_c .. "}\n"

    --------------------------------------
    end -- if not f._tags.c_api_skip
end


----------------------------------
-- lists
----------------------------------

-- T_api_h = T_api_h .. S .. "// lists\n"
for _,l in ipairs(D.lists) do
    -- T_api_h = T_api_h .. S .. "type " .. l._name .. " = " ..  get_t_name(l, true) .. "\n"
    T_api_h = T_api_h .. "// List: skipped in C api for now: " .. l._name .. "\n"
end

----------------------------------
-- tuples
----------------------------------

-- T_api_h = T_api_h .. S .. "// tuples\n"
for _,t in ipairs(D.tuples) do
    local nt = t._nativename
    local value_type = t.value_type
    local vt = value_type.nativetype

    T_api_h = T_api_h .. "typedef struct " .. nt .. " { " .. vt ..  " data[" .. t.max_count .. "]; size_t count; } " .. nt .. ";\n"
end

----------------------------------
-- dicts
----------------------------------

-- T_api_h = T_api_h .. S .. "// dicts\n"
for _,d in ipairs(D.dicts) do
    -- T_api_h = T_api_h .. S .. "type " .. d._name .. " = " .. get_t_name(d, true) .. "\n"
    T_api_h = T_api_h .. "// Dict: skipped in C api for now: " .. d._name .. "\n"
end



----------------------------------
-- records
----------------------------------

-- map record props and methods to lua functions
local function _get_mapped_read_prop_str(v)
    local ret = "/***TODO***/"
    if v._tags then
        if v._tags.map_read then
            ret = " api_" ..  v._tags.map_read .. "(L); "
        end
    end
    return ret
end
local function _get_mapped_write_prop_str(v)
    local ret =  "/***TODO***/"
    if v._tags then
        if v._tags.map_write then
            ret = " api_" ..  v._tags.map_write .. "(L); "
        end
    end
    return ret
end
local function _get_mapped_method_str(v)
    local ret = "/***TODO***/"
    if v._tags then
        if v._tags.map_to then
            ret = [[ lua_getglobal(L, "]] .. D._name .. [["); lua_getfield(L, -1, "]] .. v._tags.map_to .. [["); lua_remove(L, -2); ]]
        end
    end
    return ret
end

T_api_c = T_api_c .. "\n"

-- T_api_h = T_api_h .. S .. "// records\n"
for _,r in ipairs(D.records) do
    if not r._tags.c_api_skip then
    -----------------------------------
        local name = r._name
        local nt = r._nativename

        -- do: struct
        T_api_h = T_api_h .. "typedef struct " .. nt .. " { void *ptr; } " .. nt .. ";\n"

        -- to: T_impls_c
        -- do: cleanup func
        T_impls_c = T_impls_c ..  "static inline int "  .. "_cleanup_" .. nt .. "(".. nt .. " *" .. name:lower() .. ") {\n"
        T_impls_c = T_impls_c .. S .. "(void)" .. name:lower() .. ";\n"
        T_impls_c = T_impls_c .. S .. "int _ret = 0;\n"
        T_impls_c = T_impls_c .. S .. "_ret = " .. nt ..  "_cleanup(*" ..  name:lower() .. ");\n"
        T_impls_c = T_impls_c .. S .. "return _ret;\n"
        T_impls_c = T_impls_c .. "}\n"
        -- do: tostring func
        T_impls_c = T_impls_c .. "static inline const char *" .. "_tostring_" .. nt  .. "(" .. nt .. " *" .. name:lower() .. ") {\n"
        T_impls_c = T_impls_c .. S .. "(void)" .. name:lower() .. ";\n"
        T_impls_c = T_impls_c .. S .. 'char *_ret = "[' .. D._name .. "." .. name .. ']";\n'
        T_impls_c = T_impls_c .. S .. "// _ret = " .. nt .. "_tostring(*" ..  name:lower() .. ")\n"
        T_impls_c = T_impls_c .. S .. "return (const char *)_ret;\n"
        T_impls_c = T_impls_c .. S .. "}\n"

        -- to: T_api_c (all the rest of records)

        -- key indexes (enum)
        T_api_c = T_api_c
        T_api_c = T_api_c .. "enum " .. name .. "_keys_index {\n"
        for i, v in ipairs(r.fields) do
            T_api_c = T_api_c .. S .. "IDX_" .. name .. "_" .. v._name .. ",\n"
        end
        for i, v in ipairs(r.methods) do
            T_api_c = T_api_c .. S .. "IDX_" .. name .. "_" .. v._name .. ",\n"
        end
        T_api_c = T_api_c .. S .. "IDX_COUNT_" .. name .. ",\n"
        T_api_c = T_api_c .. "};\n"
        -- key strings
        T_api_c = T_api_c .. "static const char *" .. name .. "_keys[] = {\n"
        for i, v in ipairs(r.fields) do
            T_api_c = T_api_c .. S .. '"' .. v._name .. '",\n'
        end
        for i, v in ipairs(r.methods) do
            T_api_c = T_api_c .. S .. '"' .. v._name .. '",\n'
        end
        T_api_c = T_api_c .. S ..  "NULL,  // required sentinel\n"
        T_api_c = T_api_c .. "};\n"

        -- do: index function
         T_api_c = T_api_c .. "static int " .. name .. "_metatable_index(lua_State *L) {\n"
         T_api_c = T_api_c .. S .. "int key_id = luaL_checkoption(L, -1, NULL, " .. name .. "_keys" .. ");\n"
         T_api_c = T_api_c .. S .. "lua_pop(L, 1); // remove the string key from the stack\n"
         T_api_c = T_api_c .. S .. "switch (key_id) {\n"
        for i, v in ipairs(r.fields) do
            T_api_c = T_api_c .. SS .. "case IDX_" .. name .. "_" .. v._name ..  ": {"
            T_api_c = T_api_c .. _get_mapped_read_prop_str(v)
            T_api_c = T_api_c .. "} break;\n"
        end
        for i, v in ipairs(r.methods) do
            T_api_c = T_api_c .. SS .. "case IDX_" .. name .. "_" .. v._name ..  ": {"
            T_api_c = T_api_c .. _get_mapped_method_str(v)
            T_api_c = T_api_c .. "} break;\n"
        end
        T_api_c = T_api_c .. S .. "}\n"
        T_api_c = T_api_c .. S .. "return 1;\n"
        T_api_c = T_api_c .. "}\n"

        -- do: newindex function
        T_api_c = T_api_c .. "static int " .. name .. "_metatable_newindex(lua_State *L) {\n"
        T_api_c = T_api_c .. S .. "int key_id = luaL_checkoption(L, 2, NULL, " .. name .. "_keys" .. ");\n"
        T_api_c = T_api_c .. S .. "lua_remove(L, 2); // remove the string key from the stack\n"
        T_api_c = T_api_c .. S .. "switch (key_id) {\n"
        for i, v in ipairs(r.fields) do
            if v._tags and v._tags.map_write then
                T_api_c = T_api_c .. SS .. "case IDX_" .. name .. "_" .. v._name ..  ": {"
                T_api_c = T_api_c .. _get_mapped_write_prop_str(v)
                T_api_c = T_api_c .. "} break;\n"
            end
        end
        T_api_c = T_api_c .. SS .. [[default: { luaL_error(L, "Field is not settable."); } break;]] .. "\n" -- TODO: capture field name in the error mesasge
        T_api_c = T_api_c .. S .. "}\n"
        T_api_c = T_api_c .. S .. "lua_settop(L, 0);\n"
        T_api_c = T_api_c .. S .. "return 1;\n"
        T_api_c = T_api_c .. "}\n"

        -- do: tostring
        T_api_c = T_api_c .. "static int " .. name .. "_metatable_tostring(lua_State *L) {\n"
        T_api_c = T_api_c .. S .. nt .. ' *'.. name:lower() .. ' = luaL_checkudata(L, 1, "' .. D._name .. "." ..  name .. '");\n'
        T_api_c = T_api_c .. S .. 'const char *str = _tostring_' .. nt .. '(' .. name:lower() .. ');\n'
        T_api_c = T_api_c .. S .. "lua_pushstring(L, str);\n"
        T_api_c = T_api_c .. S .. "return 1;\n"
        T_api_c = T_api_c .. "}\n"
        -- do: gc
        T_api_c = T_api_c .. "static int " .. name .. "_metatable_gc(lua_State *L) {\n"
        T_api_c = T_api_c .. S .. nt .. ' *' .. name:lower() .. ' = luaL_checkudata(L, 1, "' .. D._name .. "." ..  name .. '");\n'
        T_api_c = T_api_c .. S .. "_cleanup_" .. nt .. "(" .. name:lower() .. ");\n"
        T_api_c = T_api_c .. S .. "return 1;\n"
        T_api_c = T_api_c .. "}\n"
        -- do: registration
        T_api_c = T_api_c .. "static const struct luaL_Reg " .. name .. "_metatable[] = {\n"
        T_api_c = T_api_c .. S .. '{"__index", ' .. name .. "_metatable_index },\n"
        T_api_c = T_api_c .. S .. '{"__newindex", ' .. name .. "_metatable_newindex },\n"
        T_api_c = T_api_c .. S .. '{"__tostring", ' .. name .. "_metatable_tostring },\n"
        T_api_c = T_api_c .. S .. '{"__gc", ' .. name .. "_metatable_gc },\n"
        T_api_c = T_api_c .. S .. "{NULL, NULL} // sentinel ;\n"
        T_api_c = T_api_c .. "};\n"
        -- do: open
        T_api_c = T_api_c .. "static int luaopen_" .. name .. "_metatable(lua_State *L) {\n"
        T_api_c = T_api_c .. S .. 'luaL_newmetatable(L, "' .. D._name .. "." .. name ..  '");\n'
        T_api_c = T_api_c .. S .. "lua_pushvalue(L, -1); // duplicates the metatable\n"
        T_api_c = T_api_c .. S .. 'lua_setfield(L, -2, "__index");\n'
        T_api_c = T_api_c .. S .. 'luaL_register(L, NULL, ' .. name .. '_metatable);\n'
        T_api_c = T_api_c .. S .. "lua_settop(L, 0);\n";
        T_api_c = T_api_c .. S .. "return 0;\n"
        T_api_c = T_api_c .. "}\n"


    -----------------------------------
    -- DONE
    end
end

T_api_c = T_api_c .. "\n";


----------------------------------
-- variants
----------------------------------


for _,o in ipairs(D.variants) do
    local nt = o._nativename

    T_api_h = T_api_h .. "typedef struct " .. nt .. " {\n"
    T_api_h = T_api_h .. S .. "int which;\n"
    T_api_h = T_api_h .. S .. "union {\n"

    for _, opt in ipairs(o.options) do
        T_api_h = T_api_h .. SS .. opt.value_type.nativetype .. " " .. opt._name .. ";\n"
    end


    T_api_h = T_api_h .. S .. "} options;\n"
    T_api_h = T_api_h .. "} " .. nt .. ";\n"
end


-- lua_reg
local reg_name = D._name .. "_api_functions"
T_api_c = T_api_c .. "static const struct luaL_Reg " .. reg_name .."[] = {"

for _,f in ipairs(D.functions) do
    if not f._tags.c_api_skip then
        T_api_c = T_api_c .. S .. '{"' ..  f._name  .. '", ' .. "api_" .. f._name  .. '},\n'
    end
end

T_api_c = T_api_c .. S .. "{NULL, NULL}, // sentinel\n"
T_api_c = T_api_c .. "};\n"


T_api_c = T_api_c .. "static int luaopen_" .. reg_name .. "(lua_State *L) {\n"
T_api_c = T_api_c .. S .. 'luaL_register(L, "' .. D._name .. '", ' ..  reg_name ..  ");\n"
T_api_c = T_api_c .. S .. "lua_settop(L, 0);\n"
T_api_c = T_api_c .. S .."return 0;\n"
T_api_c = T_api_c .. "}\n"

T_api_c = T_api_c .. "\n"

-- registration!

T_api_c = T_api_c .. "int register_" .. D._name .. "(lua_State *L) {\n"

T_api_c = T_api_c .. S .. "luaopen_" .. reg_name .. "(L);\n"

for _,r in ipairs(D.records) do
    if not r._tags.c_api_skip then
        T_api_c = T_api_c .. S .. "luaopen_" .. r._name .. "_metatable(L);\n"
    end
end

T_api_c = T_api_c .. S .. "return 0;\n"
T_api_c = T_api_c .. "}\n"

----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------



----------------------------------
-- assemble
----------------------------------

T_api_h = T_api_h .. api_h_bottom .. _comment_line .. footer
T_api_c = T_api_c .. api_c_bottom .._comment_line .. footer
T_enums_h = T_enums_h .. enums_h_bottom .. _comment_line .. footer
T_impls_c = T_impls_c .. impls_c_bottom .. _comment_line .. footer


----------------------------------
-- write to files
----------------------------------

local f_api_h = io.open(filename_api_h, "w")
local f_api_c = io.open(filename_api_c, "w")
local f_enums_h = io.open(filename_enums_h, "w")
local f_impls_c =  io.open(filename_impls_c, "w")

f_api_h:write(T_api_h)
f_api_c:write(T_api_c)
f_enums_h:write(T_enums_h)
f_impls_c:write(T_impls_c)

f_api_h:close()
f_api_c:close()
f_enums_h:close()
f_impls_c:close()

return

----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------
