require "lib.apidef"  -- TypeMaps

local function get_function_like(fn, name, is_method, is_mapped, orig_ns)
    local function get_namespaced_name(func, n)
        if func.namespace then
            if is_mapped then
                return orig_ns .. "." ..  n
            else
                return func.namespace .. "." .. n
            end
        else
            return n
        end
    end

    local ret = ""
    --
    if fn.mapto then
        ret =  get_function_like(fn.mapto, name, is_method, true, fn.namespace)
    else
        if not is_method then
            ret = ret .. name .. ": function"
        else
            ret = ret ..  "function"
        end
        ret = ret  .. "("
        for i, a in ipairs(fn.args) do
            local doc = a.doc
            local typename = TypeMaps[a.type] and TypeMaps[a.type]["tl"] or get_namespaced_name(fn, a.type)
            ret = ret .. a.name .. ": " .. typename
            -- if doc then ret = ret .. " /*"  .. doc .. "*/" end
            if i < #fn.args then ret = ret .. ", " end
        end
        ret = ret .. ")"
    -- consider lifting this limitation in the future
        if #fn.rets > 1 then error("Functions are expected to return at most 1 value.") end
        if #fn.rets == 1 then
            -- if is_method then ret = ret .. " => "  else ret = ret .. ": " end
            ret = ret .. ": "
            local r = fn.rets[1]
            local doc = r.doc
            local typename = TypeMaps[r.type] and TypeMaps[r.type]["tl"] or get_namespaced_name(fn, r.type)
            ret = ret .. typename
            -- if doc then ret = ret .. " /*"  .. doc .. "*/" end
        else
            -- if is_method then ret = ret .. " => void" end
        end
    end
    return ret
end


return function(NS)
    local out = "";

    -- indents
    local SPC    = (" "):rep(4)
    local SPC2   = SPC:rep(2)

    out = out .. "-- generated\n" -- return value
    out = out .. "global record " .. NS.name .. "\n"

    out = out .. "\n" .. SPC .. "-- functions\n\n"
    for _, x in ipairs(NS.functions) do
        if string.sub(x.name, 1, 8) ~= "cleanup_" then
            local fnmap = x.fnmap or ""
            -- if x.doc then out = out .. SPC .. "-- " .. x.doc .. " [impl: "  ..  x.impl .. "/" .. fnmap .. "]\n"
            if x.doc then out = out .. SPC .. "-- " .. x.doc .. "\n"
            end
            out = out .. SPC .. get_function_like(x, x.name, false, false, false, x.namespace) .. "\n"
        end
    end

    out = out .. "\n" .. SPC .. "-- records\n\n"
    for _, x in ipairs(NS.records) do
        if x.doc then out = out .. SPC .. "-- " .. x.doc .. "\n" end
        out = out .. SPC .. "record " .. x.name .. "\n"
        for _, f in ipairs(x.fields) do
            local typename = TypeMaps[f.type] and TypeMaps[f.type]["tl"] or NS.name .. "." .. f.type -- "object /*" .. f.type .."*/"
            -- local typename = TypeMaps[f.type] and TypeMaps[f.type]["tl"] or "object /*" .. f.type .."*/"
            local mapping = ""
            -- if f.mapreadname then mapping = " -- read maps to: " .. f.mapreadname .. "" end
            -- if f.mapwritename then mapping = mapping .. ", write maps to: " .. f.mapwritename end
            out = out .. SPC2 .. f.name .. ": " .. typename .. mapping .. "\n"
        end
        for _, m in ipairs(x.methods) do
            if m.name ~= "__gc" and m.name ~= "cleanup" then
                local mapping = get_function_like(m.mapto, m.name, true, false, m.namespace) -- .. " -- maps to: " .. m.mapto.name
                out = out .. SPC2 .. m.name .. ": " ..  mapping .. "\n"
            end
        end
        out = out .. SPC .. "end\n"
    end

    out = out .. "\n" .. SPC .. "-- variants (unions)\n\n"
    for _, x in ipairs(NS.variants) do
        if x.doc then out = out .. SPC .. "-- " .. x.doc .. "\n" end
        out = out .. SPC .. "type " .. x.name .. " =\n"
        local line = ""
        for i, o in ipairs(x.options) do
            local option_type = TypeMaps[o.type] and TypeMaps[o.type]["tl"] or NS.name .. "." .. o.type -- "object" .. "/*" .. o.type .."*/"
            -- local option_type = TypeMaps[o.type] and TypeMaps[o.type]["tl"] or "object" .. "/*" .. o.type .."*/"
            local before = "| "
            local after = ""
            if i == 1 then before = "  " end
            -- if i == #x.options then after = ";" end
            line = line .. SPC2 .. before ..  option_type .. after .. "\n"
        end
        out = out .. line
    end

    out = out .. "\n" .. SPC .. "-- lists\n\n"
    for _, x in ipairs(NS.lists) do
        if x.doc then out = out .. SPC .. "-- " .. x.doc .. "\n" end
        local item_type = TypeMaps[x.item_type]["tl"] or NS.name .. "." ..  x.item_type -- "object" .. "/*" .. x.item_type .."*/"
        -- local item_type = TypeMaps[x.item_type]["tl"] or  "object" .. "/*" .. x.item_type .."*/"
        out = out .. SPC .. "type " .. x.name .. " = {" .. item_type .. "}"
        out = out .. "\n"
    end

    out = out .. "\n" .. SPC .. "-- dicts\n\n"
    for _, x in ipairs(NS.dicts) do
        if x.doc then out = out .. SPC .. "-- " .. x.doc .. "\n" end
        local key_type = TypeMaps[x.key_type] and TypeMaps[x.key_type]["tl"] or  x.key_type -- "object" .. "/*" .. x.key_type .."*/"
        -- local key_type = TypeMaps[x.key_type] and TypeMaps[x.key_type]["tl"] or  "object" .. "/*" .. x.key_type .."*/"
        local value_type = TypeMaps[x.value_type] and TypeMaps[x.value_type]["tl"] or NS.name .. "." .. x.value_type -- "object" .. "/*" .. x.value_type .."*/"
        -- local value_type = TypeMaps[x.value_type] and TypeMaps[x.value_type]["tl"] or "object" .. "/*" .. x.value_type .."*/"
        out = out .. SPC .. "type " .. x.name .. " = {" .. key_type .. ": " .. value_type .. "}"
        out = out .. "\n"
    end

    out = out .. "\n" .. SPC .. "-- enums\n\n"
    for _, x in ipairs(NS.enums) do
        if x.doc then out = out .. SPC .. "-- " .. x.doc .. "\n" end
        out = out .. SPC .. "enum " .. x.name .. "\n"
        local line = ""
        for i, e in ipairs(x.values) do
            local before = "  "
            local after = ""
            if i == 1 then before = "  " end
            -- if i == #x.values then after = ";" end
            if e == "\\" then e = "\\\\" end
            line = line .. SPC2 .. before .. "\"" ..  e .. "\"" .. after .. "\n"
        end
        line = line .. SPC .. "end\n"
        out = out .. line
    end

    out = out .. "end\n"

    return out
end
