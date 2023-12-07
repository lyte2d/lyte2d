-- lyte sample

local total_time = 0

-- creating a shader program. single argument is a dictionary
-- which defines the shader.
-- (as of alpha) currently all values need to be passed.
local shader_1 = lyte.new_shader({
    -- uniforms and their types must be defined beforehand. accepted types:
    -- float, vec2, vec3, vec4, mat4, int, ivec2, ivec3, ivec4 and sampler2D
    -- Note: do not declare these inside glsl code. they will be automatically
    --       added to the proper location.
    -- by default, two uniforms are passed and can be used in both shaders:
    -- uniform vec4  current_color --> the value set with lyte.set_color call
    -- uniform sampler2D current_image --> image set wit lyte.draw_image call
    uniforms = {
        screen_size = "vec2",
    },
    -- code for vertex shader. this will be default in a future release
    -- vert_main function must be defined. gl_Position must be set
    -- image_uv name is shared between vertex -> fragment shaders
    -- other can be added by the dev
    vert = [[
        // draw rect sends x, y positions and w/h, 4 floats
        in vec4 coords;
        out vec2 image_uv;
        void vert_main() {
            gl_Position = vec4(coords.xy, 0.0, 1.0);
            image_uv = coords.zw;
        }
    ]],
    -- code for fragment shader.
    -- frag_main function must be defined.
    -- must output a vec4 value representing rgba
    -- image_uv name is shared between vertex -> fragment shaders
    frag = [[
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

    -- shader_1:set({ screen_size = {width, height} })
    shader_1:set("screen_size", {width, height})
    -- lyte.set_shader_uniform(shader_1,  "screen_size", {width, height})
    -- DRAW
    lyte.cls(0, 0, 0, 1)
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
end
