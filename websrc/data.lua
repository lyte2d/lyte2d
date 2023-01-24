local Data = {}

Data.apitxt = "API description not found."

do
    -- local file = io.open("../websrc/code/simple1.lua", "r")
    -- simple1 = tostring(file:read("*a"))
    -- print("[[["..simple1.."]]]")
    -- file:close()
    local file = io.open("../lyte2d/etc/lyte.d.ts", "r")
    Data.apitxt = file:read("*a")
    file:close()
end

Data.examples = {
    {
        title = "Hello world #1",
        app = "hello1"
    },
    {
        title = "Hello world #2",
        app = "hello2",
    },
    {
        title =  "Shapes #1",
        app = "shapes1",
    },
    {
        title = "Image #1",
        app =  "image1",
    },
    {
        title = "Image #2",
        app =  "image2",
    },
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
