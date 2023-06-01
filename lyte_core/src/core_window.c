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

#include "physfs.h" // icon
#include "stb_image.h" // icon



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
    lytecore_state.window = glfwCreateWindow(emsc_width(), emsc_height(), lytecore_state.window_title, NULL, NULL);
    emscripten_set_window_title(lytecore_state.window_title);
#else
    lytecore_state.window = glfwCreateWindow(lytecore_state.window_size.width, lytecore_state.window_size.height, lytecore_state.window_title, NULL, NULL);
#endif

    if (lytecore_state.window == NULL) {
        fprintf(stderr, "Failed to create glfw window\n");
        return -2;
    }

    // make the window current for opengl
    glfwMakeContextCurrent(lytecore_state.window);

    lytecore_state.monitor = glfwGetWindowMonitor(lytecore_state.window);
    if (!lytecore_state.monitor) {
        // this is expected
        GLFWmonitor* primary = glfwGetPrimaryMonitor();
        lytecore_state.monitor = primary;

        const GLFWvidmode *mode = glfwGetVideoMode(primary);
        lytecore_state.mode = (void *)mode;
    }

    if (lytecore_state.vsync) {
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
    glfwSetWindowSizeLimits(lytecore_state.window, width, height, GLFW_DONT_CARE, GLFW_DONT_CARE);
    lytecore_state.window_min_size.width = width;
    lytecore_state.window_min_size.height = height;
    // _lib->mode = (GLFWvidmode *)glfwGetVideoMode(_lib->monitor);
    // glfwSetWindowPos(
    //     _lib->window,
    //     _lib->mode->width/2 - w/2,
    //     _lib->mode->height/2 - h/2);
    return 0;
}

int lyte_set_window_size(int width, int height) {
    glfwSetWindowSize(lytecore_state.window, width, height);
    lytecore_state.window_size.width = width;
    lytecore_state.window_size.height = height;
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
    glfwGetWindowSize(lytecore_state.window, &w, &h);
#endif
    *val = w;
    lytecore_state.window_size.width = w;
    lytecore_state.window_size.height = h;
    return 0;
}

int lyte_get_window_height(int *val) {
    int w;
    int h;
#if defined(__EMSCRIPTEN__)
        w = emsc_width();
        h = emsc_height();
#else
    glfwGetWindowSize(lytecore_state.window, &w, &h);
#endif
    *val = h;
    lytecore_state.window_size.width = w;
    lytecore_state.window_size.height = h;
    return 0;
}

static int get_current_monitor( GLFWmonitor** monitor, GLFWwindow* window) {
    int winpos[2] = {0};
    glfwGetWindowPos(window, &winpos[0], &winpos[1]);

    int monitors_size = 0;
    GLFWmonitor** monitors = glfwGetMonitors(&monitors_size);

    for (int i = 0; i < monitors_size; ++i) {
        int monitorpos[2] = {0};
        glfwGetMonitorPos(monitors[i], &monitorpos[0], &monitorpos[1]);
        const GLFWvidmode* vidmode = glfwGetVideoMode(monitors[i]);
        if (   winpos[0] >= monitorpos[0]
            && winpos[0] < (monitorpos[0] + vidmode->width)
            && winpos[1] >= monitorpos[1]
            && winpos[1] < (monitorpos[1] + vidmode->height)) {
            *monitor = monitors[i];
            return 0;
        }
    }

    return 1;
}

int lyte_set_fullscreen(bool fullscreen) {
#if defined(__EMSCRIPTEN__)
    if (fullscreen != lytecore_state.fullscreen) {
        if (fullscreen) {
            emscripten_request_fullscreen("#canvas", false);
            lytecore_state.fullscreen = fullscreen = true;
        } else {
            emscripten_exit_fullscreen();
            lytecore_state.fullscreen = fullscreen = false;
        }
    }
#else
    static int win_x = 0;
    static int win_y = 0;
    static int win_save_w = 0;
    static int win_save_h = 0;
    if (fullscreen != lytecore_state.fullscreen) {
            GLFWmonitor *monitor = NULL;
            int err = get_current_monitor(&monitor, lytecore_state.window);
            if (!err) {
                lytecore_state.monitor = monitor;
                lytecore_state.mode = (void *)glfwGetVideoMode(lytecore_state.monitor);
            }
        if (fullscreen) {
            GLFWvidmode * mode = lytecore_state.mode;
            glfwGetWindowPos(lytecore_state.window, &win_x, &win_y);
            win_save_w = lytecore_state.window_size.width;
            win_save_h = lytecore_state.window_size.height;
            glfwGetWindowSize(lytecore_state.window,&lytecore_state.window_size.width, &lytecore_state.window_size.height);
            glfwSetWindowMonitor(lytecore_state.window, lytecore_state.monitor, 0, 0, mode->width, mode->height, mode->refreshRate);
        } else {
            glfwSetWindowMonitor(lytecore_state.window, NULL, win_x, win_y, win_save_w, win_save_h, GLFW_DONT_CARE);
        }
        lytecore_state.fullscreen = fullscreen;
    }
#endif
    return 0;
}

int lyte_is_fullscreen(bool *val) {
    *val = lytecore_state.fullscreen;
    return 0;
}

int lyte_set_window_title(const char * title) {
#if defined(__EMSCRIPTEN__)
    emscripten_set_window_title(title);
#else
    glfwSetWindowTitle(lytecore_state.window, title);
#endif
    lytecore_state.window_title = title;
    return 0;
}

int lyte_set_window_icon_file(const char * path) {
    PHYSFS_File *file = PHYSFS_openRead(path);
    if (file == NULL) {
        int errcode = PHYSFS_getLastErrorCode();
        const char *errstr = PHYSFS_getErrorByCode(errcode);
        fprintf(stderr, "File '%s' error %s\n", path, errstr);
        return errcode;
    }
    size_t len = PHYSFS_fileLength(file);
    uint8_t *buf = malloc(len);
    size_t read_len = PHYSFS_readBytes(file, buf, len);
    if (len != read_len) {
        fprintf(stderr, "File not fully read. Path: %s. File size is %zu bytes, but read %zu bytes.\n", path, len, read_len);
        return 1;
    }
    int width;
    int height;
    int channels;
    uint8_t *data = stbi_load_from_memory(buf, read_len, &width, &height, &channels, 4);
    if (!data) {
        fprintf(stderr, "Image file failed to load: %s\n", path);
        return 2;
    }

    GLFWimage images[1];
    images[0].pixels = stbi_load_from_memory(buf, read_len, &images[0].width, &images[0].height, 0, 4);
    glfwSetWindowIcon(lytecore_state.window, 1, images);

    stbi_image_free(data);
    free(buf);
    PHYSFS_close(file);
    return 0;
}

int lyte_set_window_vsync(bool vsync) {
    lytecore_state.vsync = vsync;
    if (lytecore_state.vsync) {
        glfwSwapInterval(1);
    } else {
        glfwSwapInterval(0);
    }
    return 0;
}

int lyte_is_window_vsync(bool *val) {
    *val = lytecore_state.vsync;
    return 0;
}

int lyte_set_window_margins(int left, int right, int top, int bottom) {
    lytecore_state.window_margins.left = left;
    lytecore_state.window_margins.right = right;
    lytecore_state.window_margins.top = top;
    lytecore_state.window_margins.bottom = bottom;
    return 0;
}

int lyte_set_window_paddings(int left, int right, int top, int bottom) {
    lytecore_state.window_paddings.left = left;
    lytecore_state.window_paddings.right = right;
    lytecore_state.window_paddings.top = top;
    lytecore_state.window_paddings.bottom = bottom;
    return 0;
}