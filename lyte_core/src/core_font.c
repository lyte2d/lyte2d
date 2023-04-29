//

#include <stdio.h>
#include <assert.h>
#include <stdlib.h>
#include <string.h>

#include "core.h"
#include "map.h"

#include "physfs.h"

#ifndef INIT_NUM_FONTS
#define INIT_NUM_FONTS 10
#endif

typedef struct Font {
    uint32_t handle;
    int width;
    int height;
    bool is_canvas; // if true, values below should also be set
    uint32_t id_depth_image;
    uint32_t id_pass;
} Font;

static mg_Map fonts;

void lyte_core_font_init(void) {
    mg_map_init(&fonts, sizeof(Font), INIT_NUM_FONTS);
}

void lyte_core_font_cleanup(void) {
    mg_map_cleanup(&fonts);
}
