-- Generate C code for the Lua API

local lyte_defs = require "defs_lyte";
local apidef = require "lib.apidef"

local inspect = require "lib.inspect"



local tab = "    "

-- state: "header" | "body"
local CC = {
    namespace = "",           -- namespace name (used inside definitions)
    top_enumdefs = "",        -- enums
    top_structdefs = "",      -- structs (base def)
    top_uniondefs = "",      -- unions (base def)
    top_structlifetime = "",  -- local structure init/cleanup functions
    top_structtostring = "",  -- local structure tostring function
    top_funcimpls = "",       -- function "implementations"
    top_enumstrs = "",        -- enum helpers, convert to and from string as well as string values
    open_funcs = "",          -- each api function to be made available to lua
    public_open = "",         -- public API body (like "int register_lyte_api(L) { ........... } ")
    result = "",              -- main definitions body
    top_line = [[
// GENERATED
// (c) 2023 MG
]],
    top_header_guard_open = [[

#ifndef API_GENERATED_H_INCLUDED
#define API_GENERATED_H_INCLUDED

#include <stddef.h>
#include <stdint.h>
#include <stdbool.h>

// header file: do not edit directly
// (use codegen to update this file)

]],
    top_header_guard_close = [[

#include "api.enums.h" // all the enums (possibly platform/implementation specific)

#endif  // API_GENERATED_H_INCLUDED
]],
    top_enums_header_guard_open = [[

#ifndef API_ENUMS_H_INCLUDED
#define API_ENUMS_H_INCLUDED

// lyte enums (do not add new values or change the names. changing values per implementation/platform is OK.)

]],
    top_enums_header_guard_close = [[

#endif  // API_ENUMS_H_INCLUDED
]],
    top_defs_impl = [[

// implementations: fill in the functions
// do not directly compile (i.e. add to list of C files to compile)
// this file is directly included in the API implementation and inlined

#include <stdbool.h>
#include <stdint.h>

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>
#include <assert.h>

#include "api_generated.h"

]],
    top_defs_api = [[

// api surface: do not edit directly
// (use codegen to update this file)

#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <assert.h>

#include <lua.h>
#include <lauxlib.h>

#include "api_generated.h"

#include "api.impl.c"  // inline implementations in this file

]],
    top_enumhelpers = [[
// enum helpers
typedef struct EnumStrInt {
    const char *str;
    int value;
} EnumStrInt;

static int enumstring_to_int(EnumStrInt *vals, const char *str) {
    while (vals->str && (strcmp(str, vals->str)!=0)) vals++;
    return vals->value;
}
// ---
]],
    top_unionhelpers = [[

// union helpers
]],
}




local function _ctype_is_union(v)
    if v and v._tags and v._tags.nativetype then
        return v._tags.nativetype == "union"
    end
    return false
end
local function _ctype_is_udata(v)
    if v and v._tags and v._tags.nativetype then
        return v._tags.nativetype == "udata"
    end
    return false
end
local function _ctype_save_to_registry(v)
    if v and v._tags and v._tags.nativetype then
        return v._tags.save_to_registry
    end
    return false
end
local function _ctype_is_enumstring(v)
    if v and v._tags and v._tags.nativetype then
        return v._tags.nativetype == "enumstring"
    end
    return false
end
local function _ctype_map_basetype(t)
    local c_type
    if t == "string" then c_type = "const char *"
    elseif t == "number" then c_type = "double"
    elseif t == "float" then c_type = "float"
    elseif t == "integer" then c_type = "int"
    elseif t == "boolean" then c_type = "bool"
    else c_type = t .. "_UNKNOWN_TODO"
    end
    return c_type
end
local function _ctype_type(v)
    local t = v.value
    local c_type
    if _ctype_is_udata(v) or _ctype_is_enumstring(v) or  _ctype_is_union(v) then
        c_type = t:gsub("lyte.", "")
        local prefix = CC.namespace .. "_"
        c_type = prefix .. c_type
    else c_type = _ctype_map_basetype(t)
    end
    return c_type
end
local function _get_check_fn_name(v)
    local t = v.value
    local check_fn = ""
    if _ctype_is_udata(v) then check_fn = "luaL_checkudata"
    elseif _ctype_is_union(v) then check_fn = "_get_union_" .. _ctype_type(v)
    elseif _ctype_is_enumstring(v) then check_fn = "luaL_checkstring"
    elseif t == "boolean" then check_fn = "lua_toboolean"
    elseif t == "number" then check_fn = "luaL_checknumber"
    elseif t == "float" then check_fn = "luaL_checknumber"
    elseif t == "integer" then check_fn = "luaL_checkinteger"
    elseif t == "string" then check_fn = "luaL_checkstring"
    else check_fn = t .. "CHECK_UNKNOWN"
    end
    return check_fn
end
local function _get_push_fn_name(v)
    local t = v.value
    local arg_is_udata = _ctype_is_udata(v)
    local push_fn = ""
    if (arg_is_udata) then
        push_fn = "___TODOOOOOOOOOOOOO_______"
    else
        if t == "number" then push_fn = "lua_pushnumber"
        elseif t == "integer" then push_fn = "lua_pushinteger"
        elseif t == "string" then push_fn = "lua_pushstring"
        elseif t == "boolean" then push_fn = "lua_pushboolean"
        else push_fn = t .. "PUSH_UNKNOWN"
        end
    end
    return push_fn
end
local function _luatype_type(v)
    local t = v.value
    local luatype
    if type(t) == "table" then
        if t._kind and t._kind == "list" then
            luatype = "LUA_TTABLE"
        else
            luatype = "UNKNOWN_TABLE_VAL"
        end
    elseif _ctype_is_udata(v) then
        luatype = "LUA_TUSERDATA"
    -- elseif _ctype_is_union(v) then
    --     luatype = "LUA_T????????????????????????????????????????????????"
    elseif t == "string" or _ctype_is_enumstring(v) then luatype = "LUA_TSTRING"
    elseif t == "number" or  t == "float" or  t == "integer" then luatype = "LUA_TNUMBER"
    elseif t == "boolean" then luatype = "LUA_TBOOLEAN"
    else luatype = t .. "_UNKNOWN_TODO"
    end
    return luatype
end


function CC.Type(value, name, depth)
    -- TS.result = TS.result .. " <" .. value .. ">" .. name
    CC.result = CC.result .. tab:rep(depth) ..  value  .. "^^^" .. name -- .. ">" .. name
end

function CC.Dict(key, value, depth, name, tags, traverse_fn)
    -- TS.result = TS.result .. " Dict<" .. key .. "," .. value .. "> "
    -- TreePrinter.result = TreePrinter.result .. tab:rep(depth+1) .. "value: " .. value .. "\n"
    -- TS.result = TS.result .. "DICTIONARY\n"
    -- do we need dict type?
    CC.result = CC.result .. "{[key: " .. key .. "]: "
    traverse_fn(value, CC, 0)
    CC.result = CC.result .. "}"
end


function CC.List(value, depth, name, tags, traverse_fn)
    assert(false, "Lists are not directly supported in C API gen. Try using 'OneOf'")
end

function CC.OneOf(choices, depth, name, tags, traverse_fn)
    -- TS.result = TS.result .. " oneof " .. name .. "\n"
    local u_name = CC.namespace .. "_" .. name

    CC.top_uniondefs = CC.top_uniondefs .. tab:rep(depth) .. "typedef union " .. u_name .. " {\n"
    assert(choices)
    for i, v in ipairs(choices) do
        if type(v) == "table" and v._kind == "option" then
            if type(v.value) == "string" then
                -- traverse_fn(v, CC, depth+1)
                CC.top_uniondefs = CC.top_uniondefs .. tab:rep(depth+1) .. _ctype_type(v) .. " " .. v.value:lower() .. "_val";
            else
                local lst = v.value
                assert(lst._kind == "list", "only listlike tables are supported")
                CC.top_uniondefs = CC.top_uniondefs .. tab:rep(depth+1) .. "struct { " ..  _ctype_type(lst) .. " *values; size_t count; } " .. lst.value .. "_list";
                -- traverse_fn(v, CC, depth+1)
            end
        else
            error("OneOf choices must be 'Option' values. Got: " .. type(v) .. "::" .. v.value)
        end
        -- if i < #choices then
            CC.top_uniondefs = CC.top_uniondefs ..  ";\n"
        -- end
    end
    CC.top_uniondefs = CC.top_uniondefs .. tab:rep(depth) .. " } " .. u_name .. ";\n"

    -- generate the function to 'extract' the union value out of Lua stack
    CC.top_unionhelpers = CC.top_unionhelpers .. tab:rep(depth) .. "// which will be set 0 to " .. #choices .. " for known values. -1 for error\n"
    CC.top_unionhelpers = CC.top_unionhelpers .. tab:rep(depth) .. "static inline " .. u_name .. " _get_union_" .. u_name .. "(lua_State *L, int n, int *which) {\n"
    CC.top_unionhelpers = CC.top_unionhelpers .. tab:rep(depth+1) .. u_name .. " retval = {0};\n"
    CC.top_unionhelpers = CC.top_unionhelpers .. tab:rep(depth+1) .. "int value_type = lua_type(L, n);\n"
    for i, v in ipairs(choices) do
        local luatype = _luatype_type(v)
        local is_udata = _ctype_is_udata(v)

        if i == 1 then
            CC.top_unionhelpers = CC.top_unionhelpers .. tab:rep(depth+1) .. "if (value_type == " .. luatype .. ") {\n"
        else
            CC.top_unionhelpers = CC.top_unionhelpers .. " else if (value_type == " .. luatype .. ") {\n"
        end
        if type(v.value) == "string" then
            CC.top_unionhelpers = CC.top_unionhelpers .. tab:rep(depth+2) .. "// handle " .. luatype .. "\n"
            CC.top_unionhelpers = CC.top_unionhelpers .. tab:rep(depth+2) ..  "retval." .. v.value:lower() .. "_val = "
            if is_udata then
                CC.top_unionhelpers = CC.top_unionhelpers .. '*(' .. _ctype_type(v) .. ' *) ' ..  _get_check_fn_name(v) .. '(L, n, "' .. CC.namespace .. "." .. v.value  .. '");\n'
            else
                CC.top_unionhelpers = CC.top_unionhelpers ..  _get_check_fn_name(v) .. "(L, n);\n"
            end
            CC.top_unionhelpers = CC.top_unionhelpers .. tab:rep(depth+2) .. "*which = " .. i-1 .. ";\n"
        elseif luatype == "LUA_TTABLE" then
            CC.top_unionhelpers = CC.top_unionhelpers .. tab:rep(depth+2) .. "// handle " .. _luatype_type(v) .. "\n"
            CC.top_unionhelpers = CC.top_unionhelpers .. tab:rep(depth+2) .. "*which = " .. i-1 .. ";\n"
            assert(v._kind == "option", "should be a oneof option")
            local lst = v.value
            assert(lst._kind == "list", "only listlike tables are supported")
            local max_count = lst._tags.max_count
            local val_type = lst.value
            CC.top_unionhelpers = CC.top_unionhelpers .. tab:rep(depth+2) .. "// list. item type: " .. val_type .. " max count: " .. max_count.. ";\n"
            CC.top_unionhelpers = CC.top_unionhelpers .. tab:rep(depth+2) .. "static " .. _ctype_map_basetype(val_type) .. " _buffer[" .. max_count.. "] = {0};\n"
            CC.top_unionhelpers = CC.top_unionhelpers .. tab:rep(depth+2) .. "int _count = 0;\n"
            CC.top_unionhelpers = CC.top_unionhelpers .. tab:rep(depth+2) .. "lua_pushnil(L); // needed for traversing;\n"
            CC.top_unionhelpers = CC.top_unionhelpers .. tab:rep(depth+2) .. "while (lua_next(L, -2) != 0) {\n"
            CC.top_unionhelpers = CC.top_unionhelpers .. tab:rep(depth+3) .. "_buffer[_count] = luaL_checknumber(L, -1); // value.  key if needed is at index -2\n"
            CC.top_unionhelpers = CC.top_unionhelpers .. tab:rep(depth+3) .. "_count++;\n"
            CC.top_unionhelpers = CC.top_unionhelpers .. tab:rep(depth+3) .. "lua_pop(L, 1);\n"
            CC.top_unionhelpers = CC.top_unionhelpers .. tab:rep(depth+3) .. "if (_count > " .. max_count ..') { printf("Too many items in the list. Expected: ' .. max_count ..  '\\n"); break; };\n'
            CC.top_unionhelpers = CC.top_unionhelpers .. tab:rep(depth+2) .. "}\n"
            CC.top_unionhelpers = CC.top_unionhelpers .. tab:rep(depth+2) .. "retval." .. val_type .. "_list.values = _buffer;\n"
            CC.top_unionhelpers = CC.top_unionhelpers .. tab:rep(depth+2) .. "retval." .. val_type .. "_list.count = _count;\n"

        else
            error("Unsupported table type")
        end
        CC.top_unionhelpers = CC.top_unionhelpers .. tab:rep(depth+1) .. "} "
    end
    CC.top_unionhelpers = CC.top_unionhelpers .. " else {\n"
    CC.top_unionhelpers = CC.top_unionhelpers .. tab:rep(depth+2) .. "// handle: not matches\n"
    CC.top_unionhelpers = CC.top_unionhelpers .. tab:rep(depth+2) .. "*which = -1;\n"
    CC.top_unionhelpers = CC.top_unionhelpers .. tab:rep(depth+1) .. "}\n"
    CC.top_unionhelpers = CC.top_unionhelpers .. tab:rep(depth+1) .. "return retval;\n"
    CC.top_unionhelpers = CC.top_unionhelpers .. tab:rep(depth) .. "}\n"
end

-- // handle LUA_TTABLE
-- *which = 1;
-- static float _BUF[4] = {0};
-- int _count = 0;
-- lua_pushnil(L); // needed for traversing
-- while (lua_next(L, -2) != 0) {
--     _BUF[_count] = luaL_checknumber(L, -1); // value.  key if needed is at index -2
--     _count++;
--     lua_pop(L, 1);
--     if (_count >= 4) {
--         printf("Warning: too many items in the list.");
--         break;
--     }
-- }
-- val.float_list.values = _BUF;
-- val.float_list.count = 4;



function CC.Method(args, rets, depth, name, tags, traverse_fn)
    assert(args); assert(rets)
    CC.result = CC.result .. "("
    for i, v in ipairs(args) do
        assert(v._name)
        assert(v.value)
        CC.result = CC.result ..  v._name  .. ": " .. v.value
        if i ~= #args then CC.result = CC.result .. ", " end
    end
    CC.result = CC.result .. ") => ("
    if (#rets > 0) then
        for i, v in ipairs(rets) do
            assert(v.value)
            CC.result = CC.result .. v.value
            if i ~= #rets then CC.result = CC.result .. ", " end
        end
    else
        CC.result = CC.result .. "void"
    end
    -- TS.result = TS.result .. ");\n"
    CC.result = CC.result .. ")"
end


-- Currently only a single namespace is supported
function CC.NS(items, depth, name, tags, traverse_fn)
    -- CC.result = CC.result .. "namespace " .. name .. " {\n"
    local reg_name =  name  .. "_api_functions"

    CC.namespace = name
    CC.public_open = CC.public_open .. tab:rep(depth) .. "// PUBLIC API\nint register_" .. name .. "(lua_State *L) {\n"
    CC.open_funcs = CC.open_funcs .. tab:rep(depth) .. "static const struct luaL_Reg " .. reg_name  .. "[] = {\n"
    CC.result = CC.result .. "\n\n// Handling " .. name .. " apis\n"
    if (items) then
        for i, v in ipairs(items) do
            if (type(v) == "table") then
                -- TS.result = TS.result .. tab:rep(depth) .. (v._kind or "" ) ..  v._name
                -- TS.result = TS.result .. tab:rep(depth+1) .. (v._kind or "" ) -- ..  v._name
                -- TS.result = TS.result .. tab:rep(depth+1)  -- ..  v._name
                -- traverse_fn(v, CC, depth+1)
                traverse_fn(v, CC, depth)
                CC.result = CC.result .. "\n"
                -- TreePrinter.result = TreePrinter.result .. "\n"
            else
                error("Internal (20): Unknown value type: " .. type(v) .. " for name " .. name)
            end
        end
    end
    CC.result = CC.result .. "// Done: " .. name .. "\n"

    CC.open_funcs = CC.open_funcs .. tab:rep(depth+1) .. "{NULL, NULL}, // sentinel\n"
    CC.open_funcs = CC.open_funcs .. tab:rep(depth) .. "};\n"
    CC.open_funcs = CC.open_funcs .. tab:rep(depth) .. "static int luaopen_" .. reg_name .. "(lua_State *L) {\n"
    CC.open_funcs = CC.open_funcs .. tab:rep(depth+1) .. 'luaL_register(L, "' .. name .. '", ' ..  reg_name ..  ");\n"
    CC.open_funcs = CC.open_funcs .. tab:rep(depth+1) .. "lua_settop(L, 0);\n"
    CC.open_funcs = CC.open_funcs .. tab:rep(depth+1) .. "return 0;\n"
    CC.open_funcs = CC.open_funcs .. tab:rep(depth) .. "}\n"

    -- public API surface (single function)
    CC.public_open = CC.public_open .. tab:rep(depth+1) .. "luaopen_" .. reg_name .. "(L); // register all " .. name ..  " api functions\n";
    CC.public_open = CC.public_open .. tab:rep(depth+1) .. "return 0;\n";
    CC.public_open = CC.public_open .. tab:rep(depth) .. "}\n";

    --[[
    int luaopen_lyte_direct_api(lua_State *L) {
        luaL_register(L, LYTE_DIRECT_API, lyte_direct_api_lib);
        // lua_pop(L, 1);
        return 0;
    }
    ]]
end


function CC.Alias(alias_value, depth, name, tags, traverse_fn)
    CC.result = CC.result .. tab:rep(depth) .. "// !!!***TODO: type " .. name .. " = "
    if (alias_value) then
        if (type(alias_value) == "table") then
            traverse_fn(alias_value, CC, depth)
        else
            CC.result = CC.result .. "!!!!!!!!!!!" .. alias_value;
        end
    end
end



---- RECORD ----

-- map record props and methods to lua functions
function _get_mapped_read_prop_str(v)
    local ret = "/***TODO***/"
    if v._tags then
        if v._tags.map_read then
            ret = " api_" ..  v._tags.map_read .. "(L); "
        end
    end
    return ret
end
function _get_mapped_write_prop_str(v)
    local ret =  "/***TODO***/"
    if v._tags then
        if v._tags.map_write then
            ret = " api_" ..  v._tags.map_write .. "(L); "
        end
    end
    return ret
end
function _get_mapped_method_str(v)
    local ret = "/***TODO***/"
    if v._tags then
        if v._tags.map_to then
            ret = [[ lua_getglobal(L, "]] .. CC.namespace .. [["); lua_getfield(L, -1, "]] .. v._tags.map_to .. [["); lua_remove(L, -2); ]]
        end
    end
    return ret
end

function CC.Record(items, depth, name, tags, traverse_fn)
    if tags and tags.c_api_skip then
        -- this is only usd by lyte.new_shader API which is implemented in Lua (boot library)
        return
    end

    CC.result = CC.result .. tab:rep(depth) .. "// record " .. name .. "\n"
    -- START

    local prefix = CC.namespace .. "_"


    -- struct definition (this goes to top)
    -- CC.top_structdefs = CC.top_structdefs .. tab:rep(depth) .. "typedef struct " .. prefix .. name .. " { unsigned handle; } " ..  prefix .. name  .. ";\n"
    CC.top_structdefs = CC.top_structdefs .. tab:rep(depth) .. "typedef struct " .. prefix .. name .. " { void *ptr; } " ..  prefix .. name  .. ";\n"

    -- struct cleanups (this goes to top)
    -- Note: init functions are generated through constructor functions

    CC.top_structlifetime = CC.top_structlifetime .. tab:rep(depth) .. "static inline int _impl_cleanup_" .. prefix .. name .. "(" ..  prefix .. name .. " *" .. name:lower() .. ") {\n"
    CC.top_structlifetime = CC.top_structlifetime .. tab:rep(depth + 1) .. "(void)" .. name:lower() .. ";\n"
    -- CC.top_structlifetime = CC.top_structlifetime .. tab:rep(depth+1) .. "// implementation\n"
    CC.top_structlifetime = CC.top_structlifetime .. tab:rep(depth+1) .. "int _ret = 0;\n"
    CC.top_structlifetime = CC.top_structlifetime .. tab:rep(depth+1) .. "_ret = " .. prefix .. "cleanup_"  .. name:lower() .. "(*" ..  name:lower() .. ");\n"
    CC.top_structlifetime = CC.top_structlifetime .. tab:rep(depth+1) .. "return _ret;\n"
    CC.top_structlifetime = CC.top_structlifetime .. tab:rep(depth) .. "}\n"

    CC.top_structtostring = CC.top_structtostring .. tab:rep(depth) .. "static inline const char *_impl_tostring_" .. prefix .. name .. "(" ..  prefix .. name .. " *" .. name:lower() .. ") {\n"
    CC.top_structtostring = CC.top_structtostring .. tab:rep(depth + 1) .. "(void)" .. name:lower() .. ";\n"
    -- CC.top_structtostring = CC.top_structtostring .. tab:rep(depth+1) .. "// implementation\n"
    CC.top_structtostring = CC.top_structtostring .. tab:rep(depth+1) .. 'char *_ret = "[' .. CC.namespace .. "." .. name .. ']";\n'
    CC.top_structtostring = CC.top_structtostring .. tab:rep(depth+1) .. "// _ret = " .. prefix .. name:lower() .. "_tostring(" ..  name:lower() .. ")\n"
    CC.top_structtostring = CC.top_structtostring .. tab:rep(depth+1) .. "return (const char *)_ret;\n"
    CC.top_structtostring = CC.top_structtostring .. tab:rep(depth) .. "}\n"



    -- rest goes into the body
    -- DO: key indexes
    CC.result = CC.result .. tab:rep(depth) .. "enum " .. name .. "_keys_index {\n"
    for i, v in ipairs(items) do
        CC.result = CC.result .. tab:rep(depth+1) .. "IDX_" .. name .. "_" .. v._name .. ",\n"
    end
    CC.result = CC.result .. tab:rep(depth+1) .. "IDX_COUNT_" .. name .. ",\n"
    CC.result = CC.result .. tab:rep(depth) .. "};\n"

    -- DO: key strings
    CC.result = CC.result .. tab:rep(depth) .. "static const char *" .. name .. "_keys[] = {\n"
    for i, v in ipairs(items) do
        CC.result = CC.result .. tab:rep(depth+1) .. '"' .. v._name .. '",\n'
    end
    CC.result = CC.result .. tab:rep(depth+1) .. "NULL,  // required sentinel\n"
    CC.result = CC.result .. tab:rep(depth) .. "};\n"

    -- DO: index function
    CC.result = CC.result .. tab:rep(depth) .. "static int " .. name .. "_metatable_index(lua_State *L) {\n"
    CC.result = CC.result .. tab:rep(depth + 1) .. "int key_id = luaL_checkoption(L, -1, NULL, " .. name .. "_keys" .. ");\n"
    CC.result = CC.result .. tab:rep(depth + 1) .. "lua_pop(L, 1); // remove the string key from the stack\n"
    CC.result = CC.result .. tab:rep(depth + 1) .. "switch (key_id) {\n"
    for i, v in ipairs(items) do
        assert((type(v) == "table"))
        assert(v._kind == "prop" or v._kind == "method")
        CC.result = CC.result .. tab:rep(depth+2) .. "case IDX_" .. name .. "_" .. v._name ..  ": {"
        if v._kind == "prop" then
            CC.result = CC.result .. _get_mapped_read_prop_str(v)
        elseif v._kind == "method" then
            CC.result = CC.result .. _get_mapped_method_str(v)
        end
        CC.result = CC.result .. "} break;\n"
    end
    CC.result = CC.result .. tab:rep(depth + 1) .. "}\n"
    CC.result = CC.result .. tab:rep(depth + 1) .. "return 1;\n"
    CC.result = CC.result .. tab:rep(depth) .. "}\n"

    -- DO: newindex function
    CC.result = CC.result .. tab:rep(depth) .. "static int " .. name .. "_metatable_newindex(lua_State *L) {\n"
    CC.result = CC.result .. tab:rep(depth + 1) .. "int key_id = luaL_checkoption(L, 2, NULL, " .. name .. "_keys" .. ");\n"
    CC.result = CC.result .. tab:rep(depth + 1) .. "lua_remove(L, 2); // remove the string key from the stack\n"
    CC.result = CC.result .. tab:rep(depth + 1) .. "switch (key_id) {\n"
    for i, v in ipairs(items) do
        assert((type(v) == "table"))
        assert(v._kind == "prop" or v._kind == "method")
        if v._tags and v._tags.map_write then
        CC.result = CC.result .. tab:rep(depth+2) .. "case IDX_" .. name .. "_" .. v._name ..  ": {"
            CC.result = CC.result .. _get_mapped_write_prop_str(v)
            CC.result = CC.result .. "} break;\n"
        end
    end
    -- CC.result = CC.result .. tab:rep(depth + 2) .. [[default: { luaL_error("Field '" .. v._name .. "' is not settable."); } break;]] .. "\n"
    CC.result = CC.result .. tab:rep(depth + 2) .. [[default: { luaL_error(L, "Field is not settable."); } break;]] .. "\n" -- TODO: capture field name in the error mesasge

    CC.result = CC.result .. tab:rep(depth + 1) .. "}\n"
    CC.result = CC.result .. tab:rep(depth + 1) .. "lua_settop(L, 0);\n"
    CC.result = CC.result .. tab:rep(depth + 1) .. "return 1;\n"
    CC.result = CC.result .. tab:rep(depth) .. "}\n"

    -- DO: tostring
    CC.result = CC.result .. tab:rep(depth) .. "static int " .. name .. "_metatable_tostring(lua_State *L) {\n"
    CC.result = CC.result .. tab:rep(depth+1) .. prefix .. name .. ' *'.. name:lower() .. ' = luaL_checkudata(L, 1, "' .. CC.namespace .. "." ..  name .. '");\n'
    -- CC.result = CC.result .. tab:rep(depth+1) .. '// const char *str = "[' .. CC.namespace .. '.' ..  name .. ']";\n'
    CC.result = CC.result .. tab:rep(depth+1) .. 'const char *str = _impl_tostring_' .. prefix .. name .. '(' .. name:lower() .. ');\n'
    CC.result = CC.result .. tab:rep(depth+1) .. "lua_pushstring(L, str);\n"
    CC.result = CC.result .. tab:rep(depth+1) .. "return 1;\n"
    CC.result = CC.result .. tab:rep(depth) .. "}\n"
    -- DO: gc
    CC.result = CC.result .. tab:rep(depth) .. "static int " .. name .. "_metatable_gc(lua_State *L) {\n"
    CC.result = CC.result .. tab:rep(depth+1) .. prefix .. name .. ' *' .. name:lower() .. ' = luaL_checkudata(L, 1, "' .. CC.namespace .. "." ..  name .. '");\n'
    CC.result = CC.result .. tab:rep(depth+1) .. "_impl_cleanup_" .. prefix .. name .. "(" .. name:lower() .. ");\n"
    CC.result = CC.result .. tab:rep(depth+1) .. "return 1;\n"
    CC.result = CC.result .. tab:rep(depth) .. "}\n"
    -- DO: registration
    CC.result = CC.result .. tab:rep(depth) .. "static const struct luaL_Reg " .. name .. "_metatable[] = {\n"
    CC.result = CC.result .. tab:rep(depth+1) .. '{"__index", ' .. name .. "_metatable_index },\n"
    CC.result = CC.result .. tab:rep(depth+1) .. '{"__newindex", ' .. name .. "_metatable_newindex },\n"
    CC.result = CC.result .. tab:rep(depth+1) .. '{"__tostring", ' .. name .. "_metatable_tostring },\n"
    CC.result = CC.result .. tab:rep(depth+1) .. '{"__gc", ' .. name .. "_metatable_gc },\n"
    CC.result = CC.result .. tab:rep(depth+1) .. "{NULL, NULL} // sentinel ;\n"
    CC.result = CC.result .. tab:rep(depth) .. "};\n"

    -- DO: open
    CC.result = CC.result .. tab:rep(depth) .. "static int luaopen_" .. name .. "_metatable(lua_State *L) {\n"
    CC.result = CC.result .. tab:rep(depth+1) .. 'luaL_newmetatable(L, "' .. CC.namespace .. "." .. name ..  '");\n'
    CC.result = CC.result .. tab:rep(depth+1) .. "lua_pushvalue(L, -1); // duplicates the metatable\n"
    CC.result = CC.result .. tab:rep(depth+1) .. 'lua_setfield(L, -2, "__index");\n'
    CC.result = CC.result .. tab:rep(depth+1) .. 'luaL_register(L, NULL, ' .. name .. '_metatable);\n'
    CC.result = CC.result .. tab:rep(depth+1) .. "lua_settop(L, 0);\n";
    CC.result = CC.result .. tab:rep(depth+1) .. "return 0;\n"
    CC.result = CC.result .. tab:rep(depth) .. "}\n"
    -- make sure to open the record metadata
    CC.public_open = CC.public_open .. tab:rep(depth+1) .. "luaopen_" .. name .. "_metatable(L); // register " .. name .. "'s metatable\n";


    --[[
    static int luaopen_canvas_metadata(lua_State *L) {
        luaL_newmetatable(L, "lyte.Canvas");
        lua_pushvalue(L, -1); /* duplicates the metatable */
        lua_setfield(L, -2, "__index");
        luaL_register(L, NULL, canvas_metadata);
        lua_pop(L, 1); // table
        return 0;
    }
    ]]

    -- DONE
    CC.result = CC.result .. tab:rep(depth) .. "// record " .. name .. " done\n"
end





---- FUNCTION ----



function CC.Function(args, rets, depth, name, tags, traverse_fn)
    assert(args); assert(rets)

    if tags and tags.c_api_skip then
        -- tick function for example does not need an implementation. It's implemented by the user
        -- Some functions may be implemented in Lua and specified in the API. but no C functions for these...
        return
    end

    local c_func_name = "api_" ..  name
    local c_impl_func_name;

    if tags and tags.ctor then
        c_impl_func_name = "_impl_ctor_" .. name
    else
        c_impl_func_name = "_impl_" ..  name
    end

    local c_fn_args = ""
    local c_call_args = ""
    local c_lib_call_args = ""
    local voidargs = ""

    -- DEFINE FUNCTION

    -- top line comment
        CC.result = CC.result .. tab:rep(depth)  .. "// [ "
    for i, v in ipairs(args) do CC.result = CC.result .. v.value .. " " end
    CC.result = CC.result .. " -- "
    for i, v in ipairs(rets) do CC.result = CC.result .. v.value .. " " end

    CC.result = CC.result .. " ]\n"

    -- function definiton
    CC.result = CC.result .. tab:rep(depth)  .. "static int " .. c_func_name .. "(lua_State *L) {\n"
    CC.result = CC.result ..  tab:rep(depth+1)  .. "(void)L;\n"
    if #args > 0 then CC.result = CC.result ..  tab:rep(depth+1)  .. "// arguments\n"; end
    for i, v in ipairs(args) do
        assert(v._name)
        assert(v.value)
        local arg_is_udata = _ctype_is_udata(v)
        local save_to_registry = _ctype_save_to_registry(v)
        local arg_is_enumstring = _ctype_is_enumstring(v)
        local arg_is_union = _ctype_is_union(v)
        local c_type = _ctype_type(v)
        local check_fn = _get_check_fn_name(v)


        if arg_is_union then
            CC.result = CC.result .. tab:rep(depth+1) .. "int which_" ..  v._name .. ";\n"
        end
        if arg_is_enumstring then
            CC.result = CC.result .. tab:rep(depth+1) .. "const char * ";
        else
            -- all other types
            CC.result = CC.result .. tab:rep(depth+1)  .. c_type .. " ";
        end
        -- is it a pointer?
        -- the name..
        local var_name = v._name
        local var_name_save = var_name

        if arg_is_udata then CC.result = CC.result .. "*" end

        -- enum's come in as strings. need to be converted to corresponding integer value
        if arg_is_enumstring then var_name = var_name .. "_str" end

        CC.result = CC.result .. var_name .. " = "

        if arg_is_udata then
            local lua_prefix = CC.namespace .. "."
            CC.result = CC.result .. check_fn .. [[(L, ]] .. i .. [[, "]] .. (lua_prefix .. v.value) .. [[");]]
        elseif arg_is_union then
            CC.result = CC.result .. check_fn .. [[(L, ]] .. i .. [[, &which_]] .. v._name .. [[);]]
        else
            CC.result = CC.result .. check_fn .. [[(L, ]] .. i .. [[);]]
        end
        CC.result = CC.result .. "\n"

        if arg_is_enumstring then
            -- CC.result = CC.result .. tab:rep(depth + 1) .. c_type .. "  " .. v._name .. " = " .. _get_enum_str_to_idx_fn_name(v) .. "(" .. var_name.. ")" .. ";\n";
            CC.result = CC.result .. tab:rep(depth + 1) .. c_type .. "  " .. v._name .. " = enumstring_to_int(" .. c_type  .. "_strings, " .. var_name.. ")" .. ";\n";
        end

        if save_to_registry then
            CC.result = CC.result .. tab:rep(depth + 1) .. "// save this value to registry to prevent it from being GC'd\n"
            CC.result = CC.result .. tab:rep(depth + 1) .. "lua_pushvalue(L, -1); // duplicate the object\n"
            CC.result = CC.result .. tab:rep(depth + 1) .. 'lua_setfield(L, LUA_REGISTRYINDEX, "' .. CC.namespace .. "_" .. v._name .. '_SAVE");\n'
        end

        -- cllect impl fn args
        local var_call_name = var_name_save
        if arg_is_udata then
            var_call_name = "*" .. var_call_name
        end

        c_fn_args = c_fn_args .. ", " .. c_type .. " " .. var_name_save
        c_call_args = c_call_args .. ", " .. var_call_name
        voidargs = voidargs  .. "(void)" .. var_name_save .. ";"
        c_lib_call_args = c_lib_call_args .. ", " .. var_name_save

        if arg_is_union then
            c_fn_args = c_fn_args .. ", int which_" .. var_name_save
            c_call_args = c_call_args .. ", which_" .. var_name_save
            voidargs = voidargs .. "(void)which_" .. var_name_save .. ";"
            c_lib_call_args = c_lib_call_args .. ", which_" .. var_name_save
        end

    end

    if (#rets > 0) then
        CC.result = CC.result .. "    // return variables\n";
        for i, v in ipairs(rets) do
            assert(v._name)
            assert(v.value)
            local ret_is_udata = _ctype_is_udata(v)
            local c_type = _ctype_type(v)
            local push_fn = _get_push_fn_name(v)

            CC.result = CC.result .. tab:rep(depth + 1)  .. c_type .. " ";
            -- is it a pointer?
            if ret_is_udata then CC.result = CC.result .. "*" end
            -- the name..
            CC.result = CC.result .. v._name
            if tags.ctor then
                CC.result = CC.result .. " = lua_newuserdata(L, sizeof(" .. c_type .. "));"
            else
                CC.result = CC.result .. " = {0};\n"
            end


            -- collect impl fn ret args
            local var_name = v._name
            if not ret_is_udata then
                var_name = "&" .. var_name
            end

            -- callect impl fn args
            c_fn_args = c_fn_args .. ", " .. c_type .. " *" .. v._name
            c_call_args = c_call_args .. ", " .. var_name
            voidargs = voidargs .. "(void)" .. v._name .. ";"
            c_lib_call_args = c_lib_call_args .. ", " .. v._name
        end
    end

    CC.result = CC.result ..  "\n"
    CC.result = CC.result ..  tab:rep(depth + 1) ..  "// implementation\n"

    CC.result = CC.result ..  tab:rep(depth + 1) ..  "int err = " ..  c_impl_func_name .. "(" .. c_call_args:sub(3)  .. ");\n"
    CC.result = CC.result ..  tab:rep(depth + 1) ..  "if (err != 0) {\n"
    CC.result = CC.result ..  tab:rep(depth + 2) ..    'printf("Warning:  ' .. c_func_name .. '");\n'
    CC.result = CC.result ..  tab:rep(depth + 1) ..  "}\n"

    -- TODO we decided on 1 return only. simplify this
    if (#rets > 0) then
        for i, v in ipairs(rets) do
            if not tags.ctor then
                local push_fn = _get_push_fn_name(v)
                CC.result = CC.result .. "    " .. push_fn .. [[(L, ]] .. v._name .. [[);]]
                CC.result = CC.result .. "\n"
            end
        end
    end

    if tags.ctor then
        CC.result = CC.result ..  tab:rep(depth + 1) .. "// new value already on top of the stack\n"
        CC.result = CC.result ..  tab:rep(depth + 1) .. 'luaL_getmetatable(L, "' .. CC.namespace .. "." .. rets[1].value .. '");\n'
        CC.result = CC.result ..  tab:rep(depth + 1) .. "lua_setmetatable(L, -2);\n"
    end

    CC.result = CC.result ..  tab:rep(depth + 1) .. "return " .. #rets .. ";\n}"

    --- ADD TO funcs to be opened
    CC.open_funcs = CC.open_funcs ..  tab:rep(depth+1) .. '{"' .. name .. '", ' .. c_func_name .. '},\n'

    local func_args = c_fn_args:sub(3) -- remove initial ", "
    if func_args == "" then func_args = "void" end

    local call_args = c_call_args:sub(3) -- remove initial ", "
    local call_lib_fn_name = CC.namespace .. "_" .. name
    lib_call_args = c_lib_call_args:sub(3) -- remove initial ","

    if voidargs ~= "" then voidargs = tab:rep(depth+1) .. voidargs .. "\n" end

    -- is this function a constructor?  Handle constructor
    if tags.ctor then
        local prefix = CC.namespace .. "_"
        assert(#rets > 0, "ctor funcs should return a value")
        -- local ret_obj = rets[1]
        -- local objname = ret_obj.value
        CC.top_structlifetime = CC.top_structlifetime .. tab:rep(depth) .. "static inline int " .. c_impl_func_name .. "(" -- ..  prefix .. objname .. " *obj"
        CC.top_structlifetime = CC.top_structlifetime .. func_args
        CC.top_structlifetime = CC.top_structlifetime ..  ") {\n"
        CC.top_structlifetime = CC.top_structlifetime .. voidargs
        -- CC.top_structlifetime = CC.top_structlifetime .. tab:rep(depth+1) .. "// implementation\n"
        CC.top_structlifetime = CC.top_structlifetime .. tab:rep(depth+1) .. "int _ret = 0;\n"
        CC.top_structlifetime = CC.top_structlifetime .. tab:rep(depth+1) .. "_ret = " .. call_lib_fn_name .. "(" ..  lib_call_args .. ");\n"
        CC.top_structlifetime = CC.top_structlifetime .. tab:rep(depth+1) .. "return _ret;\n"
        CC.top_structlifetime = CC.top_structlifetime .. tab:rep(depth) .. "}\n"
    else
        local prefix = "_impl_"
        CC.top_funcimpls = CC.top_funcimpls .. tab:rep(depth) .. "static inline int " ..c_impl_func_name .. "(" -- ..  prefix .. name .. " *obj"
        CC.top_funcimpls = CC.top_funcimpls .. func_args
        CC.top_funcimpls = CC.top_funcimpls ..  ") {\n"
        CC.top_funcimpls = CC.top_funcimpls .. voidargs
        -- CC.top_funcimpls = CC.top_funcimpls .. tab:rep(depth+1) .. "// implementation\n"
        CC.top_funcimpls = CC.top_funcimpls .. tab:rep(depth+1) .. "int _ret = 0;\n"
        CC.top_funcimpls = CC.top_funcimpls .. tab:rep(depth+1) .. "_ret = " .. call_lib_fn_name .. "(" ..  lib_call_args .. ");\n"
        CC.top_funcimpls = CC.top_funcimpls .. tab:rep(depth+1) .. "return _ret;\n"
        CC.top_funcimpls = CC.top_funcimpls .. tab:rep(depth) .. "}\n"
    end

end





---- ENUM ----
function _special_enum_escape(str)
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
    if str == "'" then str = "\\'" end
    if str == "\\" then str = "\\\\" end
    return str
end

function CC.Enum(choices, depth, name, tags, traverse_fn)
    local prefix = CC.namespace .. "_"
    local ctype_name = prefix .. name
    local strvals_name = prefix .. name .. "_strings"
    local count_name = (prefix .. name .. "_COUNT"):upper()

    local EnumDef = ""
    local EnumStrs = ""

    -- enum defition
    EnumDef = EnumDef .. tab:rep(depth)   .. "typedef enum " .. ctype_name .. " {\n"
    assert(choices)
    local idx = 0
    for i, v in ipairs(choices) do
        local v_enumname =  (prefix .. name .. "_" .. _special_enum_escape(v)):upper()
        EnumDef = EnumDef .. tab:rep(depth+1)  .. v_enumname .. ",// order: " .. idx  .. ", str: '" .. v  .. "'\n"
        idx = idx + 1
        -- if i < #choices then RES = RES .. " | " end
    end
    EnumDef = EnumDef .. tab:rep(depth+1)  .. count_name ..  " = " .. idx .. ",\n"
    EnumDef = EnumDef .. tab:rep(depth+1)  .. (prefix .. name .. "_FORCE_UINT32 = "):upper() .. "0x7FFFFFFF, // inspired by sokol_gfx enums\n"
    EnumDef = EnumDef .. tab:rep(depth)  .. "} " .. ctype_name

    -- string values (as ued from Lua) for the enum values (integer as used by C)
    EnumStrs = EnumStrs .. tab:rep(depth)   .. "EnumStrInt " .. strvals_name .. "[] = {\n"
    for i, v in ipairs(choices) do
        local v_enumname =  (prefix .. name .. "_" .. _special_enum_escape(v)):upper()
        local v_esc_stringname = v
        if v == '\\' then v_esc_stringname = '\\\\' end -- escape backslash
        EnumStrs = EnumStrs .. tab:rep(depth+1) .. '{"' .. v_esc_stringname .. '", ' .. v_enumname .. '},\n'
    end
    EnumStrs = EnumStrs .. tab:rep(depth+1) .. '{NULL, -1},\n'
    EnumStrs = EnumStrs .. tab:rep(depth) .. "}"

    CC.top_enumdefs = CC.top_enumdefs .. EnumDef .. ";\n";
    CC.top_enumstrs = CC.top_enumstrs .. EnumStrs .. ";\n"
end



--------------------------

apidef.traverse(lyte_defs, CC)




-- print(CC.top_line)
-- print(CC.top_defs_api)
-- print()
-- print()
-- print()
-- print()
-- print(CC.top_line)
-- print(CC.top_structdefs)
-- print(CC.top_enumdefs)
-- print()
-- print()
-- print()
-- print(CC.top_line)
-- print(CC.top_defs_impl)
-- print(CC.top_structlifetime)
-- print(CC.top_funcimpls)
-- print()
-- print()
-- print()
-- print(CC.top_enumstrs)
-- print(CC.top_enumhelpers)
-- print(CC.result)
-- print(CC.open_funcs)
-- print(CC.public_open)


-- files

local f_header = io.open("output/api_generated.h", "w")
local f_enums_header = io.open("output/api.enums.h", "w")
local f_gen_api = io.open("output/api_generated.c", "w")
local f_impl = io.open("output/api.impl.c", "w")

f_header:write(CC.top_line)
f_header:write(CC.top_header_guard_open)
f_header:write(CC.top_structdefs)
f_header:write(CC.top_uniondefs)
f_header:write(CC.top_header_guard_close)

f_enums_header:write(CC.top_line)
f_enums_header:write(CC.top_enums_header_guard_open)
f_enums_header:write(CC.top_enumdefs)
f_enums_header:write(CC.top_enums_header_guard_close)

f_gen_api:write(CC.top_line)
f_gen_api:write(CC.top_defs_api)
f_gen_api:write(CC.top_enumhelpers)
f_gen_api:write(CC.top_enumstrs)
f_gen_api:write(CC.top_unionhelpers)
f_gen_api:write(CC.result)
f_gen_api:write(CC.open_funcs)
f_gen_api:write(CC.public_open)


f_impl:write(CC.top_line)
f_impl:write(CC.top_defs_impl)
f_impl:write(CC.top_structlifetime)
f_impl:write(CC.top_structtostring)
f_impl:write(CC.top_funcimpls)


f_header:close()
f_enums_header:close()
f_gen_api:close()
f_impl:close()
