local lyte = require("lyte")



---@type lyte.Image
local i = lyte.load_image("a")



---@type lyte.Music
local jj

local x = lyte.load_image("asd")

local y = lyte.load_music("a")

--- @class Customer
--- @field age number
--- @field name string
local Customer = {}
-- local Customer = {
--     age = 30,
--     name = "hello"
-- }

--- @type fun(name: string): Customer
function Customer.new(name)
    local self = setmetatable({}, {__index=Customer})
    self.age = 30
    self.name = name or "hah"
    return self
end

--- @type fun(self: Customer, name: string)
function Customer:rename(name)
end

a = Customer.new("heh")

local my_music = lyte.load_music("assets/my_cool_tune.mp3")

-- function lyte.tick()
--     lyte.draw_text("hello", 10, 10)
-- end
--
local aa = lyte.load_image("asd")

local x = lyte.new_shaderbuilder()

x:uniform("a", "float")
x:vertex("asda")
local y = x:build()
y:set("test", 1)


lyte.is_mouse_down()
