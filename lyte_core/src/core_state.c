//

#include "lyte_core.h"

#include "sokol_gfx.h"
#include "sokol_gp.h"

lyte_State lyte_state = {0};

int lyte_core_state_init(lyte_Config config) {
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

    return 0;
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

