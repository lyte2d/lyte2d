//

#include <stdio.h>

#include "lyte_core.h"

#include "sokol_gfx.h"
#include "sokol_gp.h"
#include "sokol_args.h"


lyte_State lyte_state = {0};

#define MAX_FIRST_ARG_LENGTH 4096


int lyte_core_state_init(lyte_Config config) {
    lyte_state.args = config.args;
    lyte_state.vsync = config.vsync;
    lyte_state.default_blendmode = config.blendmode;
    lyte_state.default_filtermode = config.filtermode;

    lyte_state.fullscreen = false;

    lyte_state.blendmode = config.blendmode;
    lyte_state.filtermode = config.filtermode;

    lyte_state.window_title = config.window_title;
    lyte_state.window_size = config.window_size;
    lyte_state.window_min_size = config.window_min_size;

    lyte_state.window = NULL;
    lyte_state.monitor = NULL;
    lyte_state.mode = NULL;

    lyte_state.shader = NULL;

    lyte_state.do_quit = false;

    lyte_state.current_color[0] = 1.0;
    lyte_state.current_color[1] = 1.0;
    lyte_state.current_color[2] = 1.0;
    lyte_state.current_color[3] = 1.0;


#ifndef __EMSCRIPTEN__
    bool first_arg_update = false;
    char first_arg_new[MAX_FIRST_ARG_LENGTH] = {0};

    if (lyte_state.args.argc>1) {
        first_arg_update = true;
        for (int i=0; i<strlen(lyte_state.args.argv[1]); i++) {
            if (lyte_state.args.argv[1][i] == '=') {
                first_arg_update = false;
                break;
            }
        }

        if (first_arg_update) {
            if (strlen(lyte_state.args.argv[1]) > MAX_FIRST_ARG_LENGTH-10) {
                fprintf(stderr, "First argument too long.\n");
                return -1;
            } else {

                sprintf(first_arg_new, "dir=%s", lyte_state.args.argv[1]);
                lyte_state.args.argv[1] = first_arg_new;
            }
        }
    } else {
        sprintf(first_arg_new, "dir=.");
        lyte_state.args.argc += 1;
        lyte_state.args.argv[1] = first_arg_new;
    }
#endif
    sargs_setup(&(sargs_desc){
        .argc = lyte_state.args.argc,
        .argv = lyte_state.args.argv
    });


    return 0;
}

bool lyte_core_state_has_arg(const char *name) {
    return sargs_exists(name);
}

const char *lyte_core_state_get_arg(const char *name) {
    return sargs_value(name);
}

bool lyte_core_state_get_arg_bool(const char *name) {
    return sargs_boolean(name);
}

int lyte_quit(void) {
    lyte_state.do_quit = true;
    return 0;
}

int lyte_set_color(double r, double g, double b, double a) {
    lyte_state.current_color[0] = r;
    lyte_state.current_color[1] = g;
    lyte_state.current_color[2] = b;
    lyte_state.current_color[3] = a;

    if (!lyte_state.shader) {
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
    lyte_state.default_blendmode = blendmode;
    return 0;
}

int lyte_set_blendmode(lyte_BlendMode blendmode) {
    lyte_state.blendmode = lyte_state.default_blendmode;
    sgp_set_blend_mode((sgp_blend_mode)blendmode);
    return 0;
}

int lyte_reset_blendmode(void) {
    lyte_state.blendmode = lyte_state.default_blendmode;
    sgp_set_blend_mode((sgp_blend_mode)lyte_state.blendmode);
    return 0;
}

int lyte_set_default_filtermode(lyte_FilterMode filtermode) {
    lyte_state.default_filtermode = filtermode;
    return 0;
}

int lyte_set_filtermode(lyte_FilterMode filtermode) {
    lyte_state.filtermode = filtermode;
    return 0;
}

int lyte_reset_filtermode(void) {
    lyte_state.filtermode = lyte_state.default_filtermode;
    return 0;
}

int lyte_cls(double r, double g, double b, double a) {
    lyte_set_color(r,g,b,a);
    sgp_clear();
    lyte_reset_color(); // TODO: should we keep a "current_color" and update?
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

int lyte_translate(int delta_x, int delta_y) {
    sgp_translate(delta_x, delta_y);
    return 0;
}

int lyte_rotate(double angle) {
    sgp_rotate(angle);
    return 0;
}

int lyte_rotate_at(double angle, int x, int y) {
    sgp_rotate_at(angle, x, y);
    return 0;
}

int lyte_scale(double scale_x, double scale_y) {
    sgp_scale(scale_x, scale_y);
    return 0;
}

int lyte_scale_at(int scale_x, int scale_y, double x, double y) {
    sgp_scale_at(scale_x, scale_y, x, y);
    return 0;
}

