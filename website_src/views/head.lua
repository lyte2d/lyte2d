local function Head(title)
    return H.head {
        H.meta {name="viewport", content="width=device-width, initial-scale=1.0"},
        H.meta {charset="UTF-8"},
        H.title("[Lyte2D] " .. title),
        H.link {rel="icon", type="image/png", href="public/icon.png"},
        H.link {rel="stylesheet", href="public/prism.min.css"},
        H.link {rel="stylesheet", href="public/style.css"},
        H.script {src="public/prism.min.js"},
        H.script {src="public/prism-lua.min.js"},
        H.script {src="public/prism-typescript.min.js"},
    }
end

return Head
