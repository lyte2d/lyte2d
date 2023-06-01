//

#include <stdio.h>
#include <assert.h>
#include <stdlib.h>
#include <string.h>

#include "lyte_core.h"

#include "physfs.h"

#include "sokol_gfx.h"
#include "sokol_gp.h"


#if defined(_MSC_VER )
#pragma warning(disable:4996)   // strncpy use in fontstash.h
#endif
#if defined(__GNUC__) || defined(__clang__)
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wunused-function"
#pragma GCC diagnostic ignored "-Wsign-conversion"
#endif
#include "fontstash.h"
#if defined(__GNUC__) || defined(__clang__)
#pragma GCC diagnostic pop
#endif

// --- fontstash issue with compilation
int fonsAddFontMem(FONScontext* stash, const char* name, unsigned char* data, int dataSize, int freeData);
// ---

#ifndef FONT_ATLAS_SIZE
#define FONT_ATLAS_SIZE 1024
#endif

#ifndef INIT_NUM_FONTITEMS
#define INIT_NUM_FONTITEMS 10
#endif

typedef struct FontItem {
    FONScontext *fonsctx;
    void *fontdata;
    uint8_t *buffer;
    uint32_t imageid;
    int width;
    int height;
    int font;
    int atlas_dim;
    double fontsize;
} FontItem;

static FontItem *current_font = NULL;

int lyte_core_font_init(void) {
    return 0;
}

int lyte_core_font_cleanup(void) {
    return 0;
}

// fontstash callbacks
static int _fons_render_create(void *user_ptr, int width, int height) {
    // printf("FONS: render create %p %d %d\n", user_ptr, width, height);
    FontItem *fontitem = (FontItem *)user_ptr;
    fontitem->width = width;
    fontitem->height = height;

    sg_image_desc imdesc = (sg_image_desc) {
        .width = width,
        .height = height,
        // .pixel_format = SG_PIXELFORMAT_R8,
        .pixel_format = SG_PIXELFORMAT_RGBA8,
        .min_filter = (sg_filter)lytecore_state.filtermode,
        .mag_filter = (sg_filter)lytecore_state.filtermode,
        .type = SG_IMAGETYPE_2D,
        .usage = SG_USAGE_DYNAMIC,
    };
    sg_image img = sg_make_image(&imdesc);
    fontitem->imageid = img.id;
    fontitem->buffer = malloc(width*height*4);
    return 1;
}

static void _fons_render_delete(void *user_ptr) {
    // printf("FONS: render delete\n");
    FontItem *fontitem = (FontItem *)user_ptr;
    sg_image img = (sg_image){ .id=fontitem->imageid };
    sg_destroy_image(img);
    fontitem->imageid = 0;
    free(fontitem->buffer);
}

static int _fons_render_resize(void *user_ptr, int width, int height) {
    // printf("FONS: render resize %d %d\n", width, height);
    _fons_render_delete(user_ptr);
    return _fons_render_create(user_ptr, width, height);
}

static void _fons_render_update(void *user_ptr, int *rect, const uint8_t *data) {
    FontItem *fontitem = (FontItem *)user_ptr;
    int width = fontitem->width;
    int height = fontitem->height;

    int X1 = rect[0];
    int Y1 = rect[1];
    int X2 = rect[2];
    int Y2 = rect[3];

    sg_image img = (sg_image){ .id=fontitem->imageid };

    uint8_t *mydata = fontitem->buffer;

    int ww=0;
    int hh=0;
    for (int iy=Y1; iy<Y2; iy++) {
        hh++;
        ww=0;
        for (int ix=X1; ix<X2; ix++) {
            ww++;
            int i = ix + iy*width;
            uint8_t val = data[i];
            mydata[i*4] = val;
            mydata[i*4+1] = val;
            mydata[i*4+2] = val;
            mydata[i*4+3] = val;
        }
    }

    sg_image_data imdat = {0};
    imdat.subimage[0][0].ptr = mydata,
    imdat.subimage[0][0].size = width*height*4,
    sg_update_image(img, &imdat);
}

static void _fons_render_draw(void *user_ptr, const float *verts, const float *tcoords, const uint32_t *colors, int nverts) {
    FontItem *fontitem = (FontItem *)user_ptr;

    int width = fontitem->width;
    int height = fontitem->height;

    sg_image img = (sg_image){ .id=fontitem->imageid };

    sgp_set_image(0,img);
    sgp_set_blend_mode((sgp_blend_mode)lytecore_state.blendmode);
    // sgp_set_blend_mode(SGP_BLENDMODE_BLEND);

    for (int i=0; i<nverts-2; i += 3) {
        int q = 0;
        float p1x = verts[(q+i)*2];
        float p1y = verts[(q+i)*2+1];
        float t1x = tcoords[(q+i)*2];
        float t1y = tcoords[(q+i)*2+1];
        q++;
        float p2x = verts[(q+i)*2];
        float p2y = verts[(q+i)*2+1];
        float t2x = tcoords[(q+i)*2];
        float t2y = tcoords[(q+i)*2+1];
        q++;
        float p3x = verts[(q+i)*2];
        float p3y = verts[(q+i)*2+1];
        float t3x = tcoords[(q+i)*2];
        float t3y = tcoords[(q+i)*2+1];

        sgp_push_transform();
        // sgp_scale(1.0/M_FONT_MULT,1.0/M_FONT_MULT);
        sgp_translate(p1x,p1y);
        sgp_draw_textured_rect_ex(0, (sgp_rect){0,0,(p3x-p1x), (p3y-p1y)}, (sgp_rect){t1x*width, t1y*height, (t3x-t1x)*width, (t3y-t1y)*height});
        sgp_pop_transform();

    }

    sgp_reset_image(0);
}


int lyte_load_font(const char * path, double size, lyte_Font *val) {
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

    FontItem *fi = malloc(sizeof(FontItem));

    fi->atlas_dim = FONT_ATLAS_SIZE;
    fi->fontsize = size;
    fi->imageid = 0;
    fi->width = 0;
    fi->height = 0;
    fi->fontdata = buf;

    FONSparams params = {
        .flags = FONS_ZERO_TOPLEFT,
        .width = fi->atlas_dim,
        .height = fi->atlas_dim,
        .userPtr = fi,
        .renderCreate = _fons_render_create,
        .renderDelete = _fons_render_delete,
        .renderResize = _fons_render_resize,
        .renderUpdate = _fons_render_update,
        .renderDraw = _fons_render_draw,
    };
    fi->fonsctx = fonsCreateInternal(&params);
    fi->font = fonsAddFontMem(fi->fonsctx, path, buf, read_len, false);

    val->ptr = fi;

    PHYSFS_close(file);
    return 0;
}

int lyte_cleanup_font(lyte_Font font) {
    FontItem *fontitem = font.ptr;

    if (fontitem == NULL) {
        return 0;
    }
    free(fontitem->fontdata);
    fonsDeleteInternal(fontitem->fonsctx);
    free(fontitem);
    return 0;
}

int lyte_set_font(lyte_Font font) {
    FontItem *fontitem = font.ptr;

    if (fontitem == NULL) {
        fprintf(stderr, "Font with not found\n");
        return -1;
    }
    current_font = fontitem;

    return 0;
}

int lyte_draw_text(const char * text, int dest_x, int dest_y) {
    if (current_font == NULL) {
        fprintf(stderr, "No font set.\n");
        return -1;
    }
    if (current_font->font == FONS_INVALID) {
        fprintf(stderr, "Invalid font.\n");
        return -2;
    }
    FONScontext *ctx = current_font->fonsctx;
    fonsClearState(ctx);
    double fontsize = current_font->fontsize;
    float fontheight = 0.0;
    fonsSetFont(ctx, current_font->font);
    fonsSetSize(ctx, fontsize);
    fonsVertMetrics(ctx, NULL, NULL, &fontheight);
    fonsSetBlur(ctx, 0);
    double last_x = fonsDrawText(ctx, dest_x, dest_y+fontheight, text,  NULL);

    return 0;
}

static inline int _get_text_size(const char *text, int *w, int *h) {
    if (current_font->font == FONS_INVALID) {
        return -1;
    }

    FONScontext *ctx = current_font->fonsctx;
    float width;
    float height;
    fonsClearState(ctx);
    double fontsize = current_font->fontsize;
    float fontheight = 0.0;
    fonsSetFont(ctx, current_font->font);
    fonsSetSize(ctx, fontsize);
    width = (int)fonsTextBounds(ctx, 0, 0, text, text + strlen(text), NULL);
    fonsVertMetrics(ctx, NULL, NULL, &height);

    *w = (int)width;
    *h = (int)height;
    return 0;
}

int lyte_get_text_width(const char * text, int *val) {
    int _h; // throwaway
    return _get_text_size(text, val, &_h);
}

int lyte_get_text_height(const char * text, int *val) {
    int _w; // throwaway
    return _get_text_size(text, &_w, val);
}

