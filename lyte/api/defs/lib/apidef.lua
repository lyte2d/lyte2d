Tag = require "lib.tag.tag"


String = Tag"String"
Integer = Tag"Integer"
Float = Tag"Float"
Double = Tag"double"
Boolean = Tag"Boolean"
Pointer = Tag"Pointer"
Nil = Tag"Nil"

Record = Tag"Record"
Namespace = Tag"Namespace"
Field = Tag"Field"
Variant = Tag"Variant"
Option = Tag"Option"
Enum = Tag"Enum"
Dict = Tag"Dict"
List = Tag"List"
Function = Tag"Function"
Method = Tag"Method"
Arg = Tag"Arg"
Ret = Tag"Ret"

-- Records: field and method mappings
MapTo = Tag"MapTo"
MapRead = Tag"MapRead"
MapWrite = Tag"MapWrite"

Wrap = Tag"Wrap"
MapWrapTo = Tag"MapWrapTo"

Require = Tag"Require"

Doc = Tag"Doc"
T = Tag"Type"
Impl = Tag"Impl"
Code = Tag"Code"
MaxCount = Tag"MaxCount"

Bool = T"bool"
Int = T"int"
Float = T"float"
Double = T"double"
String = T"string"

Pointer = T"pointer"

LuaImpl = Impl"lua" -- Functions in lyte library impemented in lua instead of C (default)
UserImpl = Impl"user" -- Functions implemented by the user, like "tick"

local function check_tag(tag, kind)
    assert (tag)
    assert (type(tag) == "table")
    assert (getmetatable(tag))
    assert (getmetatable(tag).is_tag)
    if kind then
        assert (tag._kind == kind)
        assert (tag._name)
        assert (type(tag._name) == "string")
    end
    return true
end

local function get_full_function_list(ns)
    local functions = {}
    local function_list = ns.functions
    for _, fn in ipairs(function_list) do
        functions[fn.name] = fn
    end
    for _, req in ipairs(ns.requires) do
        for _, fn in ipairs(req.functions) do
            local fullname = fn.namespace .. "." .. fn.name
            functions[fullname] = fn
        end
    end
    return functions
end


-- collect from raw definitions to structured object
local function to_function_obj(def, ns)
    check_tag(def, "Function")
    local fn = {}
    fn.name = def._name
    fn.namespace = ns.name
    fn.doc = ""

    fn.args = {}
    fn.rets = {}
    fn.impl = "native"
    fn.code = nil
    fn.mapto = nil

    local functions = get_full_function_list(ns)

    assert(#def.items > 0)

    for _i, x in ipairs(def.items) do
        check_tag(x)
        if x._kind == "Arg" then
            assert(#x.items > 0)
            check_tag(x.items[1])
            assert(x.items[1]._kind == "Type" or x.items[1]._kind == "Wrap")
            local typename = x.items[1]._name
            local iswrapped = x.items[1]._kind == "Wrap" or nil
            local doc = nil
            if #x.items >= 2 and x.items[2]._kind == "Doc" then doc = x.items[2]._name end
            table.insert(fn.args, { name = x._name, type = typename, wrapped = iswrapped, doc = doc })
        elseif x._kind == "Ret" then
            assert(#x.items > 0)
            check_tag(x.items[1])
            assert(x.items[1]._kind == "Type" or x.items[1]._kind == "Wrap")
            local typename = x.items[1]._name
            local iswrapped = x.items[1]._kind == "Wrap" or nil
            local doc = nil
            if #x.items >= 2 and x.items[2]._kind == "Doc" then doc = x.items[2]._name end
            table.insert(fn.rets, { name = x._name, type = typename, wrapped = iswrapped, doc = doc })
        elseif x._kind == "Doc" then fn.doc = fn.doc .. x._name .. " "
        elseif x._kind == "Code" then fn.code =  x._name
        elseif x._kind == "MapTo" then fn.mapto = functions[x._name]; fn.doc = fn.doc .. fn.mapto.doc
        elseif x._kind == "MapWrapTo" then fn.mapwrapto = functions[x._name]; -- fn.doc = fn.doc .. fn.mapto.doc
        elseif x._kind == "Impl" then
            assert(fn.impl == "native") -- impl can only defined once per function
            fn.impl = x._name
        else error("Unknown kind: " .. x._kind .. " -> " .. x._name)
        end
    end

    return fn
end


-- collect from raw definitions to structured object
local function to_record_obj(def, ns)
    check_tag(def, "Record")
    local rec = {}
    rec.name = def._name
    rec.namespace = ns.name
    rec.doc = ""
    rec.fields = {}
    rec.methods = {}

    local functions = get_full_function_list(ns)

    for _i, x in ipairs(def.items) do
        check_tag(x)
        if x._kind == "Field" then
            assert(#x.items > 0)
            check_tag(x.items[1])
            local typename = x.items[1]._name
            local mapread = nil
            local mapwrite = nil
            if #x.items >=2 then
                if #x.items == 2 then
                    check_tag(x.items[2])
                    if (x.items[2]._kind == "MapRead") then
                        mapread = functions[x.items[2]._name]
                    elseif (x.items[2]._kind == "MapWrite") then
                        mapwrite = functions[x.items[2]._name]
                    else error("Unsupported number of parts in MapWrite def:: " .. x._kind .. " -> ." .. x._name)
                    end
                elseif #x.items == 3 then
                    check_tag(x.items[2])
                    check_tag(x.items[3])
                    if x.items[2]._kind == "MapRead" and x.items[3]._kind == "MapWrite" then
                        mapread = functions[x.items[2]._name]
                        mapwrite = functions[x.items[3]._name]
                    else error("Unsupported number of parts in MapWrite def:: " .. x._kind .. " -> ." .. x._name)
                    end
                else error("Unsupported number of parts in definition: " .. x._kind .. " -> ." .. x._name)
                end
            end
            -- TODO: verify that field type matches with mapped read and write functions
            -- local mreadname = mapread and mapread.name
            -- local mwritename = mapwrite and mapwrite.name
            table.insert(rec.fields, { name = x._name, type = typename, mapread = mapread, mapwrite = mapwrite })
        elseif x._kind == "Method" then
            assert(#x.items > 0)
            check_tag(x.items[1])
            local mapto = functions[x.items[1]._name]
            -- table.insert(rec.methods, { name = x._name, mapto = mapto, maptoname = mapto.name })
            table.insert(rec.methods, { name = x._name, mapto = mapto })
        elseif x._kind == "Doc" then rec.doc = rec.doc .. x._name .. " "
        else error("Unknown kind: " .. x._kind .. " -> " .. x._name)
        end
    end

    return rec
end

-- collect from raw definitions to structured object
local function to_list_obj(def, nsname)
    check_tag(def, "List")
    local ls = {}
    ls.name = def._name
    ls.namespace = nsname
    ls.doc = ""
    ls.item_type = nil
    ls.max_count = 0

    assert(#def.items > 1)

    check_tag(def.items[1])
    if def.items[1]._kind ~= "Type" then error "List definition needs to specify item(element) type as the first item" end
    ls.item_type = def.items[1]._name

    check_tag(def.items[2])
    if def.items[2]._kind ~= "MaxCount" then error("List definition needs to specify a max count as the second item" .. def.items[2]._kind) end
    ls.max_count = def.items[2]._name


    if(#def.items > 2) then
        check_tag(def.items[3])
        if def.items[3]._kind ~= "Doc" then error "List definition's thirt item needs to be a Doc if it exists" end
        ls.doc = def.items[3]._name
    end

    return ls
end


-- collect from raw definitions to structured object
local function to_dict_obj(def, nsname)
    check_tag(def, "Dict")
    local dict = {}
    dict.name = def._name
    dict.namespace = nsname
    dict.doc = ""
    -- should have 2 values key types, value type  (plus maybe Doc)
    dict.key_type = nil
    dict.value_type = nil

    assert(#def.items > 1)

    check_tag(def.items[1])
    if def.items[1]._kind ~= "Type" then error "Dict definition needs to specify key type as the first item" end
    dict.key_type = def.items[1]._name
    check_tag(def.items[2])
    if def.items[2]._kind ~= "Type" then error "Dict definition needs to specify value type as the second item" end
    dict.value_type = def.items[2]._name

    if(#def.items > 2) then
        check_tag(def.items[3])
        if def.items[2]._kind ~= "Doc" then error "Dict definition's third item needs to be a Doc if it exists" end
        dict.doc = def.items[3]._name
    end

    return dict
end

-- collect from raw definitions to structured object
local function to_variant_obj(def, nsname)
    check_tag(def, "Variant")
    local variant = {}
    variant.name = def._name
    variant.namespace = nsname
    variant.doc = ""
    variant.options = {}

    for _i, x in ipairs(def.items) do
        check_tag(x)
        if x._kind == "Option" then
            assert(#x.items > 0)
            check_tag(x.items[1])
            local typename = x.items[1]._name
            local doc = nil
            if #x.items >= 2 and x.items[2]._kind == "Doc" then doc = x.items[2]._name end
            table.insert(variant.options, { name = x._name, type = typename, doc = doc })
        elseif x._kind == "Doc" then variant.doc = variant.doc .. x._name .. " "
        else error("Unknown kind: " .. x._kind .. " -> " .. x._name)
        end
    end


    return variant
end

-- collect from raw definitions to structured object
local function to_enum_obj(def, nsname)
    check_tag(def, "Enum")
    local _enum = {}
    _enum.name = def._name
    _enum.namespace = nsname
    _enum.doc = ""

    _enum.values = {}
    for _, x in ipairs(def.items) do
        if type(x) == "string" then table.insert(_enum.values, x)
        elseif check_tag(x) and x._kind == "Doc" then _enum.doc = _enum.doc .. x._name
        else error("Unknown kind: " .. x._kind .. " -> " .. x._name)
        end
    end
    return _enum
end


-- collect from raw definitions to structured object
local function to_namespace_obj(def, parent_ns_name)
    check_tag(def, "Namespace")
    parent_ns_name = parent_ns_name or nil
    local NS = {}
    NS.name = def._name
    NS.namespaces = parent_ns_name
    NS.doc = ""
    NS.requires = {}
    NS.functions = {}
    NS.records = {}
    NS.lists = {}
    NS.dicts = {}
    NS.variants = {}
    NS.enums = {}
    NS.namespaces = {}

    -- seperate loops: anything can have dependencies on "Required" libraries. thus handle all those first
    for _i, x in ipairs(def.items) do
        check_tag(x)
        if x._kind == "Require" then
            local req = require(x._name).tree
            -- local req_ns = req.name
            -- -- update names to be "namespaced" names
            -- for _i, x in ipairs(req.functions) do if x.name then x.name = req_ns .. "." .. x.name end end
            -- for _i, x in ipairs(req.records) do if x.name then x.name = req_ns .. "." .. x.name end end
            -- for _i, x in ipairs(req.lists) do if x.name then x.name = req_ns .. "." .. x.name end end
            -- for _i, x in ipairs(req.dicts) do if x.name then x.name = req_ns .. "." .. x.name end end
            -- for _i, x in ipairs(req.variants) do if x.name then x.name = req_ns .. "." .. x.name end end
            -- for _i, x in ipairs(req.enums) do if x.name then x.name = req_ns .. "." .. x.name end end
            -- for _i, x in ipairs(req.namespaces) do if x.name then x.name = req_ns .. "." .. x.name end end
            -- -- Note: this doesn't handle a child's require's. Not needed for Lyte's current API shape
            -- Enums are shared between lyte and lyte_core namespaces. copy them over
            for _i, e in ipairs(req.enums) do table.insert(NS.enums, e) end


            table.insert(NS.requires, req)
        end
        --
    end

    -- seperate loops: record methods can have deps on functions. thus handle all the functions first
    for _i, x in ipairs(def.items) do
        check_tag(x)
        if x._kind == "Function" then table.insert(NS.functions, to_function_obj(x, NS))
        end
    end

    -- seperate loops: non requires and non functions are handled here
    for _i, x in ipairs(def.items) do
        check_tag(x)
        if x._kind == "Function" then -- HANDLED ABOVE
        elseif x._kind == "Require" then -- HANDLED ABOVE
        elseif x._kind == "Namespace" then table.insert(NS.namespaces, to_namespace_obj(x, NS.name))
        elseif x._kind == "Record" then table.insert(NS.records, to_record_obj(x, NS))
        elseif x._kind == "List" then table.insert(NS.lists, to_list_obj(x, NS.name))
        elseif x._kind == "Dict" then table.insert(NS.dicts, to_dict_obj(x, NS.name))
        elseif x._kind == "Variant" then table.insert(NS.variants, to_variant_obj(x, NS.name))
        elseif x._kind == "Enum" then table.insert(NS.enums, to_enum_obj(x, NS.name))
        elseif x._kind == "Doc" then NS.doc = NS.doc .. "\n" .. x._name
        else error("Unknown kind: " .. x._kind .. " -> " .. x._name)
        end
    end
    return NS
end

-- keep in sync with gen_api_native.lua variable CTypeMaps
TypeMaps = {
    ["bool"] =    {   lua = "boolean",   tl = "boolean",    ts = "boolean" },
    ["int"] =     {   lua = "number",    tl = "int",        ts = "number" },
    ["float"] =   {   lua = "number",    tl = "number",     ts = "number" },
    ["double"] =  {   lua = "number",    tl = "number",     ts = "number" },
    ["string"] =  {   lua = "string",    tl = "string",     ts = "string" },
    ["pointer"] = {   lua = "userdata",  tl = "userdata",   ts = "object" },
}


function process_def_tree(def)
    local NS = to_namespace_obj(def, nil)
    return { tree = NS, raw_tree = def }
end
