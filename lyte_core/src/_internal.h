#ifndef LYTE_INTERNAL_H
#define LYTE_INTERNAL_H

#include "lyte_core.h"

#include "sokol_gfx.h"

#define SGP_UNIFORM_CONTENT_SLOTS 1024
#define SGP_TEXTURE_SLOTS 8


#ifndef MIN
#define MIN(a,b) (((a)<(b))?(a):(b))
#endif

#ifndef MAX
#define MAX(a,b) (((a)>(b))?(a):(b))
#endif

#ifndef M_PI
#define M_PI  3.14159265358979323846264f
#endif

typedef struct lyte_QuadSize {
    int left, right, top, bottom;
} lyte_QuadSize;

typedef struct lyte_CoreState {
    lyte_Args args;

    lyte_BlendMode default_blendmode;
    lyte_FilterMode default_filtermode;

    const char *exe_name;
    lyte_Size window_size;
    lyte_Size window_min_size;
    bool fullscreen;
    lyte_BlendMode blendmode;
    lyte_FilterMode filtermode;
    lyte_QuadSize window_margins;
    lyte_QuadSize window_paddings;

    float hidpi_xscale;
    float hidpi_yscale;

    float current_color[4];

    void *shader; // ShaderItem (internal)

    bool do_quit; // set to true to quit the app
    bool first_frame; // first frame of the tick function

    lyte_TickFunction tick_fn;
    void *app_data;

} lyte_CoreState;


// core_shader.c needs this struct; otherwise it could be confined to lyte_image.c
typedef struct ImageItem {
    uint32_t handle;
    uint32_t sampler_handle;
    sg_view view;
    int ref;
    int width;
    int height;
    bool is_canvas; // if true, values below should also be set
    uint32_t id_depth_image;
    sg_attachments attachments;
} ImageItem;

extern lyte_CoreState lytecore_state;

#endif // LYTE_INTERNAL_H
