// generated template: edit this file
#ifndef _API_LYTE_CORE_IMPL_C_INCLUDED_
#define _API_LYTE_CORE_IMPL_C_INCLUDED_

// This file is included in another code file directly. Do not include this as a seperate compile unit.
// Keep functions static so that they can be inlined if possible.
// ==== begin: api_lyte_core.impl.c ====

#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>
#include <assert.h>

// NOTE:
// Edit and modify this file with the implementation details
// Rename the file and remove __EDIT__ from the filename

// #include NATIVELIBRARY_H_FILE


static inline int _quit(void) {
int err = 0;
    err = NATIVEFN_quit();
    return err;
}
static inline int _cls(double r, double g, double b, double a) {
    (void)r; (void)g; (void)b; (void)a; int err = 0;
    err = NATIVEFN_cls(r, g, b, a);
    return err;
}
static inline int _set_color(double r, double g, double b, double a) {
    (void)r; (void)g; (void)b; (void)a; int err = 0;
    err = NATIVEFN_set_color(r, g, b, a);
    return err;
}
static inline int _reset_color(void) {
int err = 0;
    err = NATIVEFN_reset_color();
    return err;
}
static inline int _draw_point(double x, double y) {
    (void)x; (void)y; int err = 0;
    err = NATIVEFN_draw_point(x, y);
    return err;
}
static inline int _draw_line(double x1, double y1, double x2, double y2) {
    (void)x1; (void)y1; (void)x2; (void)y2; int err = 0;
    err = NATIVEFN_draw_line(x1, y1, x2, y2);
    return err;
}
static inline int _draw_triangle(double ax, double ay, double bx, double by, double cx, double cy) {
    (void)ax; (void)ay; (void)bx; (void)by; (void)cx; (void)cy; int err = 0;
    err = NATIVEFN_draw_triangle(ax, ay, bx, by, cx, cy);
    return err;
}
static inline int _draw_triangle_line(double ax, double ay, double bx, double by, double cx, double cy) {
    (void)ax; (void)ay; (void)bx; (void)by; (void)cx; (void)cy; int err = 0;
    err = NATIVEFN_draw_triangle_line(ax, ay, bx, by, cx, cy);
    return err;
}
static inline int _draw_rect(double dest_x, double dest_y, double rect_width, double rect_height) {
    (void)dest_x; (void)dest_y; (void)rect_width; (void)rect_height; int err = 0;
    err = NATIVEFN_draw_rect(dest_x, dest_y, rect_width, rect_height);
    return err;
}
static inline int _draw_rect_line(double dest_x, double dest_y, double rect_width, double rect_height) {
    (void)dest_x; (void)dest_y; (void)rect_width; (void)rect_height; int err = 0;
    err = NATIVEFN_draw_rect_line(dest_x, dest_y, rect_width, rect_height);
    return err;
}
static inline int _draw_circle(double dest_x, double dest_y, double radius) {
    (void)dest_x; (void)dest_y; (void)radius; int err = 0;
    err = NATIVEFN_draw_circle(dest_x, dest_y, radius);
    return err;
}
static inline int _draw_circle_line(double dest_x, double dest_y, double radius) {
    (void)dest_x; (void)dest_y; (void)radius; int err = 0;
    err = NATIVEFN_draw_circle_line(dest_x, dest_y, radius);
    return err;
}
static inline int _draw_ellipse(double dest_x, double dest_y, double radius_x, double radius_y) {
    (void)dest_x; (void)dest_y; (void)radius_x; (void)radius_y; int err = 0;
    err = NATIVEFN_draw_ellipse(dest_x, dest_y, radius_x, radius_y);
    return err;
}
static inline int _draw_ellipse_line(double dest_x, double dest_y, double radius_x, double radius_y) {
    (void)dest_x; (void)dest_y; (void)radius_x; (void)radius_y; int err = 0;
    err = NATIVEFN_draw_ellipse_line(dest_x, dest_y, radius_x, radius_y);
    return err;
}
static inline int _image_cleanup(void *image) {
    (void)image; int err = 0;
    err = NATIVEFN_image_cleanup(image);
    return err;
}
static inline int _image_load(const char *image_path, void **val) {
    (void)image_path; int err = 0;
    err = NATIVEFN_image_load(image_path, val);
    return err;
}
static inline int _image_draw(void *image, double dest_x, double dest_y) {
    (void)image; (void)dest_x; (void)dest_y; int err = 0;
    err = NATIVEFN_image_draw(image, dest_x, dest_y);
    return err;
}
static inline int _image_draw_rect(void *image, double dest_x, double dest_y, double src_x, double src_y, double rect_width, double rect_height) {
    (void)image; (void)dest_x; (void)dest_y; (void)src_x; (void)src_y; (void)rect_width; (void)rect_height; int err = 0;
    err = NATIVEFN_image_draw_rect(image, dest_x, dest_y, src_x, src_y, rect_width, rect_height);
    return err;
}
static inline int _image_get_width(void *image, int *val) {
    (void)image; int err = 0;
    err = NATIVEFN_image_get_width(image, val);
    return err;
}
static inline int _image_get_height(void *image, int *val) {
    (void)image; int err = 0;
    err = NATIVEFN_image_get_height(image, val);
    return err;
}
static inline int _image_new_canvas(int width, int height, void **val) {
    (void)width; (void)height; int err = 0;
    err = NATIVEFN_image_new_canvas(width, height, val);
    return err;
}
static inline int _image_set_canvas(void *canvas_image) {
    (void)canvas_image; int err = 0;
    err = NATIVEFN_image_set_canvas(canvas_image);
    return err;
}
static inline int _reset_canvas(void) {
int err = 0;
    err = NATIVEFN_reset_canvas();
    return err;
}
static inline int _image_is_canvas(void *image, bool *val) {
    (void)image; int err = 0;
    err = NATIVEFN_image_is_canvas(image, val);
    return err;
}
static inline int _imagebatch_cleanup(void *imagebatch) {
    (void)imagebatch; int err = 0;
    err = NATIVEFN_imagebatch_cleanup(imagebatch);
    return err;
}
static inline int _imagebatch_new(void *image, void **val) {
    (void)image; int err = 0;
    err = NATIVEFN_imagebatch_new(image, val);
    return err;
}
static inline int _imagebatch_reset(void *imagebatch) {
    (void)imagebatch; int err = 0;
    err = NATIVEFN_imagebatch_reset(imagebatch);
    return err;
}
static inline int _imagebatch_add_rect(void *imagebatch, double dest_x, double dest_y, double dest_width, double dest_height, double src_x, double src_y, double src_width, double src_height) {
    (void)imagebatch; (void)dest_x; (void)dest_y; (void)dest_width; (void)dest_height; (void)src_x; (void)src_y; (void)src_width; (void)src_height; int err = 0;
    err = NATIVEFN_imagebatch_add_rect(imagebatch, dest_x, dest_y, dest_width, dest_height, src_x, src_y, src_width, src_height);
    return err;
}
static inline int _imagebatch_get_rect_count(void *imagebatch, int *val) {
    (void)imagebatch; int err = 0;
    err = NATIVEFN_imagebatch_get_rect_count(imagebatch, val);
    return err;
}
static inline int _imagebatch_draw(void *imagebatch) {
    (void)imagebatch; int err = 0;
    err = NATIVEFN_imagebatch_draw(imagebatch);
    return err;
}
static inline int _font_cleanup(void *font) {
    (void)font; int err = 0;
    err = NATIVEFN_font_cleanup(font);
    return err;
}
static inline int _font_load(const char *font_path, double size, void **val) {
    (void)font_path; (void)size; int err = 0;
    err = NATIVEFN_font_load(font_path, size, val);
    return err;
}
static inline int _font_set(void *font) {
    (void)font; int err = 0;
    err = NATIVEFN_font_set(font);
    return err;
}
static inline int _draw_text(const char *text, double dest_x, double dest_y) {
    (void)text; (void)dest_x; (void)dest_y; int err = 0;
    err = NATIVEFN_draw_text(text, dest_x, dest_y);
    return err;
}
static inline int _get_text_width(const char *text, int *val) {
    (void)text; int err = 0;
    err = NATIVEFN_get_text_width(text, val);
    return err;
}
static inline int _get_text_height(const char *text, int *val) {
    (void)text; int err = 0;
    err = NATIVEFN_get_text_height(text, val);
    return err;
}
static inline int _get_monitor_count(int *val) {
int err = 0;
    err = NATIVEFN_get_monitor_count(val);
    return err;
}
static inline int _get_monitor_name(int index, const char **val) {
    (void)index; int err = 0;
    err = NATIVEFN_get_monitor_name(index, val);
    return err;
}
static inline int _get_monitor_width(int index, int *val) {
    (void)index; int err = 0;
    err = NATIVEFN_get_monitor_width(index, val);
    return err;
}
static inline int _get_monitor_height(int index, int *val) {
    (void)index; int err = 0;
    err = NATIVEFN_get_monitor_height(index, val);
    return err;
}
static inline int _set_window_monitor(int index) {
    (void)index; int err = 0;
    err = NATIVEFN_set_window_monitor(index);
    return err;
}
static inline int _set_window_resizable(bool resizable) {
    (void)resizable; int err = 0;
    err = NATIVEFN_set_window_resizable(resizable);
    return err;
}
static inline int _set_window_minsize(int width, int height) {
    (void)width; (void)height; int err = 0;
    err = NATIVEFN_set_window_minsize(width, height);
    return err;
}
static inline int _set_window_size(int width, int height) {
    (void)width; (void)height; int err = 0;
    err = NATIVEFN_set_window_size(width, height);
    return err;
}
static inline int _get_window_width(int *val) {
int err = 0;
    err = NATIVEFN_get_window_width(val);
    return err;
}
static inline int _get_window_height(int *val) {
int err = 0;
    err = NATIVEFN_get_window_height(val);
    return err;
}
static inline int _set_window_position(int x, int y) {
    (void)x; (void)y; int err = 0;
    err = NATIVEFN_set_window_position(x, y);
    return err;
}
static inline int _set_fullscreen(bool fullscreen) {
    (void)fullscreen; int err = 0;
    err = NATIVEFN_set_fullscreen(fullscreen);
    return err;
}
static inline int _is_fullscreen(bool *val) {
int err = 0;
    err = NATIVEFN_is_fullscreen(val);
    return err;
}
static inline int _set_window_title(const char *title) {
    (void)title; int err = 0;
    err = NATIVEFN_set_window_title(title);
    return err;
}
static inline int _set_window_vsync(bool vsync) {
    (void)vsync; int err = 0;
    err = NATIVEFN_set_window_vsync(vsync);
    return err;
}
static inline int _is_window_vsync(bool *val) {
int err = 0;
    err = NATIVEFN_is_window_vsync(val);
    return err;
}
static inline int _set_window_icon_file(const char *icon_path) {
    (void)icon_path; int err = 0;
    err = NATIVEFN_set_window_icon_file(icon_path);
    return err;
}
static inline int _set_window_margins(int left, int right, int top, int bottom) {
    (void)left; (void)right; (void)top; (void)bottom; int err = 0;
    err = NATIVEFN_set_window_margins(left, right, top, bottom);
    return err;
}
static inline int _set_window_paddings(int left, int right, int top, int bottom) {
    (void)left; (void)right; (void)top; (void)bottom; int err = 0;
    err = NATIVEFN_set_window_paddings(left, right, top, bottom);
    return err;
}
static inline int _is_key_down(int key, bool *val) {
    (void)key; int err = 0;
    err = NATIVEFN_is_key_down(key, val);
    return err;
}
static inline int _is_key_pressed(int key, bool *val) {
    (void)key; int err = 0;
    err = NATIVEFN_is_key_pressed(key, val);
    return err;
}
static inline int _is_key_released(int key, bool *val) {
    (void)key; int err = 0;
    err = NATIVEFN_is_key_released(key, val);
    return err;
}
static inline int _is_key_repeat(int key, bool *val) {
    (void)key; int err = 0;
    err = NATIVEFN_is_key_repeat(key, val);
    return err;
}
static inline int _is_mouse_down(int mouse_button, bool *val) {
    (void)mouse_button; int err = 0;
    err = NATIVEFN_is_mouse_down(mouse_button, val);
    return err;
}
static inline int _is_mouse_pressed(int mouse_button, bool *val) {
    (void)mouse_button; int err = 0;
    err = NATIVEFN_is_mouse_pressed(mouse_button, val);
    return err;
}
static inline int _is_mouse_released(int mouse_button, bool *val) {
    (void)mouse_button; int err = 0;
    err = NATIVEFN_is_mouse_released(mouse_button, val);
    return err;
}
static inline int _get_mouse_x(int *val) {
int err = 0;
    err = NATIVEFN_get_mouse_x(val);
    return err;
}
static inline int _get_mouse_y(int *val) {
int err = 0;
    err = NATIVEFN_get_mouse_y(val);
    return err;
}
static inline int _get_gamepad_count(int *val) {
int err = 0;
    err = NATIVEFN_get_gamepad_count(val);
    return err;
}
static inline int _get_gamepad_name(int index, const char **val) {
    (void)index; int err = 0;
    err = NATIVEFN_get_gamepad_name(index, val);
    return err;
}
static inline int _is_gamepad_down(int index, int gamepad_button, bool *val) {
    (void)index; (void)gamepad_button; int err = 0;
    err = NATIVEFN_is_gamepad_down(index, gamepad_button, val);
    return err;
}
static inline int _is_gamepad_pressed(int index, int gamepad_button, bool *val) {
    (void)index; (void)gamepad_button; int err = 0;
    err = NATIVEFN_is_gamepad_pressed(index, gamepad_button, val);
    return err;
}
static inline int _is_gamepad_released(int index, int gamepad_button, bool *val) {
    (void)index; (void)gamepad_button; int err = 0;
    err = NATIVEFN_is_gamepad_released(index, gamepad_button, val);
    return err;
}
static inline int _get_gamepad_axis(int index, int gamepad_axis, double *val) {
    (void)index; (void)gamepad_axis; int err = 0;
    err = NATIVEFN_get_gamepad_axis(index, gamepad_axis, val);
    return err;
}
static inline int _set_mastervolume(double mastervolume) {
    (void)mastervolume; int err = 0;
    err = NATIVEFN_set_mastervolume(mastervolume);
    return err;
}
static inline int _get_mastervolume(double *val) {
int err = 0;
    err = NATIVEFN_get_mastervolume(val);
    return err;
}
static inline int _music_cleanup(void *music) {
    (void)music; int err = 0;
    err = NATIVEFN_music_cleanup(music);
    return err;
}
static inline int _music_load(const char *music_path, void **val) {
    (void)music_path; int err = 0;
    err = NATIVEFN_music_load(music_path, val);
    return err;
}
static inline int _music_play(void *music) {
    (void)music; int err = 0;
    err = NATIVEFN_music_play(music);
    return err;
}
static inline int _music_pause(void *music) {
    (void)music; int err = 0;
    err = NATIVEFN_music_pause(music);
    return err;
}
static inline int _music_resume(void *music) {
    (void)music; int err = 0;
    err = NATIVEFN_music_resume(music);
    return err;
}
static inline int _music_stop(void *music) {
    (void)music; int err = 0;
    err = NATIVEFN_music_stop(music);
    return err;
}
static inline int _music_is_playing(void *music, bool *val) {
    (void)music; int err = 0;
    err = NATIVEFN_music_is_playing(music, val);
    return err;
}
static inline int _music_get_length(void *music, double *val) {
    (void)music; int err = 0;
    err = NATIVEFN_music_get_length(music, val);
    return err;
}
static inline int _music_get_length_played(void *music, double *val) {
    (void)music; int err = 0;
    err = NATIVEFN_music_get_length_played(music, val);
    return err;
}
static inline int _music_seek(void *music, double secs) {
    (void)music; (void)secs; int err = 0;
    err = NATIVEFN_music_seek(music, secs);
    return err;
}
static inline int _music_set_volume(void *music, double volume) {
    (void)music; (void)volume; int err = 0;
    err = NATIVEFN_music_set_volume(music, volume);
    return err;
}
static inline int _music_set_pan(void *music, double pan) {
    (void)music; (void)pan; int err = 0;
    err = NATIVEFN_music_set_pan(music, pan);
    return err;
}
static inline int _music_set_pitch(void *music, double pitch) {
    (void)music; (void)pitch; int err = 0;
    err = NATIVEFN_music_set_pitch(music, pitch);
    return err;
}
static inline int _music_get_volume(void *music, double *val) {
    (void)music; int err = 0;
    err = NATIVEFN_music_get_volume(music, val);
    return err;
}
static inline int _music_get_pan(void *music, double *val) {
    (void)music; int err = 0;
    err = NATIVEFN_music_get_pan(music, val);
    return err;
}
static inline int _music_get_pitch(void *music, double *val) {
    (void)music; int err = 0;
    err = NATIVEFN_music_get_pitch(music, val);
    return err;
}
static inline int _sound_cleanup(void *sound) {
    (void)sound; int err = 0;
    err = NATIVEFN_sound_cleanup(sound);
    return err;
}
static inline int _sound_load(const char *sound_path, void **val) {
    (void)sound_path; int err = 0;
    err = NATIVEFN_sound_load(sound_path, val);
    return err;
}
static inline int _sound_clone(void *orig, void **val) {
    (void)orig; int err = 0;
    err = NATIVEFN_sound_clone(orig, val);
    return err;
}
static inline int _sound_play(void *sound) {
    (void)sound; int err = 0;
    err = NATIVEFN_sound_play(sound);
    return err;
}
static inline int _sound_pause(void *sound) {
    (void)sound; int err = 0;
    err = NATIVEFN_sound_pause(sound);
    return err;
}
static inline int _sound_resume(void *sound) {
    (void)sound; int err = 0;
    err = NATIVEFN_sound_resume(sound);
    return err;
}
static inline int _sound_stop(void *sound) {
    (void)sound; int err = 0;
    err = NATIVEFN_sound_stop(sound);
    return err;
}
static inline int _sound_is_playing(void *sound, bool *val) {
    (void)sound; int err = 0;
    err = NATIVEFN_sound_is_playing(sound, val);
    return err;
}
static inline int _sound_set_volume(void *sound, double volume) {
    (void)sound; (void)volume; int err = 0;
    err = NATIVEFN_sound_set_volume(sound, volume);
    return err;
}
static inline int _sound_set_pan(void *sound, double pan) {
    (void)sound; (void)pan; int err = 0;
    err = NATIVEFN_sound_set_pan(sound, pan);
    return err;
}
static inline int _sound_set_pitch(void *sound, double pitch) {
    (void)sound; (void)pitch; int err = 0;
    err = NATIVEFN_sound_set_pitch(sound, pitch);
    return err;
}
static inline int _sound_get_volume(void *sound, double *val) {
    (void)sound; int err = 0;
    err = NATIVEFN_sound_get_volume(sound, val);
    return err;
}
static inline int _sound_get_pan(void *sound, double *val) {
    (void)sound; int err = 0;
    err = NATIVEFN_sound_get_pan(sound, val);
    return err;
}
static inline int _sound_get_pitch(void *sound, double *val) {
    (void)sound; int err = 0;
    err = NATIVEFN_sound_get_pitch(sound, val);
    return err;
}
static inline int _load_textfile(const char *file_path, const char **val) {
    (void)file_path; int err = 0;
    err = NATIVEFN_load_textfile(file_path, val);
    return err;
}
static inline int _save_textfile(const char *file_path, const char *data) {
    (void)file_path; (void)data; int err = 0;
    err = NATIVEFN_save_textfile(file_path, data);
    return err;
}
static inline int _save_textfile_append(const char *file_path, const char *data) {
    (void)file_path; (void)data; int err = 0;
    err = NATIVEFN_save_textfile_append(file_path, data);
    return err;
}
static inline int _push_matrix(void) {
int err = 0;
    err = NATIVEFN_push_matrix();
    return err;
}
static inline int _pop_matrix(void) {
int err = 0;
    err = NATIVEFN_pop_matrix();
    return err;
}
static inline int _reset_matrix(void) {
int err = 0;
    err = NATIVEFN_reset_matrix();
    return err;
}
static inline int _translate(double delta_x, double delta_y) {
    (void)delta_x; (void)delta_y; int err = 0;
    err = NATIVEFN_translate(delta_x, delta_y);
    return err;
}
static inline int _rotate(double angle) {
    (void)angle; int err = 0;
    err = NATIVEFN_rotate(angle);
    return err;
}
static inline int _rotate_at(double angle, double x, double y) {
    (void)angle; (void)x; (void)y; int err = 0;
    err = NATIVEFN_rotate_at(angle, x, y);
    return err;
}
static inline int _scale(double scale_x, double scale_y) {
    (void)scale_x; (void)scale_y; int err = 0;
    err = NATIVEFN_scale(scale_x, scale_y);
    return err;
}
static inline int _scale_at(double scale_x, double scale_y, double x, double y) {
    (void)scale_x; (void)scale_y; (void)x; (void)y; int err = 0;
    err = NATIVEFN_scale_at(scale_x, scale_y, x, y);
    return err;
}
static inline int _set_default_blendmode(int blendmode) {
    (void)blendmode; int err = 0;
    err = NATIVEFN_set_default_blendmode(blendmode);
    return err;
}
static inline int _set_blendmode(int blendmode) {
    (void)blendmode; int err = 0;
    err = NATIVEFN_set_blendmode(blendmode);
    return err;
}
static inline int _reset_blendmode(void) {
int err = 0;
    err = NATIVEFN_reset_blendmode();
    return err;
}
static inline int _set_default_filtermode(int filtermode) {
    (void)filtermode; int err = 0;
    err = NATIVEFN_set_default_filtermode(filtermode);
    return err;
}
static inline int _set_filtermode(int filtermode) {
    (void)filtermode; int err = 0;
    err = NATIVEFN_set_filtermode(filtermode);
    return err;
}
static inline int _reset_filtermode(void) {
int err = 0;
    err = NATIVEFN_reset_filtermode();
    return err;
}
static inline int _shaderbuilder_cleanup(void *shaderbuilder) {
    (void)shaderbuilder; int err = 0;
    err = NATIVEFN_shaderbuilder_cleanup(shaderbuilder);
    return err;
}
static inline int _shaderbuilder_new(void **val) {
int err = 0;
    err = NATIVEFN_shaderbuilder_new(val);
    return err;
}
static inline int _shaderbuilder_uniform(void *shaderbuilder, const char *uniform_name, int uniform_type) {
    (void)shaderbuilder; (void)uniform_name; (void)uniform_type; int err = 0;
    err = NATIVEFN_shaderbuilder_uniform(shaderbuilder, uniform_name, uniform_type);
    return err;
}
static inline int _shaderbuilder_vertex(void *shaderbuilder, const char *vertex_code) {
    (void)shaderbuilder; (void)vertex_code; int err = 0;
    err = NATIVEFN_shaderbuilder_vertex(shaderbuilder, vertex_code);
    return err;
}
static inline int _shaderbuilder_fragment(void *shaderbuilder, const char *fragment_code) {
    (void)shaderbuilder; (void)fragment_code; int err = 0;
    err = NATIVEFN_shaderbuilder_fragment(shaderbuilder, fragment_code);
    return err;
}
static inline int _shaderbuilder_build(void *shaderbuilder, void **shader) {
    (void)shaderbuilder; int err = 0;
    err = NATIVEFN_shaderbuilder_build(shaderbuilder, shader);
    return err;
}
static inline int _shader_cleanup(void *shader) {
    (void)shader; int err = 0;
    err = NATIVEFN_shader_cleanup(shader);
    return err;
}
static inline int _shader_set(void *shader) {
    (void)shader; int err = 0;
    err = NATIVEFN_shader_set(shader);
    return err;
}
static inline int _reset_shader(void) {
int err = 0;
    err = NATIVEFN_reset_shader();
    return err;
}
static inline int _shader_set_uniform_float(void *shader, const char *uniform_name, float uniform_value) {
    (void)shader; (void)uniform_name; (void)uniform_value; int err = 0;
    err = NATIVEFN_shader_set_uniform_float(shader, uniform_name, uniform_value);
    return err;
}
static inline int _shader_set_uniform_floatvec4(void *shader, const char *uniform_name, float *uniform_value, size_t uniform_value_count) {
    (void)shader; (void)uniform_name; (void)uniform_value; (void)uniform_value_count; int err = 0;
    err = NATIVEFN_shader_set_uniform_floatvec4(shader, uniform_name, uniform_value, uniform_value_count);
    return err;
}
static inline int _shader_set_uniform_image(void *shader, const char *uniform_name, void *uniform_value) {
    (void)shader; (void)uniform_name; (void)uniform_value; int err = 0;
    err = NATIVEFN_shader_set_uniform_image(shader, uniform_name, uniform_value);
    return err;
}
static inline int _shader_reset_uniform(void *shader, const char *uniform_name) {
    (void)shader; (void)uniform_name; int err = 0;
    err = NATIVEFN_shader_reset_uniform(shader, uniform_name);
    return err;
}

// LOCAL ENUMS. Edit values to map from local names to actual native impl values
enum {
    _UNIFORMTYPE__INVALID = NATIVEENUM_UNIFORMTYPE__INVALID, /* order: 0 string: '_invalid' */
    _UNIFORMTYPE_FLOAT = NATIVEENUM_UNIFORMTYPE_FLOAT, /* order: 1 string: 'float' */
    _UNIFORMTYPE_VEC2 = NATIVEENUM_UNIFORMTYPE_VEC2, /* order: 2 string: 'vec2' */
    _UNIFORMTYPE_VEC3 = NATIVEENUM_UNIFORMTYPE_VEC3, /* order: 3 string: 'vec3' */
    _UNIFORMTYPE_VEC4 = NATIVEENUM_UNIFORMTYPE_VEC4, /* order: 4 string: 'vec4' */
    _UNIFORMTYPE_INT = NATIVEENUM_UNIFORMTYPE_INT, /* order: 5 string: 'int' */
    _UNIFORMTYPE_IVEC2 = NATIVEENUM_UNIFORMTYPE_IVEC2, /* order: 6 string: 'ivec2' */
    _UNIFORMTYPE_IVEC3 = NATIVEENUM_UNIFORMTYPE_IVEC3, /* order: 7 string: 'ivec3' */
    _UNIFORMTYPE_IVEC4 = NATIVEENUM_UNIFORMTYPE_IVEC4, /* order: 8 string: 'ivec4' */
    _UNIFORMTYPE_MAT4 = NATIVEENUM_UNIFORMTYPE_MAT4, /* order: 9 string: 'mat4' */
    _UNIFORMTYPE_SAMPLER2D = NATIVEENUM_UNIFORMTYPE_SAMPLER2D, /* order: 10 string: 'sampler2D' */
};
enum {
    _BLENDMODE_NONE = NATIVEENUM_BLENDMODE_NONE, /* order: 0 string: 'none' */
    _BLENDMODE_BLEND = NATIVEENUM_BLENDMODE_BLEND, /* order: 1 string: 'blend' */
    _BLENDMODE_ADD = NATIVEENUM_BLENDMODE_ADD, /* order: 2 string: 'add' */
    _BLENDMODE_MOD = NATIVEENUM_BLENDMODE_MOD, /* order: 3 string: 'mod' */
    _BLENDMODE_MUL = NATIVEENUM_BLENDMODE_MUL, /* order: 4 string: 'mul' */
};
enum {
    _FILTERMODE__INVALID = NATIVEENUM_FILTERMODE__INVALID, /* order: 0 string: '_invalid' */
    _FILTERMODE_NEAREST = NATIVEENUM_FILTERMODE_NEAREST, /* order: 1 string: 'nearest' */
    _FILTERMODE_LINEAR = NATIVEENUM_FILTERMODE_LINEAR, /* order: 2 string: 'linear' */
};
enum {
    _GAMEPADAXIS_LEFT_X = NATIVEENUM_GAMEPADAXIS_LEFT_X, /* order: 0 string: 'left_x' */
    _GAMEPADAXIS_LEFT_Y = NATIVEENUM_GAMEPADAXIS_LEFT_Y, /* order: 1 string: 'left_y' */
    _GAMEPADAXIS_RIGHT_X = NATIVEENUM_GAMEPADAXIS_RIGHT_X, /* order: 2 string: 'right_x' */
    _GAMEPADAXIS_RIGHT_Y = NATIVEENUM_GAMEPADAXIS_RIGHT_Y, /* order: 3 string: 'right_y' */
    _GAMEPADAXIS_LEFT_TRIGGER = NATIVEENUM_GAMEPADAXIS_LEFT_TRIGGER, /* order: 4 string: 'left_trigger' */
    _GAMEPADAXIS_RIGHT_TRIGGER = NATIVEENUM_GAMEPADAXIS_RIGHT_TRIGGER, /* order: 5 string: 'right_trigger' */
};
enum {
    _GAMEPADBUTTON_PAD_A = NATIVEENUM_GAMEPADBUTTON_PAD_A, /* order: 0 string: 'pad_a' */
    _GAMEPADBUTTON_PAD_B = NATIVEENUM_GAMEPADBUTTON_PAD_B, /* order: 1 string: 'pad_b' */
    _GAMEPADBUTTON_PAD_X = NATIVEENUM_GAMEPADBUTTON_PAD_X, /* order: 2 string: 'pad_x' */
    _GAMEPADBUTTON_PAD_Y = NATIVEENUM_GAMEPADBUTTON_PAD_Y, /* order: 3 string: 'pad_y' */
    _GAMEPADBUTTON_LEFT_BUMPER = NATIVEENUM_GAMEPADBUTTON_LEFT_BUMPER, /* order: 4 string: 'left_bumper' */
    _GAMEPADBUTTON_RIGHT_BUMPER = NATIVEENUM_GAMEPADBUTTON_RIGHT_BUMPER, /* order: 5 string: 'right_bumper' */
    _GAMEPADBUTTON_BACK = NATIVEENUM_GAMEPADBUTTON_BACK, /* order: 6 string: 'back' */
    _GAMEPADBUTTON_START = NATIVEENUM_GAMEPADBUTTON_START, /* order: 7 string: 'start' */
    _GAMEPADBUTTON_GUIDE = NATIVEENUM_GAMEPADBUTTON_GUIDE, /* order: 8 string: 'guide' */
    _GAMEPADBUTTON_LEFT_THUMB = NATIVEENUM_GAMEPADBUTTON_LEFT_THUMB, /* order: 9 string: 'left_thumb' */
    _GAMEPADBUTTON_RIGHT_THUMB = NATIVEENUM_GAMEPADBUTTON_RIGHT_THUMB, /* order: 10 string: 'right_thumb' */
    _GAMEPADBUTTON_DPAD_UP = NATIVEENUM_GAMEPADBUTTON_DPAD_UP, /* order: 11 string: 'dpad_up' */
    _GAMEPADBUTTON_DPAD_RIGHT = NATIVEENUM_GAMEPADBUTTON_DPAD_RIGHT, /* order: 12 string: 'dpad_right' */
    _GAMEPADBUTTON_DPAD_DOWN = NATIVEENUM_GAMEPADBUTTON_DPAD_DOWN, /* order: 13 string: 'dpad_down' */
    _GAMEPADBUTTON_DPAD_LEFT = NATIVEENUM_GAMEPADBUTTON_DPAD_LEFT, /* order: 14 string: 'dpad_left' */
};
enum {
    _MOUSEBUTTON_MB1 = NATIVEENUM_MOUSEBUTTON_MB1, /* order: 0 string: 'mb1' */
    _MOUSEBUTTON_MB2 = NATIVEENUM_MOUSEBUTTON_MB2, /* order: 1 string: 'mb2' */
    _MOUSEBUTTON_MB3 = NATIVEENUM_MOUSEBUTTON_MB3, /* order: 2 string: 'mb3' */
    _MOUSEBUTTON_MB4 = NATIVEENUM_MOUSEBUTTON_MB4, /* order: 3 string: 'mb4' */
    _MOUSEBUTTON_MB5 = NATIVEENUM_MOUSEBUTTON_MB5, /* order: 4 string: 'mb5' */
    _MOUSEBUTTON_MB6 = NATIVEENUM_MOUSEBUTTON_MB6, /* order: 5 string: 'mb6' */
    _MOUSEBUTTON_MB7 = NATIVEENUM_MOUSEBUTTON_MB7, /* order: 6 string: 'mb7' */
    _MOUSEBUTTON_MB8 = NATIVEENUM_MOUSEBUTTON_MB8, /* order: 7 string: 'mb8' */
};
enum {
    _KEYBOARDKEY_SPACE = NATIVEENUM_KEYBOARDKEY_SPACE, /* order: 0 string: 'space' */
    _KEYBOARDKEY_TICK = NATIVEENUM_KEYBOARDKEY_TICK, /* order: 1 string: ''' */
    _KEYBOARDKEY_COMMA = NATIVEENUM_KEYBOARDKEY_COMMA, /* order: 2 string: ',' */
    _KEYBOARDKEY_DASH = NATIVEENUM_KEYBOARDKEY_DASH, /* order: 3 string: '-' */
    _KEYBOARDKEY_PERIOD = NATIVEENUM_KEYBOARDKEY_PERIOD, /* order: 4 string: '.' */
    _KEYBOARDKEY_SLASH = NATIVEENUM_KEYBOARDKEY_SLASH, /* order: 5 string: '/' */
    _KEYBOARDKEY_0 = NATIVEENUM_KEYBOARDKEY_0, /* order: 6 string: '0' */
    _KEYBOARDKEY_1 = NATIVEENUM_KEYBOARDKEY_1, /* order: 7 string: '1' */
    _KEYBOARDKEY_2 = NATIVEENUM_KEYBOARDKEY_2, /* order: 8 string: '2' */
    _KEYBOARDKEY_3 = NATIVEENUM_KEYBOARDKEY_3, /* order: 9 string: '3' */
    _KEYBOARDKEY_4 = NATIVEENUM_KEYBOARDKEY_4, /* order: 10 string: '4' */
    _KEYBOARDKEY_5 = NATIVEENUM_KEYBOARDKEY_5, /* order: 11 string: '5' */
    _KEYBOARDKEY_6 = NATIVEENUM_KEYBOARDKEY_6, /* order: 12 string: '6' */
    _KEYBOARDKEY_7 = NATIVEENUM_KEYBOARDKEY_7, /* order: 13 string: '7' */
    _KEYBOARDKEY_8 = NATIVEENUM_KEYBOARDKEY_8, /* order: 14 string: '8' */
    _KEYBOARDKEY_9 = NATIVEENUM_KEYBOARDKEY_9, /* order: 15 string: '9' */
    _KEYBOARDKEY_SEMICOLON = NATIVEENUM_KEYBOARDKEY_SEMICOLON, /* order: 16 string: ';' */
    _KEYBOARDKEY_EQUAL = NATIVEENUM_KEYBOARDKEY_EQUAL, /* order: 17 string: '=' */
    _KEYBOARDKEY_A = NATIVEENUM_KEYBOARDKEY_A, /* order: 18 string: 'a' */
    _KEYBOARDKEY_B = NATIVEENUM_KEYBOARDKEY_B, /* order: 19 string: 'b' */
    _KEYBOARDKEY_C = NATIVEENUM_KEYBOARDKEY_C, /* order: 20 string: 'c' */
    _KEYBOARDKEY_D = NATIVEENUM_KEYBOARDKEY_D, /* order: 21 string: 'd' */
    _KEYBOARDKEY_E = NATIVEENUM_KEYBOARDKEY_E, /* order: 22 string: 'e' */
    _KEYBOARDKEY_F = NATIVEENUM_KEYBOARDKEY_F, /* order: 23 string: 'f' */
    _KEYBOARDKEY_G = NATIVEENUM_KEYBOARDKEY_G, /* order: 24 string: 'g' */
    _KEYBOARDKEY_H = NATIVEENUM_KEYBOARDKEY_H, /* order: 25 string: 'h' */
    _KEYBOARDKEY_I = NATIVEENUM_KEYBOARDKEY_I, /* order: 26 string: 'i' */
    _KEYBOARDKEY_J = NATIVEENUM_KEYBOARDKEY_J, /* order: 27 string: 'j' */
    _KEYBOARDKEY_K = NATIVEENUM_KEYBOARDKEY_K, /* order: 28 string: 'k' */
    _KEYBOARDKEY_L = NATIVEENUM_KEYBOARDKEY_L, /* order: 29 string: 'l' */
    _KEYBOARDKEY_M = NATIVEENUM_KEYBOARDKEY_M, /* order: 30 string: 'm' */
    _KEYBOARDKEY_N = NATIVEENUM_KEYBOARDKEY_N, /* order: 31 string: 'n' */
    _KEYBOARDKEY_O = NATIVEENUM_KEYBOARDKEY_O, /* order: 32 string: 'o' */
    _KEYBOARDKEY_P = NATIVEENUM_KEYBOARDKEY_P, /* order: 33 string: 'p' */
    _KEYBOARDKEY_Q = NATIVEENUM_KEYBOARDKEY_Q, /* order: 34 string: 'q' */
    _KEYBOARDKEY_R = NATIVEENUM_KEYBOARDKEY_R, /* order: 35 string: 'r' */
    _KEYBOARDKEY_S = NATIVEENUM_KEYBOARDKEY_S, /* order: 36 string: 's' */
    _KEYBOARDKEY_T = NATIVEENUM_KEYBOARDKEY_T, /* order: 37 string: 't' */
    _KEYBOARDKEY_U = NATIVEENUM_KEYBOARDKEY_U, /* order: 38 string: 'u' */
    _KEYBOARDKEY_V = NATIVEENUM_KEYBOARDKEY_V, /* order: 39 string: 'v' */
    _KEYBOARDKEY_W = NATIVEENUM_KEYBOARDKEY_W, /* order: 40 string: 'w' */
    _KEYBOARDKEY_X = NATIVEENUM_KEYBOARDKEY_X, /* order: 41 string: 'x' */
    _KEYBOARDKEY_Y = NATIVEENUM_KEYBOARDKEY_Y, /* order: 42 string: 'y' */
    _KEYBOARDKEY_Z = NATIVEENUM_KEYBOARDKEY_Z, /* order: 43 string: 'z' */
    _KEYBOARDKEY_OPEN_BRACKET = NATIVEENUM_KEYBOARDKEY_OPEN_BRACKET, /* order: 44 string: '[' */
    _KEYBOARDKEY_BACKSLASH = NATIVEENUM_KEYBOARDKEY_BACKSLASH, /* order: 45 string: '\' */
    _KEYBOARDKEY_CLOSE_BRACKET = NATIVEENUM_KEYBOARDKEY_CLOSE_BRACKET, /* order: 46 string: ']' */
    _KEYBOARDKEY_BACKTICK = NATIVEENUM_KEYBOARDKEY_BACKTICK, /* order: 47 string: '`' */
    _KEYBOARDKEY_WORLD_1 = NATIVEENUM_KEYBOARDKEY_WORLD_1, /* order: 48 string: 'world_1' */
    _KEYBOARDKEY_WORLD_2 = NATIVEENUM_KEYBOARDKEY_WORLD_2, /* order: 49 string: 'world_2' */
    _KEYBOARDKEY_ESCAPE = NATIVEENUM_KEYBOARDKEY_ESCAPE, /* order: 50 string: 'escape' */
    _KEYBOARDKEY_ENTER = NATIVEENUM_KEYBOARDKEY_ENTER, /* order: 51 string: 'enter' */
    _KEYBOARDKEY_TAB = NATIVEENUM_KEYBOARDKEY_TAB, /* order: 52 string: 'tab' */
    _KEYBOARDKEY_BACKSPACE = NATIVEENUM_KEYBOARDKEY_BACKSPACE, /* order: 53 string: 'backspace' */
    _KEYBOARDKEY_INSERT = NATIVEENUM_KEYBOARDKEY_INSERT, /* order: 54 string: 'insert' */
    _KEYBOARDKEY_DELETE = NATIVEENUM_KEYBOARDKEY_DELETE, /* order: 55 string: 'delete' */
    _KEYBOARDKEY_RIGHT = NATIVEENUM_KEYBOARDKEY_RIGHT, /* order: 56 string: 'right' */
    _KEYBOARDKEY_LEFT = NATIVEENUM_KEYBOARDKEY_LEFT, /* order: 57 string: 'left' */
    _KEYBOARDKEY_DOWN = NATIVEENUM_KEYBOARDKEY_DOWN, /* order: 58 string: 'down' */
    _KEYBOARDKEY_UP = NATIVEENUM_KEYBOARDKEY_UP, /* order: 59 string: 'up' */
    _KEYBOARDKEY_PAGE_UP = NATIVEENUM_KEYBOARDKEY_PAGE_UP, /* order: 60 string: 'page_up' */
    _KEYBOARDKEY_PAGE_DOWN = NATIVEENUM_KEYBOARDKEY_PAGE_DOWN, /* order: 61 string: 'page_down' */
    _KEYBOARDKEY_HOME = NATIVEENUM_KEYBOARDKEY_HOME, /* order: 62 string: 'home' */
    _KEYBOARDKEY_END = NATIVEENUM_KEYBOARDKEY_END, /* order: 63 string: 'end' */
    _KEYBOARDKEY_CAPS_LOCK = NATIVEENUM_KEYBOARDKEY_CAPS_LOCK, /* order: 64 string: 'caps_lock' */
    _KEYBOARDKEY_SCROLL_LOCK = NATIVEENUM_KEYBOARDKEY_SCROLL_LOCK, /* order: 65 string: 'scroll_lock' */
    _KEYBOARDKEY_NUM_LOCK = NATIVEENUM_KEYBOARDKEY_NUM_LOCK, /* order: 66 string: 'num_lock' */
    _KEYBOARDKEY_PRINT_SCREEN = NATIVEENUM_KEYBOARDKEY_PRINT_SCREEN, /* order: 67 string: 'print_screen' */
    _KEYBOARDKEY_PAUSE = NATIVEENUM_KEYBOARDKEY_PAUSE, /* order: 68 string: 'pause' */
    _KEYBOARDKEY_F1 = NATIVEENUM_KEYBOARDKEY_F1, /* order: 69 string: 'f1' */
    _KEYBOARDKEY_F2 = NATIVEENUM_KEYBOARDKEY_F2, /* order: 70 string: 'f2' */
    _KEYBOARDKEY_F3 = NATIVEENUM_KEYBOARDKEY_F3, /* order: 71 string: 'f3' */
    _KEYBOARDKEY_F4 = NATIVEENUM_KEYBOARDKEY_F4, /* order: 72 string: 'f4' */
    _KEYBOARDKEY_F5 = NATIVEENUM_KEYBOARDKEY_F5, /* order: 73 string: 'f5' */
    _KEYBOARDKEY_F6 = NATIVEENUM_KEYBOARDKEY_F6, /* order: 74 string: 'f6' */
    _KEYBOARDKEY_F7 = NATIVEENUM_KEYBOARDKEY_F7, /* order: 75 string: 'f7' */
    _KEYBOARDKEY_F8 = NATIVEENUM_KEYBOARDKEY_F8, /* order: 76 string: 'f8' */
    _KEYBOARDKEY_F9 = NATIVEENUM_KEYBOARDKEY_F9, /* order: 77 string: 'f9' */
    _KEYBOARDKEY_F10 = NATIVEENUM_KEYBOARDKEY_F10, /* order: 78 string: 'f10' */
    _KEYBOARDKEY_F11 = NATIVEENUM_KEYBOARDKEY_F11, /* order: 79 string: 'f11' */
    _KEYBOARDKEY_F12 = NATIVEENUM_KEYBOARDKEY_F12, /* order: 80 string: 'f12' */
    _KEYBOARDKEY_F13 = NATIVEENUM_KEYBOARDKEY_F13, /* order: 81 string: 'f13' */
    _KEYBOARDKEY_F14 = NATIVEENUM_KEYBOARDKEY_F14, /* order: 82 string: 'f14' */
    _KEYBOARDKEY_F15 = NATIVEENUM_KEYBOARDKEY_F15, /* order: 83 string: 'f15' */
    _KEYBOARDKEY_F16 = NATIVEENUM_KEYBOARDKEY_F16, /* order: 84 string: 'f16' */
    _KEYBOARDKEY_F17 = NATIVEENUM_KEYBOARDKEY_F17, /* order: 85 string: 'f17' */
    _KEYBOARDKEY_F18 = NATIVEENUM_KEYBOARDKEY_F18, /* order: 86 string: 'f18' */
    _KEYBOARDKEY_F19 = NATIVEENUM_KEYBOARDKEY_F19, /* order: 87 string: 'f19' */
    _KEYBOARDKEY_F20 = NATIVEENUM_KEYBOARDKEY_F20, /* order: 88 string: 'f20' */
    _KEYBOARDKEY_F21 = NATIVEENUM_KEYBOARDKEY_F21, /* order: 89 string: 'f21' */
    _KEYBOARDKEY_F22 = NATIVEENUM_KEYBOARDKEY_F22, /* order: 90 string: 'f22' */
    _KEYBOARDKEY_F23 = NATIVEENUM_KEYBOARDKEY_F23, /* order: 91 string: 'f23' */
    _KEYBOARDKEY_F24 = NATIVEENUM_KEYBOARDKEY_F24, /* order: 92 string: 'f24' */
    _KEYBOARDKEY_F25 = NATIVEENUM_KEYBOARDKEY_F25, /* order: 93 string: 'f25' */
    _KEYBOARDKEY_KP_0 = NATIVEENUM_KEYBOARDKEY_KP_0, /* order: 94 string: 'kp_0' */
    _KEYBOARDKEY_KP_1 = NATIVEENUM_KEYBOARDKEY_KP_1, /* order: 95 string: 'kp_1' */
    _KEYBOARDKEY_KP_2 = NATIVEENUM_KEYBOARDKEY_KP_2, /* order: 96 string: 'kp_2' */
    _KEYBOARDKEY_KP_3 = NATIVEENUM_KEYBOARDKEY_KP_3, /* order: 97 string: 'kp_3' */
    _KEYBOARDKEY_KP_4 = NATIVEENUM_KEYBOARDKEY_KP_4, /* order: 98 string: 'kp_4' */
    _KEYBOARDKEY_KP_5 = NATIVEENUM_KEYBOARDKEY_KP_5, /* order: 99 string: 'kp_5' */
    _KEYBOARDKEY_KP_6 = NATIVEENUM_KEYBOARDKEY_KP_6, /* order: 100 string: 'kp_6' */
    _KEYBOARDKEY_KP_7 = NATIVEENUM_KEYBOARDKEY_KP_7, /* order: 101 string: 'kp_7' */
    _KEYBOARDKEY_KP_8 = NATIVEENUM_KEYBOARDKEY_KP_8, /* order: 102 string: 'kp_8' */
    _KEYBOARDKEY_KP_9 = NATIVEENUM_KEYBOARDKEY_KP_9, /* order: 103 string: 'kp_9' */
    _KEYBOARDKEY_KP_DECIMAL = NATIVEENUM_KEYBOARDKEY_KP_DECIMAL, /* order: 104 string: 'kp_decimal' */
    _KEYBOARDKEY_KP_DIVIDE = NATIVEENUM_KEYBOARDKEY_KP_DIVIDE, /* order: 105 string: 'kp_divide' */
    _KEYBOARDKEY_KP_MULTIPLY = NATIVEENUM_KEYBOARDKEY_KP_MULTIPLY, /* order: 106 string: 'kp_multiply' */
    _KEYBOARDKEY_KP_SUBTRACT = NATIVEENUM_KEYBOARDKEY_KP_SUBTRACT, /* order: 107 string: 'kp_subtract' */
    _KEYBOARDKEY_KP_ADD = NATIVEENUM_KEYBOARDKEY_KP_ADD, /* order: 108 string: 'kp_add' */
    _KEYBOARDKEY_KP_ENTER = NATIVEENUM_KEYBOARDKEY_KP_ENTER, /* order: 109 string: 'kp_enter' */
    _KEYBOARDKEY_KP_EQUAL = NATIVEENUM_KEYBOARDKEY_KP_EQUAL, /* order: 110 string: 'kp_equal' */
    _KEYBOARDKEY_LEFT_SHIFT = NATIVEENUM_KEYBOARDKEY_LEFT_SHIFT, /* order: 111 string: 'left_shift' */
    _KEYBOARDKEY_LEFT_CONTROL = NATIVEENUM_KEYBOARDKEY_LEFT_CONTROL, /* order: 112 string: 'left_control' */
    _KEYBOARDKEY_LEFT_ALT = NATIVEENUM_KEYBOARDKEY_LEFT_ALT, /* order: 113 string: 'left_alt' */
    _KEYBOARDKEY_LEFT_SUPER = NATIVEENUM_KEYBOARDKEY_LEFT_SUPER, /* order: 114 string: 'left_super' */
    _KEYBOARDKEY_RIGHT_SHIFT = NATIVEENUM_KEYBOARDKEY_RIGHT_SHIFT, /* order: 115 string: 'right_shift' */
    _KEYBOARDKEY_RIGHT_CONTROL = NATIVEENUM_KEYBOARDKEY_RIGHT_CONTROL, /* order: 116 string: 'right_control' */
    _KEYBOARDKEY_RIGHT_ALT = NATIVEENUM_KEYBOARDKEY_RIGHT_ALT, /* order: 117 string: 'right_alt' */
    _KEYBOARDKEY_RIGHT_SUPER = NATIVEENUM_KEYBOARDKEY_RIGHT_SUPER, /* order: 118 string: 'right_super' */
    _KEYBOARDKEY_MENU = NATIVEENUM_KEYBOARDKEY_MENU, /* order: 119 string: 'menu' */
};

// ==== end: api_lyte_core.impl.c ====
#endif // _API_LYTE_CORE_IMPL_C_INCLUDED_
