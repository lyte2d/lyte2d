-- (c) 2023 MG.  Choice of: MIT license/public domain. Just copy paste :)

-- create a basic recursive tree. Tags have kind, name and items.
-- Tag creates a tag constructor with a given kind (k)
-- The constructors create tree nodes themselves
-- kind has to be string. name can be a string, number, boolean

local TAB = 4

local function Tag(k)
    assert(type(k) == "string")
    return function(n, ...)
        local nt = type(n)
        assert(nt == "string" or nt == "number" or nt == "boolean")
        local itms = nil
        if select("#", ...) > 0 then itms = { ... } end
        -- workaround:
        -- allow for cases like KeyboardKey enum where there are too many items
        -- to pass as func params. so passing as a list is allowed
        if select("#", ...) == 1 then
            local itm = ({...})[1]
            if (itm and getmetatable(itm) and getmetatable(itm).is_tag) then
                --- all good. single item, but's its a tag
            else
                -- it's a list for the workaround mentioned above for large number of itmes. e.g. KeyboardKey enum
                for i=2, #itms do
                    table.insert(itm, itms[i])
                end
                itms = itm
            end
        end
        local ret = { _kind = k, _name = n, items = itms }
        local meta = { is_tag = true }
        setmetatable(ret, meta)
        return ret
    end
end

return Tag
