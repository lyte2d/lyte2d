local Attr = {}
local AttrMeta = {
    __index = Attr,
    __tostring = function(attr)
        local str = ""
        for k,v in pairs(attr.fields) do
            str = string.format("%s %s=%q", str, k, v)
        end
        return str
    end
}

function Attr.merge(self, attr)
    for k,v in pairs(attr.fields) do self.fields[k] = v end
end

local function is_attr(t)
    return getmetatable(t) == AttrMeta
end

local function attr(fields)
    return setmetatable({fields=fields}, AttrMeta)
end

local Tag = {}
local TagMeta = {
    __index = Tag,
    __concat = function(tag, x)
        return tostring(tag) .. tostring(x)
    end,
    __tostring = function(tag)
        if tag.options.is_singular then
            local closing_slash = " /"
            if tag.options.no_closing_slash then
                closing_slash = ""
            end
            return string.format("<%s%s%s>%s", tag.name, tag.attributes, closing_slash, tag:content())
        else
            return string.format("<%s%s>%s</%s>", tag.name, tag.attributes, tag:content(), tag.name)
        end
    end
}

local function is_tag(t)
    return getmetatable(t) == TagMeta
end

function Tag.content(tag)
    local str = ""
    for i,v in ipairs(tag.contents) do
        str = str .. tostring(tag.contents[i])
    end
    return str
end

function Tag.append(self, fst, ...)
    -- if type(fst) == "table" and not is_tag(fst) then fst = attr(fst) end
    if type(fst) == "table" and not is_attr(fst) and not is_tag(fst) then
        local f_attr = {}
        -- local f_vals = {}
        local b_hasattr = false
        -- local b_hasvals = false
        for k,v in pairs(fst) do
            if type(k) == "number" then
                -- table.insert(f_vals, v)
                -- table.insert(self.contents, v)
                -- b_hasvals = true
                self:append(v)
            else
                f_attr[k] = v
                b_hasattr = true
            end
        end
        if b_hasattr then
            f_attr = attr(f_attr)
            self:attr(f_attr)
        end
        -- if b_hasvals then
            -- self:append(f_vals)
        -- end


        -- if not is_attr(v) then
        --     for _,vc in ipairs(v) do
        --         table.insert(self.contents, vc)
        --     end
        --     v_attr = attr(v)
        -- else
        --     v_attr = v
        -- end
    -- elseif is_attr(fst) then
    --     self:attr(fst)
    else
        table.insert(self.contents, fst)
    end

    local args = {...}
    for i,v in ipairs(args) do
        -- mg: design thinking
        -- else: if is_tag() ...
        -- else if jsut obj, make it attr() and do attribute thingie instead
        -- (do this in tag() make another arg after opt and if its obj but not tag make it attr)
        if is_attr(v) then
            self:attr(v_attr)
        else
            table.insert(self.contents, v)
        end
    end
    return self
end

function Tag.attr(self, attr)
    self.attributes:merge(attr)
    return self
end

local function tag(name, opt, ...)
    return setmetatable({
        name=name,
        options=opt,
        contents={},
        attributes=attr{}
    }, TagMeta):append(...)
end

local is_singular = {
    img   = true,
    input = true,
    link  = true,
    meta  = true
}

return setmetatable({
    tag=tag,   -- make your own tags
    attr=attr, -- specify attributes
    doctype=function(...)
        -- example custom tag
        return tag("!DOCTYPE html", {is_singular=true, no_closing_slash=true}, ...)
    end
}, {
    -- dynamically generate tags
    __index=function(t, name)
        t[name] = function(...) return tag(name, {is_singular=is_singular[name]}, ...) end
        return t[name]
    end
})