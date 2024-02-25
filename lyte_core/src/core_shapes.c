//

#include <stdio.h>
#include <assert.h>
#include <stdlib.h>
#include <string.h>
#include <math.h> // for sinf() and cosf()

#include "lyte_core.h"

#include "sokol_gfx.h"
#include "sokol_gp.h"

#ifndef MAX_CIRCLE_TRIS
#define MAX_CIRCLE_TRIS 1024
#endif

int lyte_draw_point(double x, double y) {
    sgp_draw_filled_rect(x, y, 1, 1);
    return 0;
}

int lyte_draw_line(double x1, double y1, double x2, double y2) {
    sgp_draw_line(x1, y1, x2, y2);
    return 0;
}

int lyte_draw_triangle(double ax, double ay, double bx, double by, double cx, double cy) {
    sgp_draw_filled_triangle(ax, ay, bx, by, cx, cy);
    return 0;
}

int lyte_draw_triangle_line(double ax, double ay, double bx, double by, double cx, double cy) {
    sgp_line lines[4] = {
        (sgp_line){{ax, ay}, {bx, by}},
        (sgp_line){{bx, by}, {cx, cy}},
        (sgp_line){{cx, cy}, {ax, ay}},
    };
    sgp_draw_lines(lines, 4);
    return 0;
}

int lyte_draw_rect(double x, double y, double w, double h) {
    sgp_draw_filled_rect(x, y, w, h);
    return 0;
}

int lyte_draw_rect_line(double x, double y, double w, double h) {
    sgp_line lines[4] = {
        (sgp_line){{x, y}, {x, y+h}},
        (sgp_line){{x, y+h}, {x+w, y+h}},
        (sgp_line){{x+w, y+h}, {x+w, y}},
        (sgp_line){{x+w, y}, {x, y+1}},
    };
    sgp_draw_lines(lines, 4);
    return 0;
}

int lyte_draw_circle(double dest_x, double dest_y, double radius) {
    return lyte_draw_ellipse(dest_x, dest_y, radius, radius);
}

int lyte_draw_circle_line(double dest_x, double dest_y, double radius) {
    return lyte_draw_ellipse_line(dest_x, dest_y, radius, radius);
}

int lyte_draw_ellipse(double dest_x, double dest_y, double radius_x, double radius_y) {
    float x = (float)dest_x;
    float y = (float)dest_y;
    float r = (float)((radius_x + radius_y)/2.0);

    float xr = (float)radius_x / r;
    float yr = (float)radius_y / r;

    static sgp_triangle tris[MAX_CIRCLE_TRIS];
    int count = MIN(MAX(7.0f, 2.0f * r / (float)M_PI), MAX_CIRCLE_TRIS);
    float delta_angle = 2.0*(float)M_PI/(float)count;

    for (int i=0; i<count; i++) {
        tris[i].a.x = x;
        tris[i].a.y = y;

        tris[i].b.x = x + r * xr *sinf(i * delta_angle);
        tris[i].b.y = y - r * yr * cosf(i * delta_angle);

        tris[i].c.x = x + r * xr * sinf((i+1)* delta_angle);
        tris[i].c.y = y - r * yr * cosf((i+1) * delta_angle);
    }
    sgp_draw_filled_triangles(tris, count);
    return 0;
}

int lyte_draw_ellipse_line(double dest_x, double dest_y, double radius_x, double radius_y) {
    float x = (float)dest_x;
    float y = (float)dest_y;
    float r = (float)((radius_x + radius_y)/2.0);

    float xr = (float)radius_x / r;
    float yr = (float)radius_y / r;

    static sgp_line lines[MAX_CIRCLE_TRIS];
    int count = MIN(MAX(7.0f, 2.0f * r / (float)M_PI), MAX_CIRCLE_TRIS);
    float delta_angle = 2.0*(float)M_PI/(float)count;

    for (int i=0; i<count; i++) {
        lines[i].a.x = x + r * xr * sinf(i * delta_angle);
        lines[i].a.y = y - r * yr * cosf(i * delta_angle);

        lines[i].b.x = x + r * xr * sinf((i+1)* delta_angle);
        lines[i].b.y = y - r * yr * cosf((i+1) * delta_angle);
    }
    sgp_draw_lines(lines, count);
    return 0;
}
