local lyte_defs = require "defs_lyte";
local apidef = require "lib.apidef"


----------- TEST PRINTER (TREE)

local tab = "    "

local TreePrinter = { result = ""}

function TreePrinter.Type(value, name)
    TreePrinter.result = TreePrinter.result .. " <" .. value .. "> " .. name .. "\n"
end

function TreePrinter.Dict(key, value, depth, name, tags, traverse_fn)
    TreePrinter.result = TreePrinter.result .. " Dict<" .. key .. "," -- .. value .. "> " .. name .. "\n"
    traverse_fn(value, TreePrinter, 0)
    TreePrinter.result = TreePrinter.result  .. "> " .. name .. "\n"
    -- TreePrinter.result = TreePrinter.result .. tab:rep(depth+1) .. "value: " .. value .. "\n"
end

function TreePrinter.List(value, depth, name, tags, traverse_fn)
    TreePrinter.result = TreePrinter.result .. " List<" .. value .. "> " .. name .. "\n"
end

function TreePrinter.Enum(choices, depth, name, tags, traverse_fn)
    TreePrinter.result = TreePrinter.result .. " enum\n"
    assert(choices)
    for i, v in ipairs(choices) do
        TreePrinter.result = TreePrinter.result .. tab:rep(depth+1) .. "choice[" .. i .. "] :: " .. v .. "\n"
    end
end

function TreePrinter.OneOf(choices, depth, name, tags, traverse_fn)
    TreePrinter.result = TreePrinter.result .. " oneof " .. name .. "\n"
    assert(choices)
    for i, v in ipairs(choices) do
        TreePrinter.result = TreePrinter.result .. tab:rep(depth+1) .. "option[" .. i .. "] ::"
        if type(v) == "table" then
            traverse_fn(v, TreePrinter, depth+1)
        else
            error("OneOf choices must be 'Option' values. Got: " .. type(v))
        end
    end
end

function TreePrinter.Function(args, rets, depth, name, tags, traverse_fn)
    assert(args); assert(rets)
    TreePrinter.result = TreePrinter.result .. " function " .. name .. "\n"
    for i, v in ipairs(args) do
        assert(v._name)
        assert(v.value)
        TreePrinter.result = TreePrinter.result .. tab:rep(depth+1) .. "arg[" .. i .. "] " .. v._name  .. " :: " .. v.value .. "\n"
    end
    for i, v in ipairs(rets) do
        assert(v.value)
        TreePrinter.result = TreePrinter.result .. tab:rep(depth+1) .. "ret[" .. i .. "] :: " .. v.value .. "\n"
    end
end

function TreePrinter.Method(args, rets, depth, name, tags, traverse_fn)
    assert(args); assert(rets)
    TreePrinter.result = TreePrinter.result .. " method " .. name .. "\n"
    for i, v in ipairs(args) do
        assert(v._name)
        assert(v.value)
        TreePrinter.result = TreePrinter.result .. tab:rep(depth+1) .. "arg[" .. i .. "] " .. v._name  .. " :: " .. v.value .. "\n"
    end
    for i, v in ipairs(rets) do
        assert(v.value)
        TreePrinter.result = TreePrinter.result .. tab:rep(depth+1) .. "ret[" .. i .. "] :: " .. v.value .. "\n"
    end
end

-- to be fixed, specify NS or Record in different functions
function TreePrinter.NS(items, depth, name, tags, traverse_fn)
    TreePrinter.result = TreePrinter.result .. " namespace (" .. name .. ")\n"
    if (items) then
        for i, v in ipairs(items) do
            if (type(v) == "table") then
                -- TreePrinter.result = TreePrinter.result .. tab:rep(depth) .. (v._kind or "" ) ..  v._name
                TreePrinter.result = TreePrinter.result .. tab:rep(depth) .. (v._name or "")
                traverse_fn(v, TreePrinter, depth)
                -- TreePrinter.result = TreePrinter.result .. "\n"
            else
                error("Internal (20): Unknown value type: " .. type(v) .. " for name " .. name)
            end
        end
    end
end
function TreePrinter.Record(items, depth, name, tags, traverse_fn)
    TreePrinter.result = TreePrinter.result .. " record (" .. name .. ")\n"
    if (items) then
        for i, v in ipairs(items) do
            if (type(v) == "table") then
                TreePrinter.result = TreePrinter.result .. tab:rep(depth) .. v._name .. ": "
                traverse_fn(v, TreePrinter, depth)
                -- TreePrinter.result = TreePrinter.result .. "\n"
            else
                error("Internal (20): Unknown value type: " .. type(v) .. " for name " .. name)
            end
        end
    end
end

function TreePrinter.Alias(alias_value, depth, name, tags, traverse_fn)
    TreePrinter.result = TreePrinter.result .. " alias " .. name .. " === "
    if (alias_value) then
        traverse_fn(alias_value, TreePrinter, depth)
    end
end

apidef.traverse(lyte_defs, TreePrinter)

print(TreePrinter.result)

