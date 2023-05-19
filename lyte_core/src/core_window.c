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



int lyte_core_window_init(void) {
#if defined(__EMSCRIPTEN__)
    emsc_init("#canvas", EMSC_TRY_WEBGL2);
#endif
    // init: glfw & opengl/gles
    if (!glfwInit()) {
        fprintf(stderr, "Failed to initialize glfw\n");
        return -1;
    }

    // MSAA... to change this, window needs to be reopened...
    // glfwWindowHint(GLFW_SAMPLES, 4);

    glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3);
    glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 3);
    glfwWindowHint(GLFW_OPENGL_FORWARD_COMPAT, GLFW_TRUE);
    glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);
    glfwWindowHint(GLFW_DOUBLEBUFFER, 1);

#if defined(__EMSCRIPTEN__)
    lyte_state.window = glfwCreateWindow(emsc_width(), emsc_height(), lyte_state.window_title, NULL, NULL);
    emscripten_set_window_title(lyte_state.window_title);
#else
    lyte_state.window = glfwCreateWindow(lyte_state.window_size.width, lyte_state.window_size.height, lyte_state.window_title, NULL, NULL);
#endif

    if (lyte_state.window == NULL) {
        fprintf(stderr, "Failed to create glfw window\n");
        return -2;
    }

    // make the window current for opengl
    glfwMakeContextCurrent(lyte_state.window);

    lyte_state.monitor = glfwGetWindowMonitor(lyte_state.window);
    if (!lyte_state.monitor) {
        // this is expected
        GLFWmonitor* primary = glfwGetPrimaryMonitor();
        lyte_state.monitor = primary;

        const GLFWvidmode *mode = glfwGetVideoMode(primary);
        lyte_state.mode = (void *)mode;
    }

    if (lyte_state.vsync) {
        glfwSwapInterval(1);
    } else {
        glfwSwapInterval(0);
    }

    sg_desc sgdesc = {0};
    sg_setup(&sgdesc);
    if(!sg_isvalid()) {
        fprintf(stderr, "Failed to create Sokol GFX context\n");
        return -3;
    }

    sgp_desc sgpdesc = {0};
    sgpdesc.max_vertices = 250000;
    sgp_setup(&sgpdesc);
    if(!sgp_is_valid()) {
        fprintf(stderr, "Failed to create Sokol GP context: %s\n", sgp_get_error_message(sgp_get_last_error()));
        return -4;
    }


    return 0;
}

int lyte_core_window_cleanup(void) {
    sgp_shutdown();
    sg_shutdown();
    glfwTerminate();
    return 0;
}

int lyte_set_window_minsize(int width, int height) {
    glfwSetWindowSizeLimits(lyte_state.window, width, height, GLFW_DONT_CARE, GLFW_DONT_CARE);
    lyte_state.window_min_size.width = width;
    lyte_state.window_min_size.height = height;
    // _lib->mode = (GLFWvidmode *)glfwGetVideoMode(_lib->monitor);
    // glfwSetWindowPos(
    //     _lib->window,
    //     _lib->mode->width/2 - w/2,
    //     _lib->mode->height/2 - h/2);
    return 0;
}

int lyte_set_window_size(int width, int height) {
    glfwSetWindowSize(lyte_state.window, width, height);
    lyte_state.window_size.width = width;
    lyte_state.window_size.height = height;
    // _lib->mode = (GLFWvidmode *)glfwGetVideoMode(_lib->monitor);
    // glfwSetWindowPos(
    //     _lib->window,
    //     _lib->mode->width/2 - w/2,
    //     _lib->mode->height/2 - h/2);
    return 0;
}

int lyte_get_window_width(int *val) {
    int w;
    int h;
#if defined(__EMSCRIPTEN__)
        w = emsc_width();
        h = emsc_height();
#else
    glfwGetWindowSize(lyte_state.window, &w, &h);
#endif
    *val = w;
    lyte_state.window_size.width = w;
    lyte_state.window_size.height = h;
    return 0;
}

int lyte_get_window_height(int *val) {
    int w;
    int h;
#if defined(__EMSCRIPTEN__)
        w = emsc_width();
        h = emsc_height();
#else
    glfwGetWindowSize(lyte_state.window, &w, &h);
#endif
    *val = h;
    lyte_state.window_size.width = w;
    lyte_state.window_size.height = h;
    return 0;
}

int lyte_set_fullscreen(bool fullscreen) {
    static int win_x = 0;
    static int win_y = 0;
    if (fullscreen != lyte_state.fullscreen) {
        if (fullscreen) {
            GLFWvidmode * mode = lyte_state.mode;
            glfwGetWindowPos(lyte_state.window, &win_x, &win_y);
            glfwSetWindowMonitor(lyte_state.window, lyte_state.monitor, 0, 0, mode->width, mode->height, mode->refreshRate);
        } else {
            glfwSetWindowMonitor(lyte_state.window, NULL, win_x, win_y, lyte_state.window_size.width, lyte_state.window_size.height, GLFW_DONT_CARE);
            GLFWmonitor *monitor = glfwGetWindowMonitor(lyte_state.window);
            if (monitor) {
                lyte_state.monitor = monitor;
                lyte_state.mode = (void *)glfwGetVideoMode(lyte_state.monitor);
            }
        }
        lyte_state.fullscreen = fullscreen;
    }
    return 0;
}

int lyte_is_fullscreen(bool *val) {
    *val = lyte_state.fullscreen;
    return 0;
}

int lyte_set_window_title(const char * title) {
#if defined(__EMSCRIPTEN__)
    emscripten_set_window_title(title);
#else
    glfwSetWindowTitle(lyte_state.window, title);
#endif
    lyte_state.window_title = title;
    return 0;
}

