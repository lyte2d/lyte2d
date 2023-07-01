---------------------------------------------------------------------------------------------
-- API definition helpers
---------------------------------------------------------------------------------------------

local M = {}

do

    local function _basetype(luatype, nativetype, typename)
        return {
            _kind = "_UNKNOWN_basetype_TBD_",
            luatype = luatype or "_UNKNOWN_TBD_",  -- number, boolean, string, table, userdata ...
            nativetype = nativetype or "_UNKNOWN_TBD_", -- int32_t, double, bool, const char *, enum, ...
            typename = typename or "PRIMITIVE"
        }
    end



    -- BASE TYPES
    function M.String()
        return _basetype("string", "const char *")
    end

    function M.Integer()
        return _basetype("number", "int")
    end

    function M.Float()
        return _basetype("number", "float")
    end

    function M.Number()
        return _basetype("number", "double")
    end

    function M.Boolean()
        return _basetype("boolean", "bool")
    end

    function M.Nil()
        return _basetype("nil", "void")
    end

    -- use this to specify any named type (that you defined as a record or something)
    function M.Defined(typename) -- Image, Font etc considered "Native"
        return _basetype(nil, nil, typename)
    end

end

-- dicts have key and value types
function M.Dict(name, key_type, value_type, _tags)
    local ret = {}
    ret._kind = "dict"
    ret._tags = _tags
    ret._name = name
    ret.key_type = key_type
    ret.value_type = value_type
    return ret;
end


-- lists have value type
function M.List(name, value_type, _tags)
    local ret = {}
    ret._kind = "list"
    ret._name = name
    ret._tags = _tags
    ret.value_type = value_type
    return ret;
end


-- tuples have value type, and a max count
function M.Tuple(name, value_type, max_count, _tags)
    local ret = {}
    ret._kind = "tuple"
    ret._name = name
    ret._tags = _tags
    ret.value_type = value_type
    ret.max_count = max_count
    return ret;
end




-- namespaces have items
-- note: namespaces can only be top level!
function M.Namespace(name, items, _tags)
    assert(type(name) == "string")
    assert(type(items) == "table")
    local rec = {}
    rec._kind = "namespace"
    rec._name = name
    rec._tags = _tags
    rec.items = items
    return rec
end




-- records have fields nad methods
function M.Record(name, fields, methods, _tags)
    assert(type(name) == "string")
    fields = fields or {}
    methods = methods or {}
    assert(type(fields) == "table")
    assert(type(methods) == "table")
    local rec = {}
    rec._kind = "record"
    rec._name = name
    rec._tags = _tags
    rec.fields = fields
    rec.methods = methods
    return rec
end

-- Helper to define an Field for record or namespaces
-- Namespace and Record types have named items
function M.Field(name, itemdef, _tags)
    assert(type(name) == "string")
    local ret = {}
    ret._kind = "field"
    ret._name = name
    ret._tags = _tags
    ret.value_type = itemdef
    return ret
end


function M.Method(name, _tags)
    assert(type(name) == "string")
    local ret = {}
    ret._kind = "method"
    ret._name = name
    ret._tags = _tags
    return ret
end



-- variants have options (themselves types)
function M.Variant(name, options, _tags)
    assert(type(options) == "table")
    local rec = {}
    rec._kind = "variant"
    rec._name = name
    rec._tags = _tags
    rec.options = options
    return rec
end

-- Helper to define an Option for Variant types
function M.Option(name, itemdef, _tags)
    local ret = {}
    ret._kind = "option"
    ret._name = name
    ret._tags = _tags
    ret.value_type = itemdef
    return ret
end



-- enums have choices (which are strings)
function M.Enum(name, choices, _tags)
    assert(type(name) == "string", "name: " .. type(name))
    local ret = {}
    ret._kind = "enum"
    ret._name = name
    ret._tags = _tags
    ret.choices = choices
    return ret;
end


-- functions have arg and return types specified in arrays of arg or ret values
function M.Function(name, args, rets, _tags)
    args = args or {}
    rets = rets or {}
    assert(type(args) == "table")
    assert(type(rets) == "table")
    assert(type(name) == "string", "name: " .. type(name))
    local ret = {}
    ret._kind = "function"
    ret._name = name
    ret._tags = _tags
    ret.args = args
    ret.rets = rets
    return ret
end

-- helper to define function args
function M.Arg(name, itemdef, _tags)
    assert(type(name) == "string")
    local ret = {}
    ret._kind = "arg"
    ret._name = name
    ret._tags = _tags
    ret.value_type = itemdef
    return ret
end

-- helper to define function rets
function M.Ret(name, itemdef, _tags)
    local ret  = {}
    ret._kind = "ret"
    ret._name = name
    ret._tags = _tags
    ret.value_type = itemdef
    return ret
end






function M.process(ns)
    local ret = {}
    ret._name = ns._name
    assert(ns._kind == "namespace", "top level should be a 'namespace' but is '" ..  ns._kind or "nil" .. "'")

    local items = ns.items

    ret.enums = {}
    ret.records = {}
    ret.variants = {}
    ret.lists = {}
    ret.tuples = {}
    ret.dicts = {}
    ret.functions = {}

    -- name -> kind mapping
    local defined_types = {}
    -- name -> args * rets mapping
    local function_args_rets = {}

    -- identify defined types to help with filling in information below
    -- also function name to argument/return info mappings
    -- also add namespaced "nativename" field to each toplevel
    for i=1,#items do
        local item = items[i]
        defined_types[item._name] = item._kind
        if item._kind == "function" then
            function_args_rets[item._name] = {
                args = item.args,
                rets = item.rets,
            }
        end
        item._nativename = ns._name .. "_" .. item._name
        if item._tags and item._tags.ctor then
            item._nativename = item._nativename .. "_ctor"
        end
        if item._tags and item._tags.c_api_skip then
            item._nativename = "_c_skip_" .. item._nativename
        end
    end

    local function kind_to_nativetype(kind, typename)
        if kind == "function" then return "C_UNKNOWN__fn"
        elseif kind == "record" then return ret._name .. "_" .. typename
        elseif kind == "variant" then return ret._name .. "_" .. typename
        elseif kind == "enum" then return ret._name .. "_" .. typename
        elseif kind == "list" then return ret._name .. "_" .. typename
        elseif kind == "tuple" then return ret._name .. "_" .. typename
        elseif kind == "dict" then return ret._name .. "_" .. typename
        else error("Unknown kind: " .. kind) end
    end

    local function kind_to_luatype(kind)
        if kind == "function" then return "function"
        elseif kind == "record" then return "userdata"
        elseif kind == "variant" then return "__UNKNOWN_one_of_" .. ret._name .. "__"
        elseif kind == "enum" then return "string"
        elseif kind == "list" then return "table"
        elseif kind == "tuple" then return "table"
        elseif kind == "dict" then return "table"
        else error("Unknown kind" .. kind) end
    end

    local function kind_to_lua_metatable(kind, typename)
        if kind == "record" then
            return ret._name .. "." .. typename
        end
        return nil
    end

    -- enums
    for i=1,#items do
        local item = items[i]
        if item._kind == "enum" then
            table.insert(ret.enums, item)
        end
    end


    -- records
    for i=1,#items do
        local item = items[i]
        if item._kind == "record" then
            for j=1,#item.fields do
                local field = item.fields[j]
                -- field
                if field.value_type.typename ~= "PRIMITIVE" then
                    local kind = defined_types[field.value_type.typename]
                    field.value_type.luatype = kind_to_luatype(kind)
                    field.value_type.nativetype = kind_to_nativetype(kind, field.value_type.typename)
                    field.value_type.metatable = kind_to_lua_metatable(kind, field.value_type.typename)
                    field.value_type._kind = kind
                else
                    field.value_type._kind = "primitive"
                    field.value_type.typename = nil
                end
            end

            -- arg and ret info for this method, from the mapped function
            for j=1,#item.methods do
                local method = item.methods[j]
                local mapped_fn = function_args_rets[method._tags.map_to]
                if mapped_fn then
                    method.args = mapped_fn.args
                    method.rets = mapped_fn.rets
                else
                    error("No fn mapping found for the method: " .. method._name .. " from record: " .. item._name)
                    method.args = "_UNKNOWN_METHOD_ARGS"
                    method.rets = "_UNKNOWN_METHOD_RETS"
                end
            end

            table.insert(ret.records, item)
        end
    end

    -- variants
    for i=1,#items do
        local item = items[i]
        if item._kind == "variant" then
            for j=1,#item.options do
                local opt = item.options[j]
                -- opt
                if opt.value_type.typename ~= "PRIMITIVE" then
                    local kind = defined_types[opt.value_type.typename]
                    opt.value_type.luatype = kind_to_luatype(kind)
                    opt.value_type.nativetype = kind_to_nativetype(kind, opt.value_type.typename)
                    opt.value_type.metatable = kind_to_lua_metatable(kind, opt.value_type.typename)
                    opt.value_type._kind = kind
                else
                    opt.value_type._kind = "primitive"
                    opt.value_type.typename = nil

                end
            end
            table.insert(ret.variants, item)
        end
    end


    -- lists
    for i=1,#items do
        local item = items[i]
        if item._kind == "list" then
            -- list key
            if item.value_type.typename ~= "PRIMITIVE" then
                local kind = defined_types[item.value_type.typename]
                item.value_type.luatype = kind_to_luatype(kind)
                item.value_type.nativetype = kind_to_nativetype(kind, item.value_type.typename)
                item.value_type.metatable = kind_to_lua_metatable(kind, item.value_type.typename)
                item.value_type._kind = kind
            else
                item.value_type._kind = "primitive"
                item.value_type.typename = nil
            end
            table.insert(ret.lists, item)
        end
    end

    -- tuples
    for i=1,#items do
        local item = items[i]
        if item._kind == "tuple" then
            -- list key
            if item.value_type.typename ~= "PRIMITIVE" then
                local kind = defined_types[item.value_type.typename]
                item.value_type.luatype = kind_to_luatype(kind)
                item.value_type.nativetype = kind_to_nativetype(kind, item.value_type.typename)
                item.value_type.metatable = kind_to_lua_metatable(kind, item.value_type.typename)
                item.value_type._kind = kind
            else
                item.value_type._kind = "primitive"
                item.value_type.typename = nil
            end
            table.insert(ret.tuples, item)
        end
    end

    -- dicts
    for i=1,#items do
        local item = items[i]
        if item._kind == "dict" then
            -- dict key
            if item.key_type.typename ~= "PRIMITIVE" then
                local kind = defined_types[item.key_type.typename]
                item.key_type.luatype = kind_to_luatype(kind)
                item.key_type.nativetype = kind_to_nativetype(kind, item.key_type.typename)
                item.key_type.metatable = kind_to_lua_metatable(kind, item.key_type.typename)
                item.key_type._kind = kind
            else
                item.key_type._kind = "primitive"
                item.key_type.typename = nil
            end
            -- dict val
            if item.value_type.typename ~= "PRIMITIVE" then
                local kind = defined_types[item.value_type.typename]
                item.value_type.luatype = kind_to_luatype(kind)
                item.value_type.nativetype = kind_to_nativetype(kind, item.value_type.typename)
                item.value_type.metatable = kind_to_lua_metatable(kind, item.value_type.typename)
                item.value_type._kind = kind
            else
                item.value_type._kind = "primitive"
                item.value_type.typename = nil
            end
            table.insert(ret.dicts, item)
        end
    end

    -- functions
    for i=1,#items do
        local item = items[i]
        if item._kind == "function" then
            for j=1,#item.args do
                local arg = item.args[j]
                -- arg
                if arg.value_type.typename ~= "PRIMITIVE" then
                    local kind = defined_types[arg.value_type.typename]
                    arg.value_type.luatype = kind_to_luatype(kind)
                    arg.value_type.nativetype = kind_to_nativetype(kind, arg.value_type.typename)
                    arg.value_type.metatable = kind_to_lua_metatable(kind, arg.value_type.typename)
                    arg.value_type._kind = kind;
                else
                    arg.value_type._kind = "primitive"
                    arg.value_type.typename = nil
                end
            end
            for j=1,#item.rets do
                local ret = item.rets[j]
                -- ret
                if ret.value_type.typename ~= "PRIMITIVE" then
                    local kind = defined_types[ret.value_type.typename]
                    ret.value_type.luatype = kind_to_luatype(kind)
                    ret.value_type.nativetype = kind_to_nativetype(kind, ret.value_type.typename)
                    ret.value_type.metatable = kind_to_lua_metatable(kind, ret.value_type.typename)
                    ret.value_type._kind = kind
                else
                    ret.value_type._kind = "primitive"
                    ret.value_type.typename = nil
                end
            end

            table.insert(ret.functions, item)
        end
    end


    return ret
end


return M
