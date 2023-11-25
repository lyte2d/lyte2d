----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------
local D = require "defs_lyte";
local T = ""

local WHITESPACE = 4

-- local header  = "-- BEGIN: This file is generated\n\n"
-- local footer = "\n-- EOF: This file is generated\n"

-- whitespace
local S = ""
local SS = (" "):rep(WHITESPACE)
local SSS= SS:rep(2)

-- T = T .. header
T = T .. "--- @meta\n\n"

----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------

-- helpers

local function get_t_name_basic(x)
    if x._kind == "primitive" then
        return x.luatype
    elseif x.typename then
        return D._name .. "." .. x.typename
    end
    -- todo: error
    return "UNKNOWN" .. x._kind
end

local function get_t_name(x, full)
    if not full then return get_t_name_basic(x) end

    if x._kind == "dict" then
        return "{[" .. get_t_name(x.key_type) .. "]: " .. get_t_name(x.value_type) .. "}"
    elseif x._kind == "list" then
        return get_t_name(x.value_type) .. "[]"
    elseif x._kind == "tuple" then
        return get_t_name(x.value_type) .. "[]"
    elseif x._kind == "variant" then
        local name = ""
        local num = #x.options
        for io, o in ipairs(x.options) do
            name = name .. get_t_name(o.value_type)
            if io ~= num then name = name .. " | " end
        end
        return name
    end
    return get_t_name_basic(x)
end

local function get_method(f)
    local L = ""
    local title = "fun"
    local sep = ": "
    L = L .. title .. "("
    for ia, a in ipairs(f.args) do
        L = L .. a._name .. ": " .. get_t_name(a.value_type)
        if ia < #f.args then
            L = L .. ", "
        end
    end
    L = L .. ")"
    -- rets
    if #f.rets == 0 then
    --    L = L .. ")"
    else
        L = L .. sep
        if #f.rets > 1 then L = L .. "(" end
        for ir, r in ipairs(f.rets) do
            L = L .. get_t_name(r.value_type)
            if ir < #f.rets then
                L = L .. ", "
            end
        end
        if #f.rets > 1 then L = L .. ")" end
    end
    L = L .. "\n"
    return L
end


local function get_fn(f)
    local L = ""
    local prefix
    if f._tags.callback then
        prefix = "--- @field " .. f._name
    else
        prefix = "--- @type"
    end
    local title = S .. prefix .. " fun"
    local sep = ": "

    -- name
    L = L .. title .. "("
    for ia, a in ipairs(f.args) do
        L = L .. a._name .. ": " .. get_t_name(a.value_type)
        if ia < #f.args then
            L = L .. ", "
        end
    end
    L = L .. ")"
    -- rets
    if #f.rets == 0 then
        --    L = L .. ")"
    else
        L = L .. sep
        if #f.rets > 1 then L = L .. "(" end
        for ir, r in ipairs(f.rets) do
            L = L .. get_t_name(r.value_type)
            if ir < #f.rets then
                L = L .. ", "
            end
        end
        if #f.rets > 1 then L = L .. ")" end
    end

    L = L .. "\n"

    if not f._tags.callback then
        L = L .. "function " .. D._name .. "." .. f._name .. "() end\n";
    end

    return L
end

local function get_docs(d)
    L = ""

    if not d._tags or not d._tags.d then
        return L
    end

    for line in d._tags.d:gmatch("[^\n]+") do
        L = L .. S .. "--- " .. line .. "\n"
    end

    return L
end

----------------------------------
-- namespace begin
----------------------------------
T = T .. "--- @class " .. D._name .. "\n"

----------------------------------
-- functions
----------------------------------
C = ""
F = S .. "\n\n-- functions\n\n"
for _,f in ipairs(D.functions) do
    local L = get_docs(f) .. get_fn(f)
    -- DONE
    if not f._tags.callback then
        F = F .. L
    else
        C = C .. SS .. L
    end
end

T = T .. C .. D._name .. " = {}\n" .. F

----------------------------------
-- lists
----------------------------------
T = T .. S .. "\n\n-- lists\n\n"
for _,l in ipairs(D.lists) do
    T = T .. get_docs(l) .. S .. "--- @alias " .. D._name .. "." .. l._name .. " " ..  get_t_name(l, true) .. "\n"
end

----------------------------------
-- tuples
----------------------------------
T = T .. S .. "\n\n-- tuples\n\n"
for _,l in ipairs(D.tuples) do
    T = T .. get_docs(l) .. S .. "--- @alias " .. D._name .. "."  .. l._name .. " " ..  get_t_name(l, true) .. "\n"
end

----------------------------------
-- dicts
----------------------------------
T = T .. S .. "\n\n-- dicts\n\n"
for _,d in ipairs(D.dicts) do
    T = T .. get_docs(d) .. S .. "--- @alias " .. D._name .. "."  .. d._name .. " " .. get_t_name(d, true) .. "\n"
end

----------------------------------
-- variants
----------------------------------
T = T .. S .. "\n\n-- variants\n\n"
for _,o in ipairs(D.variants) do
    T = T .. get_docs(o) .. S .. "--- @alias " .. D._name .. "."  .. o._name .. " " .. get_t_name(o, true) .. "\n"
end


----------------------------------
-- records
----------------------------------
T = T .. S .. "\n\n-- records\n\n"
for _,r in ipairs(D.records) do
    local L = get_docs(r)
    -- name
    L = L .. S .. "--- @class " .. D._name .. "."  .. r._name .. "\n"
    -- fields
    for _,f in ipairs(r.fields) do
        L = L .. SS .. get_docs(f)
        L = L .. SS .. "--- @field " .. f._name .. " " .. get_t_name(f.value_type) .. "\n"
    end
    -- methods
    for _,m in ipairs(r.methods) do
        L = L .. SS .. get_docs(m)
        L = L .. SS .. "--- @field " .. m._name .. " " .. get_method(m)
    end
    L = L .. S .. "" .. D._name .. "."  .. r._name .. " = {}\n"
    -- DONE
    T = T .. L .. "\n"
end

----------------------------------
-- enums
----------------------------------
T = T .. S .. "\n\n-- enums\n\n"
for _,e in ipairs(D.enums) do
    local L = get_docs(e)

    L = L .. S .. "---@alias " .. D._name .. "."  .. e._name .. ""

    L = L .. SS
    for nc, c in ipairs(e.choices) do
        if c == "\\" then c = "\\\\" end
        L = L .. '"' .. c .. '"'
        if nc < #e.choices then L = L .. " | " end
        if #L > 100 then
            -- T = T .. L .. "\n--- "
            -- L = SS
        else
            L = L .. " "
        end
    end
    -- DONE
    T = T .. L .. "\n"
end


----------------------------------
-- namespace end
----------------------------------
T = T .. "\n\nreturn " .. D._name .. "\n"



----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------

-- T = T .. footer

print(T)

return T

----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------
