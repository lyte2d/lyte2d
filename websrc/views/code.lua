local function strip(s)
    return s:gsub("^%s+", ""):gsub("%s+$", "").."\n"
    -- return s
end

local function Code(attrs, content, lang)
    lang = lang or "language-lua"
    local id = attrs.id or ""
    local cls = attrs.class or lang
    local style = attrs.style or ""
    return H.pre(H.code({id=id, class=cls, style=style},strip(content)))
end

return Code
