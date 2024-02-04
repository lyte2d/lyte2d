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
    if(lytecore_state.do_quit) {
        emscripten_cancel_main_loop();
    }
#endif

    /* Timing */
    curr_t = glfwGetTime();
    delta_time = curr_t - last_t;
    last_t = curr_t;

    int prev_w, prev_h;
    prev_w = lytecore_state.window_size.width;
    prev_h = lytecore_state.window_size.height;

    int win_w, win_h;

    float PL = lytecore_state.window_paddings.left;
    float PR = lytecore_state.window_paddings.right;
    float PT = lytecore_state.window_paddings.top;
    float PB = lytecore_state.window_paddings.bottom;

    float ML = lytecore_state.window_margins.left;
    float MR = lytecore_state.window_margins.right;
    float MT = lytecore_state.window_margins.top;
    float MB = lytecore_state.window_margins.bottom;

#if defined(__EMSCRIPTEN__)
    win_w = emsc_width();
    win_h = emsc_height();
#else
        glfwGetFramebufferSize(lytecore_state.window, &win_w, &win_h);
#endif

    int fwidth = win_w - PL - PR;
    int fheight = win_h - PT - PB; // BUGG?
    lytecore_state.window_size.width = win_w;
    lytecore_state.window_size.height = win_h;
    bool resized = false;
    if (lytecore_state.first_frame || prev_w != lytecore_state.window_size.width || prev_h != lytecore_state.window_size.height) {
        resized = true;
        lytecore_state.first_frame = false;
    }

    sgp_begin(win_w, win_h);

    sgp_viewport(ML, MT, win_w-ML-MR, win_h-MT-MB);
    sgp_project(-PL, fwidth+PR, -PT, fheight+PB);
    lyte_set_blendmode(lytecore_state.blendmode);


    lyte_push_matrix();
    lytecore_state.tick_fn(lytecore_state.app_data, delta_time, win_w, win_h, resized, lytecore_state.fullscreen);
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

    glfwSwapBuffers(lytecore_state.window);

    lyte_core_audio_update_music_streams(); // new "dowork"
    lyte_core_input_update_state();
    lyte_core_filesystem_update_tasks(); // sfetch_dowork covered here

    lytecore_state.do_quit = lytecore_state.do_quit || glfwWindowShouldClose(lytecore_state.window);

    glfwPollEvents();
}

int lyte_core_set_loop(lyte_TickFunction tick_fn, void *app_data) {
    lytecore_state.tick_fn = tick_fn;
    lytecore_state.app_data = app_data;
    lytecore_state.first_frame = true; // this will cause "resized" flag to be set so that initial "tick" can set app data correctly
    return 0;
}

int lyte_core_start_loop(lyte_TickFunction tick_fn, void *app_data) {
    lyte_core_set_loop(tick_fn, app_data);

    // LOOP BEGINS HERE---------------------------------------------
#ifdef EMSCRIPTEN
    emscripten_set_main_loop(_tick_function, 0, 1);
#else
    while(!(lytecore_state.do_quit)) { _tick_function(); }
#endif
    // LOOP ENDS HERE------------------------------------------------

    return 0;
}
