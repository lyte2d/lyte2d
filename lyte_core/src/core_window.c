//

#include <stdio.h>
#include <assert.h>
#include <stdlib.h>
#include <string.h>

#include "_internal.h"

#include "sokol_gfx.h"
#include "sokol_gp.h"

#include "physfs.h" // icon
#include "stb_image.h" // icon

static bool _window_inited = false;
static bool _window_resizable = true;

void _sg_log(const char* tag, uint32_t log_level, uint32_t log_item_id, const char* message, uint32_t line_nr, const char* filename, void* user_data) {
    if (!message) {
        return;
    }

    switch (log_item_id) {
        case SG_LOGITEM_GL_SHADER_LINKING_FAILED: {
            fprintf(stderr, "Failed to link shader:\n%s", message);
        } break;
        case SG_LOGITEM_GL_SHADER_COMPILATION_FAILED: {
            fprintf(stderr, "Failed to compile shader:\n%s", message);
        } break;
        default: {
            return;
        } break;
    }
}

int lyte_core_window_init(void) {

#if defined(__EMSCRIPTEN__)
    emsc_init("#canvas", EMSC_TRY_WEBGL2);
#endif

    // MSAA... to change this, window needs to be reopened...
    // glfwWindowHint(GLFW_SAMPLES, 4);

    // make the window current for opengl

    if (lytecore_state.vsync) {
        //glfwSwapInterval(1);
    } else {
        //glfwSwapInterval(0);
    }

    sg_desc sgdesc = {.logger.func = _sg_log};
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

    // NOTE: Input code and window are tighyly integrated. We need to initialize this here
    lyte_core_input_init();

    _window_inited = true;
    return 0;
}

int lyte_core_window_cleanup(void) {
    // NOTE: Input code and window are tighyly integrated. We need to initialize this here
    lyte_core_input_cleanup();

    sgp_shutdown();
    sg_shutdown();
    return 0;
}

int lyte_get_monitor_count(int *val) {
    // TODO
    (void)val;
    return 0;
}

int lyte_get_monitor_name(int index, const char * *val) {
    // TODO
    (void)index; (void)val;
    return 0;
}

int lyte_get_monitor_width(int index, int *val) {
    // TODO
    (void)index; (void)val;
    return 0;
}

int lyte_get_monitor_height(int index, int *val) {
    // TODO
    return 0;
}

int lyte_set_window_monitor(int index) {
    // TODO
    (void)index;
    return 0;
}

int lyte_set_window_resizable(bool resizable) {
    fprintf(stderr, "set_window_resizable not supported\n");
    return 0;
}

int lyte_set_window_minsize(int width, int height) {
    fprintf(stderr, "set_window_minsize not supported\n");
    return 0;
}

int lyte_set_window_size(int width, int height) {
    fprintf(stderr, "set_window_size not supported\n");
    return 0;
}

int lyte_get_window_width(int *val) {
    *val = lytecore_state.window_size.width;
    return 0;
}

int lyte_get_window_height(int *val) {
    *val = lytecore_state.window_size.height;
    return 0;
}

int lyte_set_window_position(int x, int y) {
    fprintf(stderr, "set_window_position not supported\n");
    return 0;
}

#if 0
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
#endif

int lyte_set_fullscreen(bool fullscreen) {
    fprintf(stderr, "set_fullscreen not implemented yet\n");
    return 0;
}

int lyte_is_fullscreen(bool *val) {
    *val = lytecore_state.fullscreen;
    return 0;
}

int lyte_set_window_title(const char * title) {
    fprintf(stderr, "set_window_title not implemented yet\n");
    lytecore_state.window_title = title;
    return 0;
}

int lyte_set_window_icon_file(const char * path) {
    PHYSFS_File *file = PHYSFS_openRead(path);
    if (file == NULL) {
        int errcode = PHYSFS_getLastErrorCode();
        const char *errstr = PHYSFS_getErrorByCode(errcode);
        fprintf(stderr, "\nFile '%s': '%s'\n", path, errstr);
        return errcode;
    }
    size_t len = PHYSFS_fileLength(file);
    uint8_t *buf = malloc(len);
    size_t read_len = PHYSFS_readBytes(file, buf, len);
    if (len != read_len) {
        fprintf(stderr, "\nFile not fully read. Path: %s. File size is %zu bytes, but read %zu bytes.\n", path, len, read_len);
        return 1;
    }
    int width;
    int height;
    int channels;
    uint8_t *data = stbi_load_from_memory(buf, read_len, &width, &height, &channels, 4);
    if (!data) {
        fprintf(stderr, "\nImage file failed to load: %s\n", path);
        return 2;
    }

    //GLFWimage images[1];
    //images[0].pixels = stbi_load_from_memory(buf, read_len, &images[0].width, &images[0].height, 0, 4);
    fprintf(stderr, "set_window_icon_file not implemented yet\n");

    //glfwSetWindowIcon(lytecore_state.window, 1, images);

    stbi_image_free(data);
    free(buf);
    PHYSFS_close(file);
    return 0;
}

int lyte_set_window_vsync(bool vsync) {
    lytecore_state.vsync = vsync;
    fprintf(stderr, "set_window_vsybnc not implemented yet\n");
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
