//

#include <stdio.h>
#include <assert.h>
#include <stdlib.h>
#include <string.h>
#include <math.h> // for sinf() and cosf()

#include "lyte_core.h"
#include "map.h"

#include "sokol_gfx.h"
#include "sokol_gp.h"

#ifndef MAX_CIRCLE_TRIS
#define MAX_CIRCLE_TRIS 1024
#endif


int lyte_draw_point(int x, int y) {
    return 0;
}

int lyte_draw_line(int x1, int y1, int x2, int y2) {
    sgp_draw_line(x1, y1, x2, y2);
    return 0;
}

int lyte_draw_rect(int x, int y, int w, int h) {
    sgp_draw_filled_rect(x, y, w, h);
    return 0;
}

int lyte_draw_rect_line(int x, int y, int w, int h) {
    sgp_line lines[4] = {
        (sgp_line){{x, y}, {x, y+h}},
        (sgp_line){{x, y+h}, {x+w, y+h}},
        (sgp_line){{x+w, y+h}, {x+w, y}},
        (sgp_line){{x+w, y}, {x, y+1}},
    };
    sgp_draw_lines(lines, 4);
    return 0;
}

int lyte_draw_circle(int dest_x, int dest_y, int radius) {
    float x = (float)dest_x;
    float y = (float)dest_y;
    float r = (float)radius;

    static sgp_triangle tris[MAX_CIRCLE_TRIS];
    int count = MIN(MAX(7.0f, 2.0f * r / (float)M_PI), MAX_CIRCLE_TRIS);
    float delta_angle = 2.0*(float)M_PI/(float)count;

    for (int i=0; i<count; i++) {
        tris[i].a.x = x;
        tris[i].a.y = y;

        tris[i].b.x = x + r/2.0f * sinf(i * delta_angle);
        tris[i].b.y = y - r/2.0f * cosf(i * delta_angle);

        tris[i].c.x = x + r/2.0f * sinf((i+1)* delta_angle);
        tris[i].c.y = y - r/2.0f * cosf((i+1) * delta_angle);
    }
    sgp_draw_filled_triangles(tris, count);
    return 0;
}

int lyte_draw_circle_line(int dest_x, int dest_y, int radius) {
    float x = (float)dest_x;
    float y = (float)dest_y;
    float r = (float)radius;

    static sgp_line lines[MAX_CIRCLE_TRIS];
    int count = MIN(MAX(7.0f, 2.0f * r / (float)M_PI), MAX_CIRCLE_TRIS);
    float delta_angle = 2.0*(float)M_PI/(float)count;

    for (int i=0; i<count; i++) {
        lines[i].a.x = x + r/2.0f * sinf(i * delta_angle);
        lines[i].a.y = y - r/2.0f * cosf(i * delta_angle);

        lines[i].b.x = x + r/2.0f * sinf((i+1)* delta_angle);
        lines[i].b.y = y - r/2.0f * cosf((i+1) * delta_angle);
    }
    sgp_draw_lines(lines, count);
    return 0;
}
