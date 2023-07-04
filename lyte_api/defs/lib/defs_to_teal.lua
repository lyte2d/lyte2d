----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------
local D = require "defs_lyte";
local T = ""

local WHITESPACE = 4

-- local header  = "-- BEGIN: This file is generated\n\n"
-- local footer = "\n-- EOF: This file is generated\n"

-- whitespace
local S = (" "):rep(WHITESPACE)
local SS = S:rep(2)
local SSS= S:rep(3)

-- T = T .. header

----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------

-- helpers

local function get_t_name_basic(x)
    if x._kind == "primitive" then
        return x.luatype
    elseif x.typename then
        return x.typename
    end
    -- todo: error
    return "UNKNOWN" .. x._kind
end

local function get_t_name(x, full)
    if not full then return get_t_name_basic(x) end

    if x._kind == "dict" then
        return "{" .. get_t_name(x.key_type) .. ": " .. get_t_name(x.value_type) .. "}"
    elseif x._kind == "list" then
        return "{" .. get_t_name(x.value_type) .. "}"
    elseif x._kind == "tuple" then
        return "{" .. get_t_name(x.value_type) .. "}"
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

local function get_fn(f, is_method)
    local L = ""
    local title = "function "
    local sep = ": "
    if not is_method then
        title = S .. f._name .. ": function"
        sep = ": "
    end
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
    return L
end

----------------------------------
-- namespace begin
----------------------------------
T = T .. "global record " .. D._name .. "\n"

----------------------------------
-- functions
----------------------------------
T = T .. S .. "-- functions\n"
for _,f in ipairs(D.functions) do
    local L = get_fn(f)
    -- DONE
    T = T .. L
end

----------------------------------
-- lists
----------------------------------
T = T .. S .. "-- lists\n"
for _,l in ipairs(D.lists) do
    T = T .. S .. "type " .. l._name .. " = " ..  get_t_name(l, true) .. "\n"
end

----------------------------------
-- tuples
----------------------------------
T = T .. S .. "-- tuples\n"
for _,l in ipairs(D.tuples) do
    T = T .. S .. "type " .. l._name .. " = " ..  get_t_name(l, true) .. "\n"
end

----------------------------------
-- dicts
----------------------------------
T = T .. S .. "-- dicts\n"
for _,d in ipairs(D.dicts) do
    T = T .. S .. "type " .. d._name .. " = " .. get_t_name(d, true) .. "\n"
end

----------------------------------
-- variants
----------------------------------
T = T .. S .. "-- variants\n"
for _,o in ipairs(D.variants) do
    T = T .. S .. "type " .. o._name .. " = " .. get_t_name(o, true) .. "\n"
end


----------------------------------
-- records
----------------------------------
T = T .. S .. "-- records\n"
for _,r in ipairs(D.records) do
    local L = ""
    -- name
    L = L .. S .. "record " .. r._name .. "\n"
    -- fields
    for _,f in ipairs(r.fields) do
        L = L .. SS .. f._name .. ": " .. get_t_name(f.value_type) .. "\n"
    end
    -- methods
    for _,m in ipairs(r.methods) do
        L = L .. SS .. m._name .. ": " .. get_fn(m, true)
    end
    -- DONE
    L = L .. S .. "end\n"
    T = T .. L
end

----------------------------------
-- enums
----------------------------------
T = T .. S .. "-- enums\n"
for _,e in ipairs(D.enums) do
    -- name
    T = T .. S .. "enum " .. e._name .. "\n"

    local L = SS
    for nc, c in ipairs(e.choices) do
        if c == "\\" then c = "\\\\" end
        L = L .. '"' .. c .. '"'
        if nc < #e.choices then L = L .. " " end
        if #L > 100 then
            T = T .. L .. "\n"
            L = SS
        else
            L = L .. " "
        end
    end
    -- DONE
    T = T .. L .. "\n" .. S .. "end\n"
end


----------------------------------
-- namespace end
----------------------------------
T = T .. "end\n"



----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------

-- T = T .. footer

print(T)

return T

----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------
