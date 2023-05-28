//

#include <stdio.h>
#include <assert.h>
#include <stdlib.h>
#include <string.h>

#include "lyte_core.h"

#define GLFW_INCLUDE_NONE
#include <GLFW/glfw3.h>

#include "sokol_gfx.h"
#include "sokol_gp.h"


static double curr_t, delta_time, last_t;

static inline void _tick_function(void) {

#if defined(__EMSCRIPTEN__)
    if(lyte_state.do_quit) {
        emscripten_cancel_main_loop();
    }
#endif

    /* Timing */
    curr_t = glfwGetTime();
    delta_time = curr_t - last_t;
    last_t = curr_t;

    int prev_w, prev_h;
    prev_w = lyte_state.window_size.width;
    prev_h = lyte_state.window_size.height;

    int win_w, win_h;

    float RECT_DELT_L = lyte_state.window_paddings.left;
    float RECT_DELT_R = lyte_state.window_paddings.right;
    float RECT_DELT_T = lyte_state.window_paddings.top;
    float RECT_DELT_B = lyte_state.window_paddings.bottom;

    float EMPTY_L = lyte_state.window_margins.left;
    float EMPTY_R = lyte_state.window_margins.right;
    float EMPTY_T = lyte_state.window_margins.top;
    float EMPTY_B = lyte_state.window_margins.bottom;

#if defined(__EMSCRIPTEN__)
    win_w = emsc_width();
    win_h = emsc_height();
#else
        glfwGetFramebufferSize(lyte_state.window, &win_w, &win_h);
#endif

    int fwidth = win_w - RECT_DELT_L - RECT_DELT_R;
    int fheight = win_h - RECT_DELT_T - RECT_DELT_B; // BUGG?
    lyte_state.window_size.width = win_w;
    lyte_state.window_size.height = win_h;
    bool resized = false;
    if (prev_w != lyte_state.window_size.width || prev_h != lyte_state.window_size.height) {
        resized = true;
    }

    sgp_begin(win_w, win_h);

    sgp_viewport(EMPTY_L, EMPTY_T, win_w-EMPTY_L-EMPTY_R, win_h-EMPTY_T-EMPTY_B);
    sgp_project(-RECT_DELT_L, fwidth+RECT_DELT_R, -RECT_DELT_T, fheight+RECT_DELT_B);
    sgp_set_blend_mode((sgp_blend_mode)lyte_state.blendmode);


    lyte_push_matrix();
    lyte_state.tick_fn(lyte_state.app_data, delta_time, win_w, win_h, resized, lyte_state.fullscreen);
    lyte_pop_matrix();

    // NOTE: at this point only sgp state has been changed, and sg has not
    // so for optimization, we can decide if any drawing was done or not here
    // and possibly skip all this, including swapping of buffers.
    // this way, it can be kind of like a non-immediate mode gui for app that like it

    // PERF_BEGIN();
    sg_pass_action pass_action = {0};
    sg_begin_default_pass(&pass_action, win_w, win_h);
    sgp_flush();
    sgp_end();
    sg_end_pass();
    sg_commit();

    glfwSwapBuffers(lyte_state.window);

    lyte_core_audio_update_music_streams(); // new "dowork"
    lyte_core_input_update_state();
    lyte_core_filesystem_update_tasks(); // sfetch_dowork covered here

    lyte_state.do_quit = lyte_state.do_quit || glfwWindowShouldClose(lyte_state.window);

    glfwPollEvents();
}

int lyte_core_set_loop(lyte_TickFunction tick_fn, void *app_data) {
    lyte_state.tick_fn = tick_fn;
    lyte_state.app_data = app_data;
    return 0;
}

int lyte_core_start_loop(lyte_TickFunction tick_fn, void *app_data) {
    lyte_core_set_loop(tick_fn, app_data);

    // LOOP BEGINS HERE---------------------------------------------
#ifdef EMSCRIPTEN
    emscripten_set_main_loop(_tick_function, 0, 1);
#else
    while(!(lyte_state.do_quit)) { _tick_function(); }
#endif
    // LOOP ENDS HERE------------------------------------------------

    return 0;
}