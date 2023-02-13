local defs = {}

function string:split(sep)
    local sep, fields = sep or ":", {}
    local pattern = string.format("([^%s]+)", sep)
    self:gsub(pattern, function(c) fields[#fields+1] = c end)
    return fields
 end

--------------------------------------------------------
-- type definition functions
--------------------------------------------------------

defs.String = "string"
defs.Number = "number"
defs.Boolean = "boolean"
defs.Nil = "nil"


local function deftable(defname, table, tags)
    assert(type(defname)=="string")
    assert(type(table) == "table")
    table.__def = defname
    table.__tags = tags or {}
    return table
end

function defs.NS(table, tags)
    return deftable("NS", table, tags)
end

function defs.Record(table, tags)
    assert(type(table) == "table")
    return deftable("Record", table, tags)
end

function defs.Enum(table, tags)
    return deftable("Enum", table, tags)
end

function defs.Dict(key_type, value_type, tags)
    return deftable("Dict", { key_type = key_type, value_type = value_type }, tags)
end

function defs.List(typ, tags)
    return deftable("List", { type = typ }, tags)
end

function defs.Function(arglist,retlist,tags)
    return deftable("Function", { arg = arglist or {}, ret = retlist or {} }, tags)
end

function defs.Method(arglist,retlist,tags)
    return deftable("Method", { arg = arglist or {}, ret = retlist or {} }, tags)
end

function defs.Var(typ,name,tags)
    return deftable("Var", {type = typ, name = name or "" }, tags)
end

function defs.Or (table, tags)
    return deftable("Or", table, tags)
end


function defs.Alias(typ,tags)
    return deftable("Alias", {type = typ}, tags)
end



--------------------------------------------------------
-- defs pretty printer: teal .d.tl
--------------------------------------------------------

function defs.pp_teal_d_tl(table_)
    error "nyi"
    assert(type(table_)=="table")
end

--------------------------------------------------------
-- defs pretty printer: api html documentation
--------------------------------------------------------

function defs.pp_api_html_docs(table_)
    error "nyi"
    assert(type(table_)=="table")
end


--------------------------------------------------------
-- defs pretty printer: repl helper (TBD)
--------------------------------------------------------

function defs.pp_repl_helpers(table_)
    error "nyi"
    assert(type(table_)=="table")
end



--------------------------------------------------------
-- defs pretty printer: typesript .d.ts
--------------------------------------------------------

local function _basic_types(def)
    local str = ""
    if def == "Number" then str = "number"
    elseif def == "String" then str = "string"
    elseif def == "Boolean" then str = "boolean"
    elseif def == "Nil" then str = "nil"
    else str = "<UNKNOWN basicdef: '" .. def .."'>" end
    return str
end

local function pairs_by_def(t, v)
    local a = {}
    for n,v in pairs(t) do
        if (v and v.__def) then
            local left = v.__def
            if left == "Enum" then left = "Z9_Enum" end -- take it to the last:
            if left == "Function" and n == "frame" then left = "A0_SpecialFunc" end
            if left == "Alias" then left = "G1_aliases" end
            local k = left .. "@" .. n
            table.insert(a, k)
        elseif n:sub(1,2) ~= "__" then
            local k = "A1_" .. v .. "@" .. n  -- take the "variables" in record, etc to the top
            table.insert(a, k)
        end
    end
    table.sort(a, f)
    local i = 0 -- iterator variable
    local iter = function() -- iterator function
        i = i + 1
        if a[i] == nil then-- return nil
        -- else return a[i], t[a[i]]
        else
            local vv = (a[i]):split("@")
            return vv[2], t[vv[2]]
        end
    end
    return iter
end

-- todo: sending "printer" funcs to generalize this a bit
function defs.pp_typescript_d_ts(name, table_, initial_depth, tab_size)
    assert(type(table_)=="table")
    assert(table_.__def == "NS")

    initial_depth = initial_depth or 1
    tab_size = tabsize or 4

    local function recurse(tbl, ret, name, depth)
        -- Base type case
        if type(tbl) == "string" then
            ret = ret .. _basic_types(def)
        elseif type(tbl) == "table" then
            local def = tbl.__def

            if def == "Number" or def == "String" or def == "Boolean" or def == "Nil" then
                -- return _basic_types(def)
                ret = ret .. _basic_types(def)
            elseif def == "NS" then
                ret = ret .. (" "):rep((depth - 1) * tab_size) .. "declare namespace " .. name .. " {\n"
                for k, v in pairs_by_def(tbl) do
                    if (k:sub(1,2) ~= "__") then
                        ret = ret .. (" "):rep(depth * tab_size) .. recurse(v, "", k, depth + 1) .. ";\n"
                    end
                end
                ret = ret .. (" "):rep((depth - 1) * tab_size) .. "}"
            elseif def == "Record" then
                ret = ret .. "interface " .. name .. " {\n"
                for k, v in pairs_by_def(tbl) do
                    if (k:sub(1,2) ~= "__") then
                        ret = ret .. (" "):rep(depth * tab_size) .. k .. ": "
                        if type(v) == "string" then
                            ret = ret .. v
                        else
                            ret = ret .. recurse(v, "", k, depth + 1)
                        end
                        ret = ret .. ";\n"
                    end
                end
                ret = ret .. (" "):rep((depth - 1) * tab_size) .. "}"
            elseif def == "Function" or def == "Method" then
                local arglist = tbl.arg
                local retlist = tbl.ret
                local ismethod = def == "Method"
                -- ret = ret .. "function"
                if not ismethod then ret = ret .. "function " .. name .. "(" else ret = ret .. "(" end
                -- args

                assert(type(arglist) == "table")
                local na = #arglist
                if ismethod then ret = ret .. "self" end
                if ismethod and na > 0 then ret = ret .. ", " end
                for i, ai in ipairs(arglist) do
                    assert(ai.__def == "Var")
                    ret = ret .. ai.name .. ": "
                    if type(ai.type) == "string" then
                        ret = ret  .. ai.type
                    else
                        -- ret = ret .. "<UNKNOWN>"
                        ret = ret .. recurse(ai.type, "", "", depth+1)
                    end
                    if i < na then ret = ret .. ", " end
                end
                --
                ret = ret .. ")"
                -- rets
                local nr = #retlist
                if nr > 0 then
                    if ismethod then ret = ret .. " => (" else  ret = ret .. ": (" end
                    for i, ri in ipairs(retlist) do
                        if type(ri) == "string" then
                            ret = ret .. ri
                        elseif (ri.__def == "Var") then
                            ret = ret .. ri.name .. ": " .. ri.type
                        end
                        if i < nr then ret = ret .. ", " end
                    end
                    ret = ret .. ")"
                else
                    if ismethod then ret = ret .. " => void" else ret = ret .. ": void"  end
                end
            elseif def == "Enum" then
                ret = ret .. "type " .. name .. " = "
                ret = ret .. "\n" .. (" "):rep(depth * tab_size)
                local n = #tbl
                local cur_line_cnt = 1
                for i, v in ipairs(tbl) do
                    if v == "'" then
                        ret = ret .. '"' .. v .. '"'
                    elseif v == '\\' then
                        ret = ret .. "'\\\\'"
                    else
                        ret = ret .. "'" .. v .. "'"
                    end
                    if i < n then
                        ret = ret .. " | "
                        if cur_line_cnt > 5 then
                            ret = ret .. "\n" .. (" "):rep(depth * tab_size)
                            cur_line_cnt = 0
                        end
                    end
                    cur_line_cnt = cur_line_cnt + 1
                end
            elseif def == "Alias" then
                local typ = tbl.type
                ret = ret .. "type " .. name .. " = "
                if type(typ) == string then
                    ret = ret .. typ
                else
                    ret = ret .. recurse(typ, "", "", depth+1)
                end
            elseif def == "Or" then
                local n = #tbl
                for i,v in ipairs(tbl) do
                    if type(v) == "string" then
                        ret = ret .. v
                    else
                        ret = ret .. recurse(v, "", "", depth+1)
                    end
                    if i < n then
                        ret = ret .. " | "
                    end
                end
            elseif def == "List" then
                local typ = tbl.type
                ret = ret
                if type(typ) == "string" then
                    ret = ret .. typ
                else
                    ret = ret .. recurse(typ, "", "", depth+1)
                end
                ret = ret .. "[]"
            elseif def == "Dict" then
                local kt = tbl.key_type
                local vt = tbl.value_type
                ret = ret .. '{[key: '
                if type(kt) == "string" then
                    ret = ret .. kt
                else
                    ret = ret .. recurse(kt, "", "", depth+1)
                end
                ret = ret  .. ']: '
                if type(vt) == "string" then
                    ret = ret  .. vt
                else
                    ret = ret .. recurse(vt, "", "", depth+1)
                end
                ret = ret  .. '}'
            else
                -- error("<UNKNOWN def: '" .. def .. "'>")
                ret = ret .. ("<UNKNOWN def: '" .. def .. "'>")
            end
        elseif not tbl then
            error ("Empty for name: " .. name)
        else
            error("Unknown: '" .. tbl .. "'")
        end
        return ret
    end

    return "\n ".. recurse(table_, "", name, initial_depth) .. ";\n"
end

return defs