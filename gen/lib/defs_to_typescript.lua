local lyte_defs = require "defs_lyte";
local apidef = require "lib.apidef"


----------- TypeScript printer

local tab = "    "

local TS = { result = "declare "}

function TS.Type(value, name)
    -- TS.result = TS.result .. " <" .. value .. ">" .. name
    TS.result = TS.result ..  value -- .. ">" .. name
end

function TS.Dict(key, value, depth, name, tags, traverse_fn)
    -- TS.result = TS.result .. " Dict<" .. key .. "," .. value .. "> "
    -- TreePrinter.result = TreePrinter.result .. tab:rep(depth+1) .. "value: " .. value .. "\n"
    -- TS.result = TS.result .. "DICTIONARY\n"
    TS.result = TS.result .. "{[key: " .. key .. "]: "
    traverse_fn(value, TS, 0)
    TS.result = TS.result .. "}"
end

function TS.List(value, depth, name, tags, traverse_fn)
    -- TS.result = TS.result .. " List<" .. value .. "> " .. name .. "\n"
    TS.result = TS.result ..  value .. "[]"
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
    -- TS.result = TS.result .. tab:rep(depth)  .. ""
end

function TS.OneOf(choices, depth, name, tags, traverse_fn)
    -- TS.result = TS.result .. " oneof " .. name .. "\n"
    -- TS.result = TS.result .. "type " .. name .. " = "
    assert(choices)
    for i, v in ipairs(choices) do
        -- TS.result = TS.result .. tab:rep(depth+1) .. "option[" .. i .. "] ::"
        -- TS.result = TS.result .. tab:rep(depth+1) -- .. "option[" .. i .. "] ::"
        if type(v) == "table" then
            traverse_fn(v, TS, 0)
        else
            error("OneOf choices must be 'Option' values. Got: " .. type(v))
        end
        if i < #choices then
            TS.result = TS.result ..  " | "
        end
    end
    -- TS.result = TS.result  .. ";\n"
end

function TS.Function(args, rets, depth, name, tags, traverse_fn)
    assert(args); assert(rets)
    TS.result = TS.result .. tab:rep(depth)  .. "function " .. name .. "("
    for i, v in ipairs(args) do
        assert(v._name)
        assert(v.value)
        TS.result = TS.result ..  v._name  .. ": " .. v.value
        if i ~= #args then TS.result = TS.result .. ", " end
    end
    TS.result = TS.result .. "): "
    if (#rets > 0) then
        for i, v in ipairs(rets) do
            assert(v.value)
            TS.result = TS.result .. v.value
            if i ~= #rets then TS.result = TS.result .. ", " end
        end
    else
        TS.result = TS.result .. "void"
    end
    -- TS.result = TS.result .. ");\n"
end

function TS.Method(args, rets, depth, name, tags, traverse_fn)
    assert(args); assert(rets)
    TS.result = TS.result .. "("
    for i, v in ipairs(args) do
        assert(v._name)
        assert(v.value)
        TS.result = TS.result ..  v._name  .. ": " .. v.value
        if i ~= #args then TS.result = TS.result .. ", " end
    end
    TS.result = TS.result .. ") => ("
    if (#rets > 0) then
        for i, v in ipairs(rets) do
            assert(v.value)
            TS.result = TS.result .. v.value
            if i ~= #rets then TS.result = TS.result .. ", " end
        end
    else
        TS.result = TS.result .. "void"
    end
    -- TS.result = TS.result .. ");\n"
    TS.result = TS.result .. ")"
end


-- to be fixed, specify NS or Record in different functions
function TS.NS(items, depth, name, tags, traverse_fn)
    TS.result = TS.result .. "namespace " .. name .. " {\n"
    if (items) then
        for i, v in ipairs(items) do
            if (type(v) == "table") then
                -- TS.result = TS.result .. tab:rep(depth) .. (v._kind or "" ) ..  v._name
                -- TS.result = TS.result .. tab:rep(depth+1) .. (v._kind or "" ) -- ..  v._name
                -- TS.result = TS.result .. tab:rep(depth+1)  -- ..  v._name
                traverse_fn(v, TS, depth+1)
                TS.result = TS.result .. ";\n"
                -- TreePrinter.result = TreePrinter.result .. "\n"
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

                -- TreePrinter.result = TreePrinter.result .. "\n"
            else
                error("Internal (20): Unknown value type: " .. type(v) .. " for name " .. name)
            end
        end
    end
    -- TS.result = TS.result .. tab:rep(depth-1)  .. "}\n"
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

