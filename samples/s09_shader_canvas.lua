-- lyte sample

local state = {totaltime = 0}

local shader1 = lyte.new_shader({
    uniforms = {
        time = "float",
        screensize = "vec2"
    },
    vert = [[
        in vec4 coord;
        out vec2 image_uv;
        void vert_main() {
            gl_Position = vec4(coord.xy, 0.0, 1.0);
            image_uv = coord.wz;
        }
    ]],
    frag = [[
        // ported from a Love2D shader called
        // "spinning_plus"

        #define PI 3.14159265359

        mat2 rotate2d(float _angle) {
            return mat2(cos(_angle),-sin(_angle), sin(_angle),cos(_angle));
        }

        float box(in vec2 _st, in vec2 _size) {
            _size = vec2(0.5) - _size*0.5;
            vec2 uv = smoothstep(_size, _size+vec2(0.001), _st);
            uv *= smoothstep(_size, _size+vec2(0.001), vec2(1.0)-_st);
            return uv.x*uv.y;
        }

        float xcross(in vec2 _st, float _size) {
            return  box(_st, vec2(_size,_size/4.)) + box(_st, vec2(_size/4.,_size));
        }


        in vec2 image_uv;
        out vec4 frag_color;
        void frag_main() {
            vec2 st = gl_FragCoord.xy/screensize.xy;
            vec3 color2 = vec3(0.0);

            // move space from the center to the vec2(0.0)
            st -= vec2(0.5);
            // rotate the space
            st = rotate2d( sin(time)*PI ) * st;
            // move it back to the original place
            st += vec2(0.5);

            // Show the coordinates of the space on the background
            color2 = vec3(st.x,st.y,0.0);

            // Add the shape on the foreground
            color2 += vec3(xcross(st,0.4));
            frag_color = vec4(color2, 1.0);

        }
    ]]
})

local canvas = lyte.new_canvas(120,120)

lyte.set_window_minsize(400, 300)

function lyte.tick(dt, width, height, resized)
  state.totaltime = (state.totaltime + dt)

  local mx = lyte.get_mouse_x()
  local my = lyte.get_mouse_y()

  -- draw on the canvas with the shader
  lyte.set_canvas(canvas)
  lyte.cls(0, 0, 0, 1)
  -- send should be after cls (a current limitation)
--   shader1:set({ time = state.totaltime, screensize = {canvas.width, canvas.height} })
  shader1:set("time", state.totaltime)
  shader1:set("screensize", {canvas.width, canvas.height})
  lyte.set_shader(shader1)
  lyte.set_color(1, 1, 1, 1)
  lyte.draw_rect(10, 10, (canvas.width - 20), (canvas.height - 20))
  lyte.reset_shader()
  lyte.reset_canvas()


  -- draw the canvas image on the screen
  lyte.cls(0, 0, 0, 1)
  lyte.push_matrix()
  lyte.translate(mx, my)
  lyte.rotate(-state.totaltime)
  lyte.draw_image(canvas, -canvas.width/2, -canvas.height/2)
  lyte.pop_matrix()

  lyte.draw_text("lyte2d shader inside canvas. move mouse.", 5, (height - 40))
end
