local function MenuLinkExt(text, href)
    return H.a {class="menulinkext", target="_blank", href=href, text.."⧉"}
end

return MenuLinkExt