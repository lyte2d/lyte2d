-- lyte sample

local total_time = 0

local img_1 = lyte.load_image("assets/hero.png")
local img_2 = lyte.load_image("assets/char02.png")
local img_3 = lyte.load_image("assets/char03.png")

local shader_1 = lyte.new_shader({
    uniforms = {
        screen_size = "vec2",
        my_img = "sampler2D",
        transparent_mode = "float",
    },
    vert = [[
        in vec4 coords;
        out vec2 image_uv;
        void vert_main() {
            gl_Position = vec4(coords.xy, 0.0, 1.0);
            image_uv = coords.zw;
        }
    ]],
    frag = [[
        in vec2 image_uv;
        out vec4 frag_color;
        void frag_main() {
            if (transparent_mode == 0.0) {
                // current color, but override alpha with 1.0
                frag_color = texture(my_img, image_uv) * vec4((current_color.rgb), 1.0) ;
            } else {
                // add some "washed" transparency by using alpha and the location on screen
                frag_color = texture(my_img, image_uv) * current_color * (2.5*gl_FragCoord.x/screen_size.x);
            }
            if (frag_color.a < 0.01) {
                // don't even
                discard;
            }

        }
    ]]
})


local function draw_some_rects(x,y)
    -- draw some rectangles on different
    lyte.draw_rect(x+10, y, 60, 20)
    lyte.draw_rect(x+80, y, 60, 20)
    lyte.draw_rect(x+150, y, 60, 20)
    lyte.draw_rect(x+220, y, 60, 20)
end


function lyte.tick(dt, width, height)
    -- UPDATE
    total_time = total_time + dt

    shader_1:set("transparent_mode", 0)
    shader_1:set("screen_size", {width, height})

    if lyte.is_key_down("space") or lyte.is_mouse_down("mb1") then
        shader_1:set("transparent_mode", 1 )
    end

    -- DRAW
    lyte.cls(0, 0, 0, 1)

    -- transparent gray color
    lyte.set_color(1,1,1,0.4)
    lyte.set_shader(shader_1)

    shader_1:set("my_img", img_1)

    lyte.draw_rect(10, 10, width-20, 40)

    shader_1:set("my_img", img_2)

    draw_some_rects(10, 60)

    shader_1:set("my_img", img_3 )

    draw_some_rects(30, 90)

    shader_1:set("my_img", img_1 )

    draw_some_rects(60, 120)

    lyte.push_matrix()
    lyte.rotate_at(total_time/2, width/2, height/2)
    lyte.draw_rect(width/2-height*4/9, height/2-25, height*8/9, 50)
    lyte.pop_matrix()

    lyte.reset_shader()

    lyte.reset_color()
    lyte.draw_text("Hold Space/LMB for 'transparent'", 10, height-30)
end
