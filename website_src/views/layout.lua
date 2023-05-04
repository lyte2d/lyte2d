local Head = require "views.head"
local Header = require "views.header"
local Footer = require "views.footer"

local _gtag_script = H.script {src="https://www.googletagmanager.com/gtag/js?id=G-ZCQ9FCCMV2"}
local _gtag_run = H.script [[
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'G-ZCQ9FCCMV2');
]]

local function Layout(title, ...)
    local head = Head(title)
    local header = Header()
    local footer = Footer()
    local main = H.main {...}
    local body = H.body {header, main, footer}
    -- body:append(H.div({id="copyright"}, " &copy;2022, 2023"))
    local doc = H.doctype(H.html{lang="en", head, body, _gtag_script, _gtag_run})
    return doc
end

return Layout