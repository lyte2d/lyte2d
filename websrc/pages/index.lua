local Layout = require "views.layout"
local Code = require "views.code"
local Section = require "views.section"
local MenuLink = require "lib.menulink"
local MenuLinkExt = require "lib.menulinkext"
local Data = require "data"

local simple1 = [[
function frame()
    draw_text("Hello, world", 0, 0)
end
]]


local _examples = H.ul { id="examplesdropdown", class="dropdown-menu",
    H.li {
        H.a {class="menulink", target="none", onclick="on_examplelink_click(event, 'empty')", href="about:blank",
            H.div {style="display: none;", ""},
            "(None)"
        }
    }
}

for _, v in ipairs(Data.examples) do
    local l = H.li { id=v.app,
        H.a {class="menulink", target="none", onclick="on_examplelink_click(event, '" .. v.app .. "')", href="about:blank",
            H.div {style="display: none;", v.src},
            v.app,
        }
    }
    _examples:append(l)
end


local function Page()
    return Layout( "Home",
        Section ("about",
            H.div{class="title", "About"},
            H.p "Lyte2D is a simple, free and opensource lightweight Lua framework for writing games and other applications. It's inspired by Love2D.",
            "Hello world in Lyte2D",
            Code ({id="example-1", style="background-color:inherit"}, simple1),
            H.script [[ Prism.highlightElement(document.getElementById("example-1")); ]],
            H. p "Lyte2D is small (Windows binary is less than 1MB zipped) and supports HTML5 by compiling into WASM.",
            H.p {style="color: brown;", [[
                Lyte2D is currently "alpha" software.
                Unless you know what you're doing, you probably shouldn't use it in "production."
                Website and documentation is lacking!
                But if you have some programming experience, especially with Love2D you should be fine.
                ]]
            },
            H.b "Basics of Lyte2D",
            H.p "Lyte2D works on Windows, Linux (including SteamDeck) and HTML5.",
            H.b "Downloads",
            H.ul {
                H.li {"Binaries", MenuLinkExt("https://morew4rd.itch.io/lyte2d","https://morew4rd.itch.io/lyte2d")},
                H.li {"Source snapshot", MenuLinkExt("https://github.com/morew4rd/lyte2d", "https://github.com/morew4rd/lyte2d")},
            },
            H.p "Once you download the binary zip, just put lyte2d.exe somewhere in your path (or in a local directory where you'll write your game.)",
            H.b "Some games made with Lyte2D",
            H.ul {
                H.li {
                    H.b "Pong Out", " is on", MenuLinkExt("https://m04r.itch.io/pong-out","https://m04r.itch.io/pong-out"), " where you can play on your browser, download a small Windows binary or just download the sources",
                },
                H.li {H.b "Snek Head", "- TBD"},
            },
        ""),
        Section ("examples",
            H.div {class="title", "Examples"},

            H.div { class="dropdown",
                H.div {
                    H.button {class="dropdown-toggle", type="button", id="dropdownMenuButton", onclick="toggleDropdownMenu()", "Examples ▼"},
                    H.span {id="examplename"},
                    H.a {id="examplenewlink", target="_blank", class="menulink", href="" },
                },
                _examples,
            },
            H.div {class="resizer ugly",
                H.iframe {id="demosiframe", title="demos", name="demos", class="resized lyte-iframe"},
            },
            H.div {class="resizer2 ugly",
                H.div {class="resized source-area",
                    H.pre {H.code {id="examplecode", class="language-lua"}},
                },
            },
        ""),
        Section ("guide",
            H.div {class="title", "User guide"},
            H.p "",
            H.b "Get started",
            H.ul {
                H.li " Create an <code>app.lua</code> file ",
                H.li " Implement a global function with the name <code>frame</code>.  (See examples) ",
                H.li "Start it with <code>lyte2d</code>",
                H.li "You can get to a REPL to inspect/edit your game real time. Start with <code>lyte2d repl=lua</code>.",
                H.li "To start an app in another directory you can do <code>lyte2d dir=/sources/games/mycoolgame</code>.  Use '/' is supported as the directory seperator. On Windows '\\\\' is also supported",
                H.li "To start an app with a different name  you can do <code>lyte2d app=mygame</code>.  Can be mixed with <code>dir</code> argument",
                H.li "You can also start a game from a zip file with <code>lyte2d zip=myapp.zip</code> If there's a file named app.zip, it'll automatically be loaded",
                H.li "Lyte2D supports LOVE2D style app fusing. You can create a single executable (fused exe + zip).  Documents TBD, but Makefile has an example for the Pong Out game",
            },
            H.b "Known issues with alpha",
            H.ul {
                H.li " Error messages ",
                H.li " Circle drawing can have minor issues ",
                H.li " Font rendering can have minor issues ",
                H.li " Missing features (coming up in later release): shaders, physics, etc.",
            }
        ),
        Section ("api",
            H.div {class="title", "API"},
            H.div {class="api-scroller",
                Code ({id="code-api", style="background-color:inherit"}, Data.apitxt),
                H.script [[ Prism.highlightElement(document.getElementById("code-api")); ]]
            }
        ),
        H.script [[
            function toggleDropdownMenu() {
                let dropdownMenu = document.querySelector(".dropdown-menu");
                if (dropdownMenu.style.display === "block") {
                  dropdownMenu.style.display = "none";
                } else {
                  dropdownMenu.style.display = "block";
                }
              }

              function closeDropdownMenu() {
                let dropdownMenu = document.querySelector(".dropdown-menu");
                dropdownMenu.style.display = "none";
              }

              function on_examplelink_click(ev, app) {
                ev.preventDefault();

                let el_iframe = document.getElementById('demosiframe');
                el_iframe.setAttribute("src", app === "empty" ? "" : "lyte2d.html?zip=examples.zip&app=" + app);

                closeDropdownMenu();

                let el_code = document.getElementById("examplecode");
                el_code.innerHTML = ev.target.children[0].innerText;
                Prism.highlightElement(el_code);

                document.getElementById("examplename").innerText = app === "empty" ? "" : " " + app + " ";
                let el_newlink = document.getElementById("examplenewlink");
                el_newlink.innerText = app === "empty" ? "" : "Open in new tab";
                el_newlink.setAttribute("href", "lyte2d.html?zip=examples.zip&app=" + app);
              }

        ]]
    )

end

print(Page())
