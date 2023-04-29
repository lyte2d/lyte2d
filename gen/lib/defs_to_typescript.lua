local lyte_defs = require "defs_lyte";
local apidef = require "lib.apidef"

----------- TypeScript printer

local function lua_map(t)
    if t == "float" or t == "integer" then
        return "number"
    else
        return t
    end
end

local tab = "    "

local TS = { result = "declare "}

function TS.Type(value, name, depth)
    TS.result = TS.result ..  lua_map(value)
end

function TS.Dict(key, value, depth, name, tags, traverse_fn)
    TS.result = TS.result .. "{[key: " .. key .. "]: "
    traverse_fn(value, TS, 0)
    TS.result = TS.result .. "}"
end

function TS.List(value, depth, name, tags, traverse_fn)
    TS.result = TS.result ..  lua_map(value.value) .. "[]"
end

function TS.Enum(choices, depth, name, tags, traverse_fn)
    TS.result = TS.result .. tab:rep(depth)   .. "type " .. name .. " = "
    assert(choices)
    for i, v in ipairs(choices) do
        if v == "'" then v = "\\'" end
        if v == "\\" then v = "\\\\" end
        TS.result = TS.result  .. "'" .. v .. "' "
        if i < #choices then TS.result = TS.result .. " | " end
    end
end

function TS.OneOf(choices, depth, name, tags, traverse_fn)
    TS.result = TS.result ..  tab:rep(depth) .. "type " .. name .. " = "
    assert(choices)
    for i, v in ipairs(choices) do
        if type(v) == "table" then
            traverse_fn(v, TS, 0)
        else
            error("OneOf choices must be 'Option' values. Got: " .. type(v))
        end
        if i < #choices then
            TS.result = TS.result ..  " | "
        end
    end
end

function TS.Function(args, rets, depth, name, tags, traverse_fn)
    assert(args); assert(rets)
    TS.result = TS.result .. tab:rep(depth)  .. "function " .. name .. "("
    for i, v in ipairs(args) do
        assert(v._name)
        assert(v.value)
        TS.result = TS.result ..  v._name  .. ": " .. lua_map(v.value)
        if i ~= #args then TS.result = TS.result .. ", " end
    end
    TS.result = TS.result .. "): "
    if (#rets > 0) then
        for i, v in ipairs(rets) do
            assert(v.value)
            TS.result = TS.result .. lua_map(v.value)
            if i ~= #rets then TS.result = TS.result .. ", " end
        end
    else
        TS.result = TS.result .. "void"
    end
end

function TS.Method(args, rets, depth, name, tags, traverse_fn)
    assert(args); assert(rets)
    TS.result = TS.result .. "("
    for i, v in ipairs(args) do
        assert(v._name)
        assert(v.value)
        TS.result = TS.result ..  v._name  .. ": " .. lua_map(v.value)
        if i ~= #args then TS.result = TS.result .. ", " end
    end
    TS.result = TS.result .. ") => "
    if (#rets > 0) then
        for i, v in ipairs(rets) do
            assert(v.value)
            TS.result = TS.result .. lua_map(v.value)
            if i ~= #rets then TS.result = TS.result .. ", " end
        end
    else
        TS.result = TS.result .. "void"
    end
end


function TS.NS(items, depth, name, tags, traverse_fn)
    TS.result = TS.result .. "namespace " .. name .. " {\n"
    if (items) then
        for i, v in ipairs(items) do
            if (type(v) == "table") then
                traverse_fn(v, TS, depth+1)
                TS.result = TS.result .. "\n"
            else
                error("Internal (20): Unknown value type: " .. type(v) .. " for name " .. name)
            end
        end
    end
    TS.result = TS.result .. tab:rep(depth-1)  .. "}\n"
end

function TS.Record(items, depth, name, tags, traverse_fn)
    TS.result = TS.result .. tab:rep(depth) .. "interface " .. name .. " {\n"
    if (items) then
        for i, v in ipairs(items) do
            if (type(v) == "table") then
                TS.result = TS.result .. tab:rep(depth+1) .. v._name .. ": "
                traverse_fn(v, TS, depth)
                TS.result = TS.result .. ";\n"
            else
                error("Internal (20): Unknown value type: " .. type(v) .. " for name " .. name)
            end
        end
    end
    TS.result = TS.result .. tab:rep(depth)  .. "}"
end

function TS.Alias(alias_value, depth, name, tags, traverse_fn)
    TS.result = TS.result .. tab:rep(depth) .. "type " .. name .. " = "
    if (alias_value) then
        traverse_fn(alias_value, TS, depth)
    end
end

apidef.traverse(lyte_defs, TS)

print(TS.result)

