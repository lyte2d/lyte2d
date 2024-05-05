//

#include <stdio.h>
#include <assert.h>
#include <stdlib.h>
#include <string.h>

#include "lyte_core.h"

#include "physfs.h"

#include "sokol_gfx.h"
#include "sokol_gfx_ext.h"
#include "sokol_gp.h"
#include "stb_image.h"

// #define MAX_IMAGEBATCH_RECT_CAPACITY 1024
#define INITIAL_IMAGEBATCH_RECT_CAPACITY 16

typedef struct ImageItem {
    uint32_t handle; // **MAGIC_1** NOTE: needs to stay the first element in the struct. (pointer magic in core_shader.c)
    uint32_t sampler_handle;
    int ref;
    int width;
    int height;
    bool is_canvas; // if true, values below should also be set
    uint32_t id_depth_image;
    uint32_t id_pass;
} ImageItem;

static ImageItem *current_canvas = NULL;

int lyte_core_image_init(void) {
    return 0;
}

int lyte_core_image_cleanup(void) {
    return 0;
}

int lyte_load_image(const char *path, lyte_Image *img) {
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
    sg_image_desc image_desc = {0};
    image_desc.width = width;
    image_desc.height = height;
    image_desc.data.subimage[0][0].ptr = data;
    image_desc.data.subimage[0][0].size = (size_t)(width * height * 4);
    sg_image sgimage = sg_make_image(&image_desc);
    stbi_image_free(data);

    sg_sampler_desc sampler_desc = {0};
    sampler_desc.min_filter = (sg_filter)lytecore_state.filtermode;
    sampler_desc.mag_filter = (sg_filter)lytecore_state.filtermode;
    // sampler_desc.wrap_u = SG_WRAP_REPEAT;
    // sampler_desc.wrap_v = SG_WRAP_REPEAT;
    sampler_desc.wrap_u = SG_WRAP_CLAMP_TO_EDGE;
    sampler_desc.wrap_v = SG_WRAP_CLAMP_TO_EDGE;
    sg_sampler sgsampler = sg_make_sampler(&sampler_desc);

    ImageItem *ii = malloc(sizeof(ImageItem));
    ii->handle = sgimage.id;
    ii->sampler_handle = sgsampler.id;
    ii->width = width;
    ii->height = height;
    ii->is_canvas = false;
    ii->ref = 1;

    // img = (lyte_Image *)&ii;
    *img = ii;
    free(buf);
    PHYSFS_close(file);
    return 0;
}

int lyte_new_canvas(int w, int h, lyte_Image *img) {
    ImageItem *c = malloc(sizeof(ImageItem));
    c->width = w;
    c->height = h;
    c->is_canvas = true;

    // create frame buffer image
    sg_image_desc fb_image_desc = {0};
    fb_image_desc.render_target = true;
    fb_image_desc.width = w;
    fb_image_desc.height = h;
    sg_image fb_image = sg_make_image(&fb_image_desc);
    if(sg_query_image_state(fb_image) != SG_RESOURCESTATE_VALID) {
        fprintf(stderr, "Failed to create frame buffer image\n");
        return 1;
    }
    c->handle = fb_image.id;
    sg_sampler_desc fb_sampler_desc = {0};
    // fb_sampler_desc.min_filter = (sg_filter)_lib->filtermode; // TODO: filtermode for canvas
    // fb_sampler_desc.mag_filter = (sg_filter)_lib->filtermode;
    fb_sampler_desc.wrap_u = SG_WRAP_CLAMP_TO_EDGE;
    fb_sampler_desc.wrap_v = SG_WRAP_CLAMP_TO_EDGE;
    sg_sampler fb_sampler = sg_make_sampler(&fb_sampler_desc);
    c->sampler_handle = fb_sampler.id;
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
    c->id_depth_image = fb_depth_image.id;
    // create frame buffer pass
    sg_pass_desc pass_desc = {0};
    pass_desc.color_attachments[0].image = fb_image;
    pass_desc.depth_stencil_attachment.image = fb_depth_image;
    sg_pass fb_pass = sg_make_pass(&pass_desc);
    if(sg_query_pass_state(fb_pass) != SG_RESOURCESTATE_VALID) {
        fprintf(stderr, "Failed to create frame buffer pass\n");
        return 3;
    }
    c->id_pass = fb_pass.id;
    c->ref = 1;

    // img = (lyte_Image *)&c;
    *img = c;
    return 0;
}

static inline void _free_imageitem(ImageItem *imageitem) {
    if (!imageitem) {
        return;
    }
    if (imageitem->ref > 0) {
        imageitem->ref -= 1;
    }
    if (imageitem->ref == 0) {
        if (imageitem->is_canvas) {
            sg_destroy_image((sg_image){.id = imageitem->id_depth_image});
            sg_destroy_pass((sg_pass){.id = imageitem->id_pass});
        }
        sg_destroy_image((sg_image){.id = imageitem->handle});
        sg_destroy_sampler((sg_sampler){.id = imageitem->sampler_handle});
        free(imageitem);
    }
}

int lyte_Image_cleanup(lyte_Image image) {
    ImageItem *imageitem = image;
    _free_imageitem(imageitem);
    // image.ptr = NULL;
    return 0;
}

int lyte_get_image_width(lyte_Image image, int *val) {
    ImageItem *imageitem = image;
    if (!imageitem) {
        fprintf(stderr, "Image not found\n");
        return -1;
    }
    *val = imageitem->width;
    return 0;
}

int lyte_get_image_height(lyte_Image image, int *val) {
    ImageItem *imageitem = image;
    if (!imageitem) {
        fprintf(stderr, "Image not found\n");
        return -1;
    }
    *val = imageitem->height;
    return 0;
}

int lyte_is_image_canvas(lyte_Image image, bool *val) {
    ImageItem *imageitem = image;
    if (!imageitem) {
        fprintf(stderr, "Image not found\n");
        return -1;
    }
    *val = imageitem->is_canvas;
    return 0;
}


int lyte_draw_image(lyte_Image image, double x, double y) {
    ImageItem *imageitem = image;
    if (!imageitem) {
        fprintf(stderr, "Image not found\n");
        return -1;
    }
    sg_image sgimage = (sg_image){ .id = imageitem->handle };
    sgp_set_image(0, sgimage);
    sg_sampler sgsampler = (sg_sampler){ .id = imageitem->sampler_handle };
    sgp_set_sampler(0, sgsampler);

    sgp_draw_textured_rect(0, (sgp_rect){x, y, imageitem->width, imageitem->height}, (sgp_rect){0, 0, imageitem->width, imageitem->height});

    sgp_reset_image(0);
    return 0;
}

int lyte_draw_image_ex(lyte_Image image, double x, double y, double angle, double ox, double oy, double sx, double sy) {
    ImageItem *imageitem = image;
    if (!imageitem) {
        fprintf(stderr, "Image not found\n");
        return -1;
    }
    sg_image sgimage = (sg_image){ .id = imageitem->handle };
    sgp_set_image(0, sgimage);
    sg_sampler sgsampler = (sg_sampler){ .id = imageitem->sampler_handle };
    sgp_set_sampler(0, sgsampler);

    sgp_push_transform();
    sgp_translate(x + ox, y + oy);
    sgp_rotate(angle);
    sgp_scale(sx, sy);
    sgp_translate(-ox, -oy);
    sgp_draw_textured_rect(0, (sgp_rect){0, 0, imageitem->width, imageitem->height}, (sgp_rect){0, 0, imageitem->width, imageitem->height});
    sgp_pop_transform();

    sgp_reset_image(0);
    return 0;

    return 0;
}

int lyte_draw_image_rect(lyte_Image image, double x, double y, double src_x, double src_y, double src_w, double src_h) {
    ImageItem *imageitem = image;
    if (!imageitem) {
        fprintf(stderr, "Image not found\n");
        return -1;
    }
    sg_image sgimage = (sg_image){ .id = imageitem->handle };
    sgp_set_image(0, sgimage);
    sg_sampler sgsampler = (sg_sampler){ .id = imageitem->sampler_handle };
    sgp_set_sampler(0, sgsampler);
    sgp_draw_textured_rect(0, (sgp_rect){x, y, src_w, src_h}, (sgp_rect){src_x, src_y, src_w, src_h});
    sgp_reset_image(0);
    return 0;
}

int lyte_draw_image_rect_ex(lyte_Image image, double x, double y, double src_x, double src_y, double src_w, double src_h, double angle, double ox, double oy, double sx, double sy) {
    ImageItem *imageitem = image;
    if (!imageitem) {
        fprintf(stderr, "Image not found\n");
        return -1;
    }
    sg_image sgimage = (sg_image){ .id = imageitem->handle };
    sgp_set_image(0, sgimage);
    sg_sampler sgsampler = (sg_sampler){ .id = imageitem->sampler_handle };
    sgp_set_sampler(0, sgsampler);

    sgp_push_transform();
    sgp_translate(x + ox, y + oy);
    sgp_rotate(angle);
    sgp_scale(sx, sy);
    sgp_translate(-ox, -oy);
    sgp_draw_textured_rect(0, (sgp_rect){0, 0, src_w, src_h}, (sgp_rect){src_x, src_y, src_w, src_h});
    sgp_pop_transform();

    sgp_reset_image(0);
    return 0;
}


static int _lyte_set_canvas(lyte_Image image, bool updown) {
    if (current_canvas) {
        fprintf(stderr, "Canvas was already set.");
            return 1;
    }
    ImageItem *imageitem = image;
    if (!imageitem) {
        fprintf(stderr, "Image not found\n");
        return -1;
    }
    if (!imageitem->is_canvas) {
        fprintf(stderr, "Image is not a canvas\n");
        return 1;
    }
    sgp_begin(imageitem->width, imageitem->height);
    if (updown) {
        sgp_scale(1.0, 1.0);
    } else {
        sgp_scale(1.0, -1.0);
        sgp_translate(0, -imageitem->height);
    }
    sgp_push_transform();

    lyte_set_blendmode(lytecore_state.blendmode);

    current_canvas = imageitem;
    return 0;
}

int lyte_set_canvas(lyte_Image image) {
    return _lyte_set_canvas(image, false);
}


int lyte_reset_canvas(void) {
    if (!current_canvas) {
        fprintf(stderr, "No canvas was set.");
            return 1;
    }
    sgp_pop_transform();
    sg_pass canvas_pass = (sg_pass){ .id = current_canvas->id_pass };
    sg_pass_action pass_action;
    memset(&pass_action, 0, sizeof(sg_pass_action));
    pass_action.colors[0].load_action = SG_LOADACTION_CLEAR;
    pass_action.colors[0].clear_value.r = 1.0f;
    pass_action.colors[0].clear_value.g = 1.0f;
    pass_action.colors[0].clear_value.b = 1.0f;
    pass_action.colors[0].clear_value.a = 1.0f;
    sg_begin_pass(canvas_pass, &pass_action);
    sgp_flush();
    sgp_end();
    sg_end_pass();
    current_canvas = NULL;
    return 0;
}


typedef struct ImageBatchItem {
    lyte_Image image;
    int capacity; // capacity
    int count; // current count
    sgp_textured_rect *rects;
} ImageBatchItem;


int lyte_new_imagebatch(lyte_Image image, lyte_ImageBatch *val) {
    ImageBatchItem *ibi = malloc(sizeof(ImageBatchItem));

    ibi->image = image; // TODO: keep a ref!

    ibi->capacity = 0;
    ibi->count = 0;
    ibi->rects = NULL;
    ImageItem *imageitem = ibi->image;
    imageitem->ref += 1;

    // val = (lyte_Image *)&ibi;
    *val = ibi;
    return 0;
}

int lyte_ImageBatch_cleanup(lyte_ImageBatch imagebatch) {
    ImageBatchItem *ibi = imagebatch;
    if (ibi->rects != NULL) {
        free(ibi->rects);
        ibi->rects = NULL;
        ibi->capacity = 0;
        ibi->count = 0;
    }
    ImageItem *imageitem = ibi->image;
    _free_imageitem(imageitem);
    ibi->image = NULL;
    return 0;
}

int lyte_reset_imagebatch(lyte_ImageBatch imagebatch) {
    ImageBatchItem *ibi = imagebatch;
    if (ibi->rects) {
        memset(ibi->rects, 0, sizeof(sgp_textured_rect)*ibi->capacity);
        ibi->count = 0;
    }
    return 0;
}
int lyte_add_imagebatch_rect(lyte_ImageBatch imagebatch, double dest_x, double dest_y, double dest_width, double dest_height, double src_x, double src_y, double src_width, double src_height) {
    ImageBatchItem *ibi = imagebatch;
    if (!ibi->rects) {
        // initial allocation
        ibi->count = 0;
        ibi->capacity = INITIAL_IMAGEBATCH_RECT_CAPACITY;
        ibi->rects = malloc(sizeof(sgp_textured_rect) * ibi->capacity);
    }
    if (ibi->count > ibi->capacity - 3) {
        // grow capacity
        ibi->capacity = ibi->capacity * 2;
        ibi->rects  = realloc(ibi->rects, sizeof(sgp_textured_rect) * ibi->capacity);
    }
    ibi->rects[ibi->count] = (sgp_textured_rect){
        (sgp_rect){dest_x, dest_y, dest_width, dest_height},
        (sgp_rect){src_x, src_y, src_width, src_height},
    };
    ibi->count += 1;
    return 0;
}

int lyte_get_imagebatch_rect_count(lyte_ImageBatch imagebatch, int *val) {
    ImageBatchItem *ibi = imagebatch;
    *val = ibi->count;
    return 0;
}

int lyte_draw_imagebatch(lyte_ImageBatch imagebatch) {
    ImageBatchItem *ibi = imagebatch;
    if (ibi->rects) {
        ImageItem *imageitem = ibi->image;
        sg_image sgimage = (sg_image){ .id = imageitem->handle };
        sgp_set_image(0, sgimage);
        sg_sampler sgsampler = (sg_sampler){ .id = imageitem->sampler_handle };
        sgp_set_sampler(0, sgsampler);
        sgp_draw_textured_rects(0, ibi->rects, ibi->count);
        sgp_reset_image(0);
    }
    return 0;
}

static sg_image capture_screen_image(int x, int y, int w , int h) {
    // sg_image_info info = sg_query_image_info(fb_image);
    // size_t num_pixels = (size_t)(info.width * info.height * 4);
    size_t num_pixels = (size_t)(w * h * 4);
    // void *pixels = SOKOL_MALLOC(num_pixels);
    void *pixels = malloc(num_pixels);
    assert(pixels);
    sg_query_pixels(x, y, w, h, true, pixels, num_pixels);
    sg_image_desc image_desc;
    memset(&image_desc, 0, sizeof(image_desc));
    image_desc.width = w;//info.width;
    image_desc.height = h;//info.height;
    image_desc.pixel_format = SG_PIXELFORMAT_RGBA8;
    image_desc.data.subimage[0][0].ptr = pixels;
    image_desc.data.subimage[0][0].size = num_pixels;
    sg_image image = sg_make_image(&image_desc);
    assert(sg_query_image_state(image) == SG_RESOURCESTATE_VALID);
    // SOKOL_FREE(pixels);
    free(pixels);
    return image;

}


int lyte_capture_image(int x, int y, int w, int h, lyte_Image *val) {
    float xscale = lytecore_state.hidpi_xscale;
    float yscale = lytecore_state.hidpi_xscale;
    int orig_w = w;
    int orig_h = h;

    x *= xscale;
    y *= yscale;
    w *= xscale;
    h *= yscale;
    sg_image img =  capture_screen_image(x, y, w, h);

    sg_sampler_desc sampler_desc = {0};
    sampler_desc.min_filter = (sg_filter)lytecore_state.filtermode;
    sampler_desc.mag_filter = (sg_filter)lytecore_state.filtermode;
    // sampler_desc.wrap_u = SG_WRAP_REPEAT;
    // sampler_desc.wrap_v = SG_WRAP_REPEAT;
    sampler_desc.wrap_u = SG_WRAP_CLAMP_TO_EDGE;
    sampler_desc.wrap_v = SG_WRAP_CLAMP_TO_EDGE;
    sg_sampler sgsampler = sg_make_sampler(&sampler_desc);


    ImageItem *ii = malloc(sizeof(ImageItem));
    ii->handle = img.id;
    ii->sampler_handle = sgsampler.id;
    ii->width = w;
    ii->height = h;
    ii->is_canvas = false;
    ii->ref = 1;


    lyte_Image cvs;

    lyte_new_canvas(orig_w, orig_h, &cvs);
    _lyte_set_canvas(cvs, true);
    lyte_cls(0,0,0,0);
    lyte_scale(1/xscale, 1/yscale);
    lyte_draw_image(ii, 0, 0);
    lyte_reset_canvas();

    lyte_Image_cleanup(ii);

    *val = cvs;

    return 0;
}