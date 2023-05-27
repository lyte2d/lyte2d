---------------------------------------------------------------------------------------------
-- API definition helpers
---------------------------------------------------------------------------------------------

local M = {}

local function _basetype(t)
    return t
end

-- BASE TYPES
function M.String()
    return _basetype("string" )
end

function M.Integer()
    return _basetype("integer")
end

function M.Float()
    return _basetype("float")
end

function M.Number()
    return _basetype("number")
end

function M.Boolean()
    return _basetype("boolean")
end

function M.Nil()
    return _basetype("nil")
end

-- use this to specify any named type (that you defined as a record or something)
function M.Type(defined_name)
    return _basetype(defined_name)
end

-- namespaces have items
function M.Namespace(name, items, tags)
    assert(type(name) == "string")
    assert(type(items) == "table")
    local rec = {}
    rec._kind = "namespace"
    rec._tags = tags
    rec._name = name
    rec.items = items
    return rec
end

-- records have items
function M.Record(name, items, tags)
    assert(type(name) == "string")
    items = items or {}
    assert(type(items) == "table")
    local rec = {}
    rec._kind = "record"
    rec._tags = tags
    rec._name = name
    rec.items = items
    return rec
end

-- Helper to define an Field for record or namespaces
-- Namespace and Record types have named items
function M.Field(name, itemdef, tags)
    assert(type(name) == "string")
    local ret = {}
    ret._tags = tags
    ret._kind = "prop"
    ret._name = name
    ret.value = itemdef
    return ret
end

-- -- Helper to define an Field for record
-- -- Namespace and Record types have named items
-- function M.Field(name, itemdef, tags)
--     assert(type(name) == "string")
--     local ret = {}
--     ret._tags = tags
--     ret._name = name
--     ret.value = itemdef
--     return ret
-- end

-- oneofs have options (themselves types)
function M.OneOf(name, options, tags)
    assert(type(options) == "table")
    local rec = {}
    rec._kind = "oneof"
    rec._tags = tags
    rec._name = name
    rec.options = options
    return rec
end

-- Helper to define an Option for OneOf types
function M.Option(itemdef, tags)
    local ret = {}
    ret._kind = "option"
    ret._tags = tags
    ret.value = itemdef
    return ret
end

-- enums have choices (which are strings)
function M.Enum(name, choices, tags)
    assert(type(name) == "string", "name: " .. type(name))
    local ret = {}
    ret._kind = "enum"
    ret._tags = tags
    ret._name = name
    ret.choices = choices
    return ret;
end

-- dicts have key and value types
function M.Dict(key, value, tags)
    local ret = {}
    ret._kind = "dict"
    ret._tags = tags
    ret.dict_key = key
    ret.dict_value = value
    return ret;
end

-- lists have value type
function M.List(value, tags)
    local ret = {}
    ret._kind = "list"
    ret._tags = tags
    ret.value = value
    return ret;
end

-- function helper for Function and Method calls
local function _functionlike(kind, name, args, rets, tags)
    args = args or {}
    rets = rets or {}
    local fun = {}
    fun._kind = kind
    fun._tags = tags
    assert(type(name) == "string", "name: " .. type(name))
    assert(type(args) == "table")
    assert(type(rets) == "table")
    fun._name = name
    fun.args = args
    fun.rets = rets
    -- return def("t_function", tags, {})
    return fun
end
-- functions have arg and return types specified in arrays of arg or ret values
function M.Function(name, args, rets, tags)
    return _functionlike("function", name, args, rets, tags)
end

function M.Method(name, args, rets, tags)
    return _functionlike("method", name, args, rets, tags)
end

-- helper to define function args
function M.Arg(name, itemdef, tags)
    assert(type(name) == "string")
    local ret = {}
    ret._tags = tags
    ret._name = name
    ret.value = itemdef
    -- return def("fn_arg", tags, itemdef)
    return ret
end

-- helper to define function rets
function M.Ret(name, itemdef, tags)
    local ret  = {}
    ret._tags = tags
    ret._name = name
    ret.value = itemdef
    return ret
end

-- ALIAS to have type aliases to Dict, Liet etc
function M.Alias(name, val, tags)
    assert(type(name) == "string")
    local ret = {}
    ret._kind = "alias"
    ret._tags = tags
    ret._name = name
    ret.alias_value = val
    return ret;
end

-- traverse the defined tree with this funciton
local function traverse(defs, PP, depth)

    if type(defs) == "string" then
        PP.Type(defs, "", depth)
        return
    end

    local name = defs._name or ""
    local value = defs.value

        depth = depth or 0
        assert(type(defs) == "table")
        -- check if defs has "_kind" to ensure oneof is handled

        if not value then
            if     defs._kind == "namespace"
                or defs._kind == "record"
                or defs._kind == "function"
                or defs._kind == "enum"
                or defs._kind == "alias"
                or defs._kind == "oneof"
                or defs._kind == "method"
                or defs._kind == "list"
                or defs._kind == "dict"
                then
                    value = defs
            else
                error("Unknown value kind: '" .. defs._kind .. "'")
            end
        else
            -- TODO: this will be an error
        end

    if type(value) == "string" then
        PP.Type(value, name, depth)
    elseif type(value) == "table" then

        if (value._kind) then
            local k = value._kind
            local tags = value._tags or {}

            -- namespace and records are special because they have named items themselves
            if k == "namespace" then
                local items = value.items
                PP.NS(items, depth, name, tags, traverse)
            elseif k == "record" then
                local items = value.items
                PP.Record(items, depth, name, tags, traverse)
            elseif k == "function" then
                local args = value.args
                local rets = value.rets
                PP.Function(args, rets, depth, name, tags, traverse)
            elseif k == "enum" then
                PP.Enum(value.choices, depth, name, tags, traverse)
            elseif k == "alias" then
                -- local val = value.value (Alias value is already correctly pointing to a type)
                PP.Alias(value.alias_value, depth, name, tags, traverse)
            elseif k == "oneof" then
                local options = value.options
                PP.OneOf(options, depth, name, tags, traverse)

            elseif k == "method" then
                local args = value.args
                local rets = value.rets
                PP.Method(args, rets, depth, name, tags, traverse)
            elseif k == "dict" then
                local dict_key = value.dict_key
                local dict_value = value.dict_value
                PP.Dict(dict_key, dict_value, depth, name, tags, traverse)
            elseif k == "list" then
                -- local list_value = value.list_value
                PP.List(value, depth, name, tags, traverse)

            else
                error("Internal (25): Shouldn't happen.")
            end
        else
            error("Internal (40): value is a table, but does not specify it's kind for name: " .. name)
        end
    else
        error("Internal (50): Unknown value type: " .. type(value) .. " for name " .. (name or ""))
    end
end

M.traverse = traverse

return M