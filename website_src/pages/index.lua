local Layout = require "views.layout"
local Code = require "views.code"
local Section = require "views.section"
local MenuLink = require "lib.menulink"
local MenuLinkExt = require "lib.menulinkext"
local Data = require "data"

local simple1 = [[
function lyte.tick()
    lyte.draw_text("Hello, world", 0, 0)
end
]]

local cfg1 = [[
return {
    window_width = 800,
    window_height = 500,
    window_title = "my game",
    fulscreen = false,
    window_vsync = true,
    default_filtermode = "nearest", -- linear
    default_blendmode = "blend",
  }
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
            H.p [[ Lyte2D is a simple, lightweigth, free and opensource Lua framework for writing games. ]],
            H.p [[ Lyte2D is inspired by LOVE2D.]],
            H.p [[ Hello world in Lyte2D: ]],
            Code ({id="example-1", style="background-color:inherit"}, simple1),
            H.script [[ Prism.highlightElement(document.getElementById("example-1")); ]],
            H. p "Lyte2D is small (Windows and Linux binaries are each less than 2 MB zipped) and supports HTML5 by compiling into WASM.",
            H.p {style="color: brown;", [[
                Lyte2D is currently "alpha" software.
                Unless you know what you're doing, you probably shouldn't use it in "production."
                But if you have some programming experience, especially with Lua you should be fine.
                As such, it's ready to use for experimentation and "jam" style games.
            ]]},
            H.p "Lyte2D works on Windows, Linux (including SteamDeck) and HTML5.",
            H.b "Downloads",
            H.ul {
                H.li {"Binaries", MenuLinkExt("https://github.com/morew4rd/lyte2d/releases","https://github.com/morew4rd/lyte2d/releases")},
                H.li {"Source snapshot", MenuLinkExt("https://github.com/morew4rd/lyte2d", "https://github.com/morew4rd/lyte2d")},
            },
            H.p "Once you download the binary zip, just put lyte.exe somewhere in your path (or in a local directory where you'll write your game.)",
            H.b "Some jam games made with Lyte2D",
            H.ul {
                H.li {
                    H.b "Pong Out", " is on", MenuLinkExt("https://m04r.itch.io/pong-out","https://m04r.itch.io/pong-out"), " where you can play on your browser, download a binary or just download the sources",
                },
                -- H.li {H.b "Snek Head", "- TBD"},
            },
        ""),
        Section ("examples",
            H.div {class="title", "Examples"},
            H.p "Note: Both canvas and code areas are resizable. You can also open the canvas area in a full browser tab.",
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
            H.p "Download the executable and place it somewhere in your path. 'lyte.exe' (or 'lyte' on linux) is assumed to be in your path.",
            H.ul {
                H.li "Create an <code>app.lua</code> file.",
                H.li "Implement <code>lyte.tick</code> function.  (See examples) ",
                H.li "Make sure you're in the same directory in your shell/cmd window",
                H.li "Start your game with <code>lyte</code>.",
            },
            H.b "Want to run some code in another location?",
            H.ul{
                H.li "If you want to use another directory as the base, you can do <code>lyte dir=../my_games/testgame</code> ",
                H.li "If you want to use another file as your 'main' file, you can do <code>lyte app=myapp</code>, assuming you have 'myapp.lua' in the current directory. You should NOT specify the extension",
                H.li "<code>dir=...</code> and <code>app=...</code> arguments can be combined to run a file in an arbitrary directory",
            },
            H.b "Package your game once you're ready.",
            H.ul {
                H.li "Ready to share your game with others? Cool!",
                H.li "Create an 'app.zip' file. Inside the zip, 'app.lua' should be at the root/topmost location",
                H.li "Copy 'lyte.exe', and rename it to 'mygame.exe' (swap 'mygame' for your chosen binary name)",
                H.li "Alternatively, consider using 'lyte_gui.exe' on Windows, for no-console launch",
                H.li "Running <code>mygame</code> will automatically load app.zip if it's in the same directory.",
                H.li "Option 1: you can share the exe and the zip file, and your players can play it as it is",
                H.li "Option 2: Fuse your app (next section.)",
            },
            H.b "App 'fusing'",
            H.ul {
                H.li "Lyte2D support LOVE2D style app fusing. Basically you merge the exe and the zip files into a single binary that will contain everything needed to run your code.",
                H.li "On linux you can do <code>cat lyte.exe app.zip > mygame.exe</code>. Then just distribute 'mygame.exe' however you'd like.",
                H.li "Similar on Windows. (...to be documented, in the meantime see LOVE2D docs.)",
            },
            H.b "Configuring your app.",
            H.ul {
                H.li "If you'd like to configure your window size, fullscreen, etc. before the app loads, you can create a 'config.lua' file next to your 'app.lua'. Here's an example config.lua file: ",
                Code ({id="cfg-1", style="background-color:inherit"}, cfg1),
                H.script [[ Prism.highlightElement(document.getElementById("cfg-1")); ]],
                H.li "Note: you need to keep this file next to the zip or exe file if you fuse your app",
            },
            H.b "HTML5 -- browser games!",
            H.ul {
                H.li "Lyte2D has WASM builds! Just put your `app.zip` file next to the HTML5 files. (lyte.html, lyte.js, lyte.wasm).",
                H.li "Rename 'lyte.html' to suit your needs. And put all four files up on a static host (itch.io, github pages, etc.)",
            },
            H.b "'Advanced' features",
            H.ul {
                H.li "You can get to a REPL to inspect/edit your game real time. Start with <code>lyte repl=lua</code>.",
                H.li "In REPL mode, you can stop the game anytime, inspect/change global variables, and do whatever before continuing the game.",
                H.li "On Windows just typing a letter will pause the game. And you can start using lyte as a Lua REPL.",
                H.li "Similar on Linux, however the key is not captured. So after the first key (any key), you can type the commands.",
                H.li "Hit enter on an empty line to unpause the game loop.",
            },
            H.b "Known issues with alpha",
            H.ul {
                H.li "Functions do not have default arguments, so all arguments must be passed to each function. This will be fixed in a later release.",
                H.li "Line/Circle drawing can have minor issues with very small sizes.",
                H.li "Font rendering can have minor issues",
                H.li "Browser version has rendering problems with pixels. Desktop versions look much better",
                H.li "Browser version has issues, especially delays, with audio rendering. Desktop versions are much better",
                H.li "Firefox has some issues with some shader features, while Edge/Chrome work fine",
                H.li "There could be lurking bugs in native code (alpha software.)",
                H.li "REPL does not provide code-completions yet (although the machinery is there.)",
                H.li "Missing features (coming up in later releases): physics, networking, native UI etc.",
            }
        ),
        Section ("api",
            H.div {class="title", "API"},
            H.p "Note: some of the experimental APIs are not documented.",
            H.div {class="api-scroller",
                Code ({id="code-api", style="background-color:inherit"}, Data.apitxt, "language-typescript"),
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
                el_iframe.setAttribute("src", app === "empty" ? "" : "lyte.html?zip=examples.zip&app=" + app);

                closeDropdownMenu();

                let el_code = document.getElementById("examplecode");
                el_code.innerHTML = ev.target.children[0].innerText;
                Prism.highlightElement(el_code);

                document.getElementById("examplename").innerText = app === "empty" ? "" : " " + app + " ";
                let el_newlink = document.getElementById("examplenewlink");
                el_newlink.innerText = app === "empty" ? "" : "Open in new tab";
                el_newlink.setAttribute("href", "lyte.html?zip=examples.zip&app=" + app);
              }

        ]]
    )

end

print(Page())
