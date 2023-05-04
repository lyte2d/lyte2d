//

#include <stdio.h>
#include <assert.h>
#include <stdlib.h>
#include <string.h>

#include "lyte_core.h"
#include "map.h"

#include "physfs.h"

#include "sokol_gfx.h"
#include "sokol_gp.h"
#include "stb_image.h"

#ifndef INIT_NUM_IMAGEITEMS
#define INIT_NUM_IMAGEITEMS 10
#endif

typedef struct ImageItem {
    uint32_t handle;
    int width;
    int height;
    bool is_canvas; // if true, values below should also be set
    uint32_t id_depth_image;
    uint32_t id_pass;
} ImageItem;

static mg_Map imageitems;
static ImageItem *current_canvas = NULL;

void lyte_core_image_init(void) {
    mg_map_init(&imageitems, sizeof(ImageItem), INIT_NUM_IMAGEITEMS);
}

void lyte_core_image_cleanup(void) {
    mg_map_cleanup(&imageitems);
}

int lyte_load_image(const char *path, lyte_Image *img) {
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
    sg_image_desc image_desc = {0};
    image_desc.width = width;
    image_desc.height = height;
    image_desc.min_filter = (sg_filter)lyte_state.filtermode;
    image_desc.mag_filter = (sg_filter)lyte_state.filtermode;
    // image_desc.wrap_u = SG_WRAP_REPEAT;
    // image_desc.wrap_v = SG_WRAP_REPEAT;
    image_desc.wrap_u = SG_WRAP_CLAMP_TO_EDGE;
    image_desc.wrap_v = SG_WRAP_CLAMP_TO_EDGE;
    image_desc.data.subimage[0][0].ptr = data;
    image_desc.data.subimage[0][0].size = (size_t)(width * height * 4);
    sg_image sgimage = sg_make_image(&image_desc);
    stbi_image_free(data);
    ImageItem imageitem = {0};
    imageitem.handle = sgimage.id;
    imageitem.width = width;
    imageitem.height = height;
    imageitem.is_canvas = false;
    mg_map_set(&imageitems, imageitem.handle, &imageitem);
    img->handle = imageitem.handle;
    free(buf);
    PHYSFS_close(file);
    return 0;
}

int lyte_new_canvas(int w, int h, lyte_Image *img) {
    ImageItem canvas = {.width = w, .height = h, .is_canvas = true};
    // create frame buffer image
    sg_image_desc fb_image_desc = {0};
    fb_image_desc.render_target = true;
    fb_image_desc.width = w;
    fb_image_desc.height = h;
    // fb_image_desc.min_filter = (sg_filter)_lib->filtermode; // TODO: filtermode for canvas
    // fb_image_desc.mag_filter = (sg_filter)_lib->filtermode;
    fb_image_desc.wrap_u = SG_WRAP_CLAMP_TO_EDGE;
    fb_image_desc.wrap_v = SG_WRAP_CLAMP_TO_EDGE;
    sg_image fb_image = sg_make_image(&fb_image_desc);
    if(sg_query_image_state(fb_image) != SG_RESOURCESTATE_VALID) {
        fprintf(stderr, "Failed to create frame buffer image\n");
        return 1;
    }
    canvas.handle = fb_image.id;
    // create frame buffer depth stencil
    sg_image_desc fb_depth_image_desc = {0};
    fb_depth_image_desc.render_target = true;
    fb_depth_image_desc.width = w;
    fb_depth_image_desc.height = h;
    fb_depth_image_desc.pixel_format = SG_PIXELFORMAT_DEPTH_STENCIL;
    sg_image fb_depth_image = sg_make_image(&fb_depth_image_desc);
    if(sg_query_image_state(fb_depth_image) != SG_RESOURCESTATE_VALID) {
        fprintf(stderr, "Failed to create frame buffer depth image\n");
        return 2;
    }
    canvas.id_depth_image = fb_depth_image.id;
    // create frame buffer pass
    sg_pass_desc pass_desc = {0};
    pass_desc.color_attachments[0].image = fb_image;
    pass_desc.depth_stencil_attachment.image = fb_depth_image;
    sg_pass fb_pass = sg_make_pass(&pass_desc);
    if(sg_query_pass_state(fb_pass) != SG_RESOURCESTATE_VALID) {
        fprintf(stderr, "Failed to create frame buffer pass\n");
        return 3;
    }
    canvas.id_pass = fb_pass.id;
    mg_map_set(&imageitems, canvas.handle, &canvas);
    img->handle = canvas.handle;
    return 0;
}

int lyte_cleanup_image(lyte_Image image) {
    ImageItem *imageitem = mg_map_get(&imageitems, image.handle);
    if (!imageitem) {
        return 0;
    }
    if (imageitem->is_canvas) {
        sg_destroy_image((sg_image){.id = imageitem->id_depth_image});
        sg_destroy_pass((sg_pass){.id = imageitem->id_pass});
    }
    sg_destroy_image((sg_image){.id = imageitem->handle});
    mg_map_del(&imageitems, image.handle);
    return 0;
}

int lyte_get_image_width(lyte_Image image, int *val) {
    ImageItem *imageitem = mg_map_get(&imageitems, image.handle);
    if (!imageitem) {
        fprintf(stderr, "Image with handle %d not present\n", image.handle);
        return -1;
    }
    *val = imageitem->width;
    return 0;
}

int lyte_get_image_height(lyte_Image image, int *val) {
    ImageItem *imageitem = mg_map_get(&imageitems, image.handle);
    if (!imageitem) {
        fprintf(stderr, "Image with handle %d not present\n", image.handle);
        return -1;
    }
    *val = imageitem->height;
    return 0;
}

int lyte_is_image_canvas(lyte_Image image, bool *val) {
    ImageItem *imageitem = mg_map_get(&imageitems, image.handle);
    if (!imageitem) {
        fprintf(stderr, "Image with handle %d not present\n", image.handle);
        return -1;
    }
    *val = imageitem->is_canvas;
    return 0;
}

int lyte_draw_image(lyte_Image image, int x, int y) {
    ImageItem *imageitem = mg_map_get(&imageitems, image.handle);
    if (!imageitem) {
        fprintf(stderr, "Image with handle %d not present\n", image.handle);
        return -1;
    }
    sg_image sgimage = (sg_image){ .id = image.handle };
    // TODO: blendmode?
    sgp_set_image(0, sgimage);
    sgp_draw_textured_rect(x, y, imageitem->width, imageitem->height);
    sgp_reset_image(0);
    return 0;
}

int lyte_draw_image_rect(lyte_Image image, int x, int y, int src_x, int src_y, int w, int h) {
    ImageItem *imageitem = mg_map_get(&imageitems, image.handle);
    if (!imageitem) {
        fprintf(stderr, "Image with handle %d not present\n", image.handle);
        return -1;
    }
    sg_image sgimage = (sg_image){ .id = image.handle };
    // TODO: blendmode?
    sgp_set_image(0, sgimage);
    sgp_draw_textured_rect_ex(0, (sgp_rect){x, y, w, h}, (sgp_rect){src_x, src_y, w, h});
    sgp_reset_image(0);
    return 0;
}

int lyte_set_canvas(lyte_Image image) {
    ImageItem *imageitem = mg_map_get(&imageitems, image.handle);
    if (!imageitem) {
        fprintf(stderr, "Image with handle %d not present\n", image.handle);
        return -1;
    }
    if (!imageitem->is_canvas) {
        fprintf(stderr, "Image with handle %d is not a canvas\n", image.handle);
        return 1;
    }
    sgp_begin(imageitem->width, imageitem->height);
    // sgp_set_blend_mode((sgp_blend_mode)_lib->blendmode); // TODO: blendmode
    sgp_scale(1.0, -1.0);
    sgp_translate(0, -imageitem->height);
    sgp_push_transform();

    current_canvas = imageitem;
    return 0;
}

int lyte_reset_canvas(void) {
    sgp_pop_transform();
    sg_pass canvas_pass = (sg_pass){ .id = current_canvas->id_pass };
    sg_pass_action pass_action;
    memset(&pass_action, 0, sizeof(sg_pass_action));
    pass_action.colors[0].action = SG_ACTION_CLEAR;
    pass_action.colors[0].value.r = 1.0f;
    pass_action.colors[0].value.g = 1.0f;
    pass_action.colors[0].value.b = 1.0f;
    pass_action.colors[0].value.a = 1.0f;
    sg_begin_pass(canvas_pass, &pass_action);
    sgp_flush();
    sgp_end();
    sg_end_pass();
    current_canvas = NULL;
    return 0;
}