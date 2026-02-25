//

#include <stdio.h>
#include <string.h>

#include "_internal.h"

#include "sokol_gfx.h"
#include "sokol_gp.h"
#include "sokol_args.h"
#include "sokol_time.h"

lyte_CoreState lytecore_state = {0};

#define MAX_FIRST_ARG_LENGTH 4096


int lyte_core_state_init(lyte_Config config) {
    stm_setup();
    lytecore_state.args = config.args;
    lytecore_state.vsync = config.vsync;
    lytecore_state.default_blendmode = config.blendmode;
    lytecore_state.default_filtermode = config.filtermode;

    lytecore_state.fullscreen = false;

    lytecore_state.blendmode = config.blendmode;
    lytecore_state.filtermode = config.filtermode;

    lytecore_state.exe_name = config.exe_name;
    lytecore_state.window_title = "?"; //config.window_title;
    lytecore_state.window_size = config.window_size;
    lytecore_state.window_min_size = config.window_min_size;

    lytecore_state.shader = NULL;

    lytecore_state.do_quit = false;
    lytecore_state.first_frame = false;

    lytecore_state.current_color[0] = 1.0;
    lytecore_state.current_color[1] = 1.0;
    lytecore_state.current_color[2] = 1.0;
    lytecore_state.current_color[3] = 1.0;

    lytecore_state.hidpi_xscale = 1.0;
    lytecore_state.hidpi_yscale = 1.0;


#ifndef __EMSCRIPTEN__
    bool first_arg_update = false;
    char first_arg_new[MAX_FIRST_ARG_LENGTH] = {0};

    if (lytecore_state.args.argc>1) {
        first_arg_update = true;
        for (int i=0; i<strlen(lytecore_state.args.argv[1]); i++) {
            if (lytecore_state.args.argv[1][i] == '=') {
                first_arg_update = false;
                break;
            }
        }

        if (first_arg_update) {
            if (strlen(lytecore_state.args.argv[1]) > MAX_FIRST_ARG_LENGTH-10) {
                fprintf(stderr, "First argument too long.\n");
                return -1;
            } else {

                sprintf(first_arg_new, "dir=%s", lytecore_state.args.argv[1]);
                for(int i=0; i<strlen(first_arg_new);i++) {
                    if (first_arg_new[i] == '\\') {
                        first_arg_new[i] = '/';
                    }
                }
                lytecore_state.args.argv[1] = first_arg_new;
            }
        }
    } else {
        sprintf(first_arg_new, "dir=.");
        lytecore_state.args.argc += 1;
        lytecore_state.args.argv[1] = first_arg_new;
    }
#endif
    sargs_setup(&(sargs_desc){
        .argc = lytecore_state.args.argc,
        .argv = lytecore_state.args.argv
    });


    return 0;
}

bool lyte_core_state_has_arg(const char *name) {
    return sargs_exists(name);
}

const char *lyte_core_state_get_arg(const char *name) {
    return sargs_value(name);
}

const char *lyte_core_state_get_arg_default(const char *name, const char *default_value) {
    if (sargs_exists(name)) {
        return sargs_value(name);
    }
    return default_value;
}

bool lyte_core_state_get_arg_bool(const char *name) {
    return sargs_boolean(name);
}

int lyte_quit(void) {
    lytecore_state.do_quit = true;
    return 0;
}

int lyte_set_color(double r, double g, double b, double a) {
    lytecore_state.current_color[0] = r;
    lytecore_state.current_color[1] = g;
    lytecore_state.current_color[2] = b;
    lytecore_state.current_color[3] = a;

    if (!lytecore_state.shader) {
        sgp_set_color(r, g, b, a);
    } else {
        return lyte_core_shader_set_color();
    }
    return 0;
}

int lyte_reset_color(void) {
    return lyte_set_color(1.0, 1.0, 1.0, 1.0);
}

int lyte_set_default_blendmode(lyte_BlendMode blendmode) {
    lytecore_state.default_blendmode = blendmode;
    return 0;
}

int lyte_set_blendmode(lyte_BlendMode blendmode) {
    sgp_set_blend_mode((sgp_blend_mode)blendmode);
    lytecore_state.blendmode = blendmode;
    return 0;
}

int lyte_reset_blendmode(void) {
    sgp_set_blend_mode((sgp_blend_mode)lytecore_state.blendmode);
    lytecore_state.blendmode = lytecore_state.default_blendmode;
    return 0;
}

int lyte_set_default_filtermode(lyte_FilterMode filtermode) {
    lytecore_state.default_filtermode = filtermode;
    return 0;
}

int lyte_set_filtermode(lyte_FilterMode filtermode) {
    lytecore_state.filtermode = filtermode;
    return 0;
}

int lyte_reset_filtermode(void) {
    lytecore_state.filtermode = lytecore_state.default_filtermode;
    return 0;
}

int lyte_cls(double r, double g, double b, double a) {
    float c[4];
    c[0] = lytecore_state.current_color[0];
    c[1] = lytecore_state.current_color[1];
    c[2] = lytecore_state.current_color[2];
    c[3] = lytecore_state.current_color[3];
    lyte_set_color(r,g,b,a);
    sgp_clear();
    lyte_set_color(c[0], c[1], c[2], c[3]);
    return 0;
}

int lyte_push_matrix(void) {
    sgp_push_transform();
    return 0;
}

int lyte_pop_matrix(void) {
    sgp_pop_transform();
    return 0;
}

int lyte_reset_matrix(void) {
    sgp_reset_transform();
    return 0;
}

int lyte_translate(double delta_x, double delta_y) {
    sgp_translate(delta_x, delta_y);
    return 0;
}

int lyte_rotate(double angle) {
    sgp_rotate(angle);
    return 0;
}

int lyte_rotate_at(double angle, double x, double y) {
    sgp_rotate_at(angle, x, y);
    return 0;
}

int lyte_scale(double scale_x, double scale_y) {
    sgp_scale(scale_x, scale_y);
    return 0;
}

int lyte_scale_at(double scale_x, double scale_y, double x, double y) {
    sgp_scale_at(scale_x, scale_y, x, y);
    return 0;
}

