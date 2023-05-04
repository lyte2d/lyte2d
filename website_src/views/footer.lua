-- local MenuLink = require "lib.menulink"
local MenuLinkExt = require "lib.menulinkext"

local function Footer()
    return H.footer {
        H.div { class="textcenter",
            "(c) moreward",
            MenuLinkExt("web", "https://morew4rd.com"),
            MenuLinkExt("twitter", "https://twitter.com/morew4rd"),
            MenuLinkExt("github", "https://github.com/morew4rd"),
            MenuLinkExt("itch.io", "https://morew4rd.itcH.io"),
        }
    }
end

return Footer