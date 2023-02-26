local Data = {}

Data.apitxt = "API description not found."

do
    -- local file = io.open("../websrc/code/simple1.lua", "r")
    -- simple1 = tostring(file:read("*a"))
    -- print("[[["..simple1.."]]]")
    -- file:close()
    local file = io.open("../lyte/etc/lyte.d.ts", "r")
    Data.apitxt = file:read("*a")
    file:close()
end

Data.examples = {
    { title = "Hello World", app = "s01_hello" },
    { title = "Movement, Input", app = "s02_movement", },
    { title =  "Music, Pan, Pitch", app = "s03_music", },
    { title = "Sound FX", app =  "s04_soundfx", },
    { title = "Canvas", app =  "s05_canvas", },
    { title = "Basic Shader", app =  "s06_basic_shader", },
    { title = "Shader with samplers", app =  "s07_basic_shader2", },
    -- == todo: investigate issues on wasm build  wih these new shaders
    -- { title = "Shader spin (ported from Love2D)", app =  "s08_shader_spinning_plus", },
    -- { title = "Shader + canvas", app =  "s09_shader_canvas", },
}

do
    for k, v in pairs(Data.examples) do
        if k ~= "empty" then
            local file = io.open("../examples/" .. v.app .. ".lua", "r")
            v.src = file:read("*a")
            file:close()
        end
    end
end


return Data
