-- lyte sample

local total_time = 0
local image_1 = lyte.load_image("assets/hero.png")

lyte.set_window_title "this is a test :)"
lyte.set_window_icon_file "assets/hero.png"

local sb = lyte.new_shaderbuilder()
sb:uniform("screen_size", "vec2")
sb:vertex [[
    // draw rect sends x, y positions and w/h, 4 floats
    in vec4 coords;
    out vec2 image_uv;
    void vert_main() {
        gl_Position = vec4(coords.xy, 0.0, 1.0);
        image_uv = coords.zw;
    }
]]
sb:fragment  [[
    in vec2 image_uv;
    out vec4 frag_color;
    void frag_main() {
        // default fragment shader looks something like the following
        //frag_color = texture(current_image, image_uv) * current_color;
        // we'll set blue to depend on the screen X of the pixel
        frag_color.b = gl_FragCoord.x / screen_size.x;
        // and red will depend on the texture X and Y of the pixel
        frag_color.r = image_uv.x * image_uv.y * 2.0;
        // and green to be the reverse of blue
        frag_color.g = (1.0 - frag_color.b);
        frag_color.a = 0.9;

    }
]]

local shader_1 = sb:build()

local fnt = lyte.load_font("assets/m5x7.ttf", 3*14)
lyte.set_font(fnt)

local snd1 = lyte.load_sound("assets/sfx_hurt.wav")
local snd2 = lyte.load_sound("assets/sfx_shoot.ogg")
local snd3 = snd1:clone();
local snd4 = snd1:clone();

snd3.pan = 0
snd4.pan = 1

-- snd1:play()
-- snd2:play()
-- snd3:play()
-- snd4:play()

local function draw_some_rects(x,y)
    -- draw some rectangles on different
    lyte.draw_rect(x+10, y, 60, 20)
    lyte.draw_rect(x+80, y, 60, 20)
    lyte.draw_rect(x+150, y, 60, 20)
    lyte.draw_rect(x+220, y, 60, 20)
end

local function draw_some_text(x, y)

    local txt = "lol" .. math.random()
    -- lyte.reset_color()
    lyte.set_color(1,1,1,1)
    lyte.draw_text(txt, x, y)
    -- print(txt)
end

function lyte.tick(dt, width, height)
    -- UPDATE
    total_time = total_time + dt

    shader_1:send("screen_size", {width, height})
    -- lyte.send_shader_uniform(shader_1,  "screen_size", {width, height})
    -- DRAW
    lyte.cls(0, 0, 0, 1)
    lyte.set_color(1,0.5,1,1)
    lyte.reset_color()

    lyte.set_shader(shader_1)

    lyte.draw_rect(10, 10, width-20, 40)

    draw_some_rects(10, 60)
    draw_some_rects(30, 90)
    draw_some_rects(60, 120)

    lyte.push_matrix()
    lyte.rotate_at(total_time/2, width/2, height/2)
    lyte.draw_rect(width/2-height/3, height/2-25, height*2/3, 50)
    lyte.pop_matrix()


    lyte.reset_shader()
    lyte.reset_color()
    lyte.draw_image(image_1, 10, 70)

    lyte.set_color(1,1,0,1)
    lyte.draw_text("HELLOOOOOO", 10, 10)
    draw_some_text(2,50)
end
