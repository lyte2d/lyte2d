local MenuLink = require "lib.menulink"

local function Header()
    return H.header {id="top",
        H.section {class="container textcenter", style="padding-bottom: 10px; flex-direction: column",
            H.a {href="index.html#top", class="item",style="padding-top:10px; padding-left:10px;",
                H.span {class="logo", "Lyte2D"},
            },
            H.div {
                class="item textcenter", style="padding-top:10px;",
                MenuLink("About", "index.html#about"),
                H.span("| "),
                MenuLink("Examples", "index.html#examples"),
                H.span("| "),
                MenuLink("User guide", "index.html#guide"),
                H.span("| "),
                MenuLink("API", "index.html#api"),
            },
            H.div {class="item1", " "}
        },
        H.a {href="index.html#top", style="position:fixed; top: 25px; right: 20px;",
            H.img {src="public/icon.png", height="25px"}
        },

    }
end

return Header