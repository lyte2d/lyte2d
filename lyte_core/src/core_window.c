#include <stdio.h>
#include <assert.h>
#include <stdlib.h>
#include <string.h>

#include "_internal.h"

#include "sokol_gfx.h"
#include "sokol_gp.h"
#include "sokol_app.h"

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
            fprintf(stderr, "Sokol: %s\n", message);
            return;
        } break;
    }
}

int lyte_core_window_init(void) {
    // make the window current for opengl

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

int lyte_set_fullscreen(bool fullscreen) {
    fprintf(stderr, "set_fullscreen not implemented yet\n");
    return 0;
}

int lyte_is_fullscreen(bool *val) {
    *val = lytecore_state.fullscreen;
    return 0;
}

int lyte_set_window_title(const char * title) {
    sapp_set_window_title(title);
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
    printf("read %d byts\n", (int)read_len);
    sapp_range pixels = {
        .ptr = data,
        .size = width * height * 4
    };
    const sapp_icon_desc icon_desc = {
        .images = {
            { .width = width, .height = height, .pixels = pixels }
        }
    };
    printf("icon %d %d\n", width, height);
    sapp_set_icon(&icon_desc);

    stbi_image_free(data);
    free(buf);
    PHYSFS_close(file);
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
