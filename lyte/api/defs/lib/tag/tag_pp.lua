-- (c) 2023 MG.  Choice of: MIT license/public domain. Just copy paste :)

local TAB = 4

local function pp(t, ret, depth)
    assert(t)
    if type(t) == "string" then
        local tv = t
        t = { _kind = "(string)", _name = tv}
    end
    assert(t._kind)
    assert(t._name)
    ret = ret or ""
    depth = depth or 0
    assert(type(depth) == "number")
    assert(type(ret) == "string")
    ret = ret .. string.rep(" ", depth) .. t._kind .. " " .. t._name
    if t.items then
        ret = ret .. ": \n"
        for _, ti in ipairs(t.items) do
            ret = pp(ti, ret, depth + TAB)
        end
    else
        ret = ret .. "\n"
    end

    return ret
end

return pp
