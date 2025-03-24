require "lib.apidef"  -- TypeMaps

-- indents
local SPC    = (" "):rep(0)
local SPC2   = (" "):rep(4)


local function get_function_like(fn, fname, is_method, is_mapped, orig_ns)
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
        ret =  get_function_like(fn.mapto, fname, is_method, true, fn.namespace)
    else
        ret = SPC
        local user_imp = fn.impl and fn.impl == "user"

        if is_method then
            ret = ret ..  "--- @field " .. fname .. " "
        elseif user_imp  then
            ret = ret ..  "--- @field " .. fn.name .. " " -- doesnt need fullname
        else
            ret = ret .."--- @type "
        end

        ret = ret  .. "fun("
        for i, a in ipairs(fn.args) do
            local doc = a.doc
            local typename = TypeMaps[a.type] and TypeMaps[a.type]["tl"] or get_namespaced_name(fn, a.type)
            ret = ret .. a.name .. ": " .. typename
            -- if doc then ret = ret .. " /*"  .. doc .. "*/" end
            if i < #fn.args then ret = ret .. ", " end
        end
        ret = ret .. ")"
        if #fn.rets > 0 then
            ret = ret .. ": "
            for i, r in ipairs(fn.rets) do
                local doc = r.doc
                local typename = TypeMaps[r.type] and TypeMaps[r.type]["tl"] or get_namespaced_name(fn, r.type)
                ret = ret .. typename
                if i < #fn.rets then ret = ret .. ", " end
            end
            -- if doc then ret = ret .. " /*"  .. doc .. "*/" end
        else
            -- if is_method then ret = ret .. " => void" end
        end

        if is_method or user_imp then
            -- these do not have "values"
        else
            ret = ret .. "\n" .. SPC2 .. fname .. " = " .. fname .. " and " .. fname .. " or function() end"
        end

    end
    return ret
end


return function(NS)

    local function fullname(x) return NS.name .. "." .. x end

    local out = "";

    out = out .. "-- generated\n\n" -- return value
    out = out .. "--- @meta\n"
    out = out .. "--- @class " .. NS.name .. "\n"

    -- user functions (lyte.tick)
    for _, x in ipairs(NS.functions) do
        if string.sub(x.name, 1, 8) ~= "cleanup_" then
            if x.impl and x.impl == "user" then
                if x.doc then out = out .. SPC .. "--- " .. x.doc .. "\n" end
                out = out .. get_function_like(x, fullname(x.name), false, false, x.namespace) .. "\n"
            end
        end
    end

    out = out .. SPC2 .. NS.name .." = " .. NS.name .. " or {}\n"

    out = out .. "\n" .. SPC .. "-- functions\n\n"
    -- non user functions
    for _, x in ipairs(NS.functions) do
        if string.sub(x.name, 1, 8) ~= "cleanup_" then
            if x.impl and x.impl ~= "user" then
                if x.doc then out = out .. SPC .. "--- " .. x.doc .. "\n" end
                out = out .. get_function_like(x, fullname(x.name), false, false, x.namespace) .. "\n"
            end
        end
    end

    out = out .. "\n" .. SPC .. "-- records\n\n"
    for _, x in ipairs(NS.records) do
        if x.doc then out = out .. SPC .. "-- " .. x.doc .. "\n" end
        out = out .. SPC .. "--- @class " .. fullname(x.name) .. "\n"
        for _, f in ipairs(x.fields) do
            local typename = TypeMaps[f.type] and TypeMaps[f.type]["tl"] or NS.name .. "." .. f.type -- "object /*" .. f.type .."*/"
            -- local typename = TypeMaps[f.type] and TypeMaps[f.type]["tl"] or "object /*" .. f.type .."*/"
            local mapping = ""
            -- if f.mapreadname then mapping = " -- read maps to: " .. f.mapreadname .. "" end
            -- if f.mapwritename then mapping = mapping .. ", write maps to: " .. f.mapwritename end
            out = out .. SPC2 .. "--- @field " ..  f.name .. " " .. typename .. mapping .. "\n"
        end
        for _, m in ipairs(x.methods) do
            if m.name ~= "__gc" and m.name ~= "cleanup" then
                local mapping = get_function_like(m.mapto, m.name, true, false, x.namespace) -- .. " -- maps to: " .. m.mapto.name
                out = out .. SPC2 ..  mapping .. "\n"
            end
        end
        out = out .. SPC2 .. fullname(x.name) .. " = " ..  fullname(x.name) .. " and " ..  fullname(x.name) .. " or {}\n"
    end

    out = out .. "\n" .. SPC .. "-- variants (unions)\n\n"
    for _, x in ipairs(NS.variants) do
        if x.doc then out = out .. SPC .. "---" .. x.doc .. "\n" end
        out = out .. SPC .. "--- @alias " .. fullname(x.name)
        local line = ""
        for i, o in ipairs(x.options) do
            local option_type = TypeMaps[o.type] and TypeMaps[o.type]["tl"] or NS.name .. "." .. o.type -- "object" .. "/*" .. o.type .."*/"
            -- local option_type = TypeMaps[o.type] and TypeMaps[o.type]["tl"] or "object" .. "/*" .. o.type .."*/"
            local before = " | "
            local after = ""
            if i == 1 then before = "  " end
            if i == #x.options then after = "\n" end
            line = line ..before ..  option_type .. after
        end
        out = out .. line
    end

    out = out .. "\n" .. SPC .. "-- lists\n\n"
    for _, x in ipairs(NS.lists) do
        if x.doc then out = out .. SPC .. "--- " .. x.doc .. "\n" end
        local item_type = TypeMaps[x.item_type] and TypeMaps[x.item_type]["tl"] or NS.name .. "." ..  x.item_type -- "object" .. "/*" .. x.item_type .."*/"
        -- local item_type = TypeMaps[x.item_type]["tl"] or  "object" .. "/*" .. x.item_type .."*/"
        out = out .. SPC .. "--- @alias " .. fullname(x.name) .. " " .. item_type .. "[]"
        out = out .. "\n"
    end

    out = out .. "\n" .. SPC .. "-- dicts\n\n"
    for _, x in ipairs(NS.dicts) do
        if x.doc then out = out .. SPC .. "--- " .. x.doc .. "\n" end
        local key_type = TypeMaps[x.key_type] and TypeMaps[x.key_type]["tl"] or  x.key_type -- "object" .. "/*" .. x.key_type .."*/"
        -- local key_type = TypeMaps[x.key_type] and TypeMaps[x.key_type]["tl"] or  "object" .. "/*" .. x.key_type .."*/"
        local value_type = TypeMaps[x.value_type] and TypeMaps[x.value_type]["tl"] or NS.name .. "." ..  x.value_type -- "object" .. "/*" .. x.value_type .."*/"
        -- local value_type = TypeMaps[x.value_type] and TypeMaps[x.value_type]["tl"] or "object" .. "/*" .. x.value_type .."*/"
        out = out .. SPC .. "--- @alias " .. fullname(x.name) .. " {[" .. key_type .. "]: " .. value_type .. "}"
        out = out .. "\n"
    end

    out = out .. "\n" .. SPC .. "-- enums\n\n"
    for _, x in ipairs(NS.enums) do
        if x.doc then out = out .. SPC .. "--- " .. x.doc .. "\n" end
        out = out .. SPC .. "--- @alias " .. fullname(x.name) .. " "
        local line = ""
        for i, e in ipairs(x.values) do
            local after = " | "
            if i == #x.values then after = "" end
            if e == "\\" then e = "\\\\" end
            line = line .. "\"" ..  e .. "\"" .. after
        end
        line = line .. "\n"
        out = out .. line
    end

    -- out = out .. "\n\nreturn " .. NS.name .. "\n"

    return out
end
