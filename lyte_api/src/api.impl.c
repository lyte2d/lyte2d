// GENERATED
// (c) 2023 MG

// implementations: fill in the functions
// do not directly compile (i.e. add to list of C files to compile)
// this file is directly included in the API implementation and inlined

#include <stdbool.h>
#include <stdint.h>

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>
#include <assert.h>

#include "api_generated.h"

// EDITED WITH IMPLEMENTATION CALLS

#include "lyte_api.h"
#include "lyte_core.h"


static inline int _impl_ctor_load_image(const char * image_path, lyte_Image *val) {
    (void)image_path;(void)val;
    int _ret = 0;
    _ret = lyte_load_image(image_path, val);
    return _ret;
}
static inline int _impl_ctor_new_canvas(int width, int height, lyte_Image *val) {
    (void)width;(void)height;(void)val;
    int _ret = 0;
    _ret = lyte_new_canvas(width, height, val);
    return _ret;
}
static inline int _impl_ctor_load_font(const char * font_path, double size, lyte_Font *val) {
    (void)font_path;(void)size;(void)val;
    int _ret = 0;
    _ret = lyte_load_font(font_path, size, val);
    return _ret;
}
static inline int _impl_ctor_load_music(const char * music_path, lyte_Music *val) {
    (void)music_path;(void)val;
    int _ret = 0;
    _ret = lyte_load_music(music_path, val);
    return _ret;
}
static inline int _impl_ctor_load_sound(const char * sound_path, lyte_Sound *val) {
    (void)sound_path;(void)val;
    int _ret = 0;
    _ret = lyte_load_sound(sound_path, val);
    return _ret;
}
static inline int _impl_ctor_clone_sound(lyte_Sound orig, lyte_Sound *val) {
    (void)orig;(void)val;
    int _ret = 0;
    _ret = lyte_clone_sound(orig, val);
    return _ret;
}
static inline int _impl_ctor_new_shaderbuilder(lyte_ShaderBuilder *val) {
    (void)val;
    int _ret = 0;
    _ret = lyte_new_shaderbuilder(val);
    return _ret;
}
static inline int _impl_ctor_shaderbuilder_build(lyte_ShaderBuilder shaderbuilder, lyte_Shader *shader) {
    (void)shaderbuilder;(void)shader;
    int _ret = 0;
    _ret = lyte_shaderbuilder_build(shaderbuilder, shader);
    return _ret;
}
static inline int _impl_cleanup_lyte_Image(lyte_Image *image) {
    (void)image;
    int _ret = 0;
    _ret = lyte_cleanup_image(*image);
    return _ret;
}
static inline int _impl_cleanup_lyte_Font(lyte_Font *font) {
    (void)font;
    int _ret = 0;
    _ret = lyte_cleanup_font(*font);
    return _ret;
}
static inline int _impl_cleanup_lyte_Music(lyte_Music *music) {
    (void)music;
    int _ret = 0;
    _ret = lyte_cleanup_music(*music);
    return _ret;
}
static inline int _impl_cleanup_lyte_Sound(lyte_Sound *sound) {
    (void)sound;
    int _ret = 0;
    _ret = lyte_cleanup_sound(*sound);
    return _ret;
}
static inline int _impl_cleanup_lyte_Shader(lyte_Shader *shader) {
    (void)shader;
    int _ret = 0;
    _ret = lyte_cleanup_shader(*shader);
    return _ret;
}
static inline int _impl_cleanup_lyte_ShaderBuilder(lyte_ShaderBuilder *shaderbuilder) {
    (void)shaderbuilder;
    int _ret = 0;
    _ret = lyte_cleanup_shaderbuilder(*shaderbuilder);
    return _ret;
}
static inline const char *_impl_tostring_lyte_Image(lyte_Image *image) {
    (void)image;
    char *_ret = "[lyte.Image]";
    // _ret = lyte_image_tostring(image)
    return (const char *)_ret;
}
static inline const char *_impl_tostring_lyte_Font(lyte_Font *font) {
    (void)font;
    char *_ret = "[lyte.Font]";
    // _ret = lyte_font_tostring(font)
    return (const char *)_ret;
}
static inline const char *_impl_tostring_lyte_Music(lyte_Music *music) {
    (void)music;
    char *_ret = "[lyte.Music]";
    // _ret = lyte_music_tostring(music)
    return (const char *)_ret;
}
static inline const char *_impl_tostring_lyte_Sound(lyte_Sound *sound) {
    (void)sound;
    char *_ret = "[lyte.Sound]";
    // _ret = lyte_sound_tostring(sound)
    return (const char *)_ret;
}
static inline const char *_impl_tostring_lyte_Shader(lyte_Shader *shader) {
    (void)shader;
    char *_ret = "[lyte.Shader]";
    // _ret = lyte_shader_tostring(shader)
    return (const char *)_ret;
}
static inline const char *_impl_tostring_lyte_ShaderBuilder(lyte_ShaderBuilder *shaderbuilder) {
    (void)shaderbuilder;
    char *_ret = "[lyte.ShaderBuilder]";
    // _ret = lyte_shaderbuilder_tostring(shaderbuilder)
    return (const char *)_ret;
}
static inline int _impl_quit(void) {
    int _ret = 0;
    _ret = lyte_quit();
    return _ret;
}
static inline int _impl_cls(double r, double g, double b, double a) {
    (void)r;(void)g;(void)b;(void)a;
    int _ret = 0;
    _ret = lyte_cls(r, g, b, a);
    return _ret;
}
static inline int _impl_set_color(double r, double g, double b, double a) {
    (void)r;(void)g;(void)b;(void)a;
    int _ret = 0;
    _ret = lyte_set_color(r, g, b, a);
    return _ret;
}
static inline int _impl_reset_color(void) {
    int _ret = 0;
    _ret = lyte_reset_color();
    return _ret;
}
static inline int _impl_draw_point(int x, int y) {
    (void)x;(void)y;
    int _ret = 0;
    _ret = lyte_draw_point(x, y);
    return _ret;
}
static inline int _impl_draw_line(int x1, int y1, int x2, int y2) {
    (void)x1;(void)y1;(void)x2;(void)y2;
    int _ret = 0;
    _ret = lyte_draw_line(x1, y1, x2, y2);
    return _ret;
}
static inline int _impl_draw_rect(int dest_x, int dest_y, int rect_width, int rect_height) {
    (void)dest_x;(void)dest_y;(void)rect_width;(void)rect_height;
    int _ret = 0;
    _ret = lyte_draw_rect(dest_x, dest_y, rect_width, rect_height);
    return _ret;
}
static inline int _impl_draw_rect_line(int dest_x, int dest_y, int rect_width, int rect_height) {
    (void)dest_x;(void)dest_y;(void)rect_width;(void)rect_height;
    int _ret = 0;
    _ret = lyte_draw_rect_line(dest_x, dest_y, rect_width, rect_height);
    return _ret;
}
static inline int _impl_draw_circle(int dest_x, int dest_y, int radius) {
    (void)dest_x;(void)dest_y;(void)radius;
    int _ret = 0;
    _ret = lyte_draw_circle(dest_x, dest_y, radius);
    return _ret;
}
static inline int _impl_draw_circle_line(int dest_x, int dest_y, int radius) {
    (void)dest_x;(void)dest_y;(void)radius;
    int _ret = 0;
    _ret = lyte_draw_circle_line(dest_x, dest_y, radius);
    return _ret;
}
static inline int _impl_draw_image(lyte_Image image, int dest_x, int dest_y) {
    (void)image;(void)dest_x;(void)dest_y;
    int _ret = 0;
    _ret = lyte_draw_image(image, dest_x, dest_y);
    return _ret;
}
static inline int _impl_draw_image_rect(lyte_Image image, int dest_x, int dest_y, int src_x, int src_y, int rect_width, int rect_height) {
    (void)image;(void)dest_x;(void)dest_y;(void)src_x;(void)src_y;(void)rect_width;(void)rect_height;
    int _ret = 0;
    _ret = lyte_draw_image_rect(image, dest_x, dest_y, src_x, src_y, rect_width, rect_height);
    return _ret;
}
static inline int _impl_get_image_width(lyte_Image image, int *val) {
    (void)image;(void)val;
    int _ret = 0;
    _ret = lyte_get_image_width(image, val);
    return _ret;
}
static inline int _impl_get_image_height(lyte_Image image, int *val) {
    (void)image;(void)val;
    int _ret = 0;
    _ret = lyte_get_image_height(image, val);
    return _ret;
}
static inline int _impl_set_canvas(lyte_Image canvas_image) {
    (void)canvas_image;
    int _ret = 0;
    _ret = lyte_set_canvas(canvas_image);
    return _ret;
}
static inline int _impl_reset_canvas(void) {
    int _ret = 0;
    _ret = lyte_reset_canvas();
    return _ret;
}
static inline int _impl_is_image_canvas(lyte_Image image, bool *val) {
    (void)image;(void)val;
    int _ret = 0;
    _ret = lyte_is_image_canvas(image, val);
    return _ret;
}
static inline int _impl_set_font(lyte_Font font) {
    (void)font;
    int _ret = 0;
    _ret = lyte_set_font(font);
    return _ret;
}
static inline int _impl_draw_text(const char * text, int dest_x, int dest_y) {
    (void)text;(void)dest_x;(void)dest_y;
    int _ret = 0;
    _ret = lyte_draw_text(text, dest_x, dest_y);
    return _ret;
}
static inline int _impl_get_text_width(const char * text, int *val) {
    (void)text;(void)val;
    int _ret = 0;
    _ret = lyte_get_text_width(text, val);
    return _ret;
}
static inline int _impl_get_text_height(const char * text, int *val) {
    (void)text;(void)val;
    int _ret = 0;
    _ret = lyte_get_text_height(text, val);
    return _ret;
}
static inline int _impl_set_window_minsize(int width, int height) {
    (void)width;(void)height;
    int _ret = 0;
    _ret = lyte_set_window_minsize(width, height);
    return _ret;
}
static inline int _impl_set_window_size(int width, int height) {
    (void)width;(void)height;
    int _ret = 0;
    _ret = lyte_set_window_size(width, height);
    return _ret;
}
static inline int _impl_get_window_width(int *val) {
    (void)val;
    int _ret = 0;
    _ret = lyte_get_window_width(val);
    return _ret;
}
static inline int _impl_get_window_height(int *val) {
    (void)val;
    int _ret = 0;
    _ret = lyte_get_window_height(val);
    return _ret;
}
static inline int _impl_set_fullscreen(bool fullscreen) {
    (void)fullscreen;
    int _ret = 0;
    _ret = lyte_set_fullscreen(fullscreen);
    return _ret;
}
static inline int _impl_is_fullscreen(bool *val) {
    (void)val;
    int _ret = 0;
    _ret = lyte_is_fullscreen(val);
    return _ret;
}
static inline int _impl_set_window_title(const char * title) {
    (void)title;
    int _ret = 0;
    _ret = lyte_set_window_title(title);
    return _ret;
}
static inline int _impl_set_window_vsync(bool vsync) {
    (void)vsync;
    int _ret = 0;
    _ret = lyte_set_window_vsync(vsync);
    return _ret;
}
static inline int _impl_is_window_vsync(bool *val) {
    (void)val;
    int _ret = 0;
    _ret = lyte_is_window_vsync(val);
    return _ret;
}
static inline int _impl_set_window_icon_file(const char * icon_path) {
    (void)icon_path;
    int _ret = 0;
    _ret = lyte_set_window_icon_file(icon_path);
    return _ret;
}
static inline int _impl_set_window_margins(int left, int right, int top, int bottom) {
    (void)left;(void)right;(void)top;(void)bottom;
    int _ret = 0;
    _ret = lyte_set_window_margins(left, right, top, bottom);
    return _ret;
}
static inline int _impl_set_window_paddings(int left, int right, int top, int bottom) {
    (void)left;(void)right;(void)top;(void)bottom;
    int _ret = 0;
    _ret = lyte_set_window_paddings(left, right, top, bottom);
    return _ret;
}
static inline int _impl_is_key_down(lyte_KeyboardKey key, bool *val) {
    (void)key;(void)val;
    int _ret = 0;
    _ret = lyte_is_key_down(key, val);
    return _ret;
}
static inline int _impl_is_key_pressed(lyte_KeyboardKey key, bool *val) {
    (void)key;(void)val;
    int _ret = 0;
    _ret = lyte_is_key_pressed(key, val);
    return _ret;
}
static inline int _impl_is_key_released(lyte_KeyboardKey key, bool *val) {
    (void)key;(void)val;
    int _ret = 0;
    _ret = lyte_is_key_released(key, val);
    return _ret;
}
static inline int _impl_is_key_repeat(lyte_KeyboardKey key, bool *val) {
    (void)key;(void)val;
    int _ret = 0;
    _ret = lyte_is_key_repeat(key, val);
    return _ret;
}
static inline int _impl_is_mouse_down(lyte_MouseButton mouse_button, bool *val) {
    (void)mouse_button;(void)val;
    int _ret = 0;
    _ret = lyte_is_mouse_down(mouse_button, val);
    return _ret;
}
static inline int _impl_is_mouse_pressed(lyte_MouseButton mouse_button, bool *val) {
    (void)mouse_button;(void)val;
    int _ret = 0;
    _ret = lyte_is_mouse_pressed(mouse_button, val);
    return _ret;
}
static inline int _impl_is_mouse_released(lyte_MouseButton mouse_button, bool *val) {
    (void)mouse_button;(void)val;
    int _ret = 0;
    _ret = lyte_is_mouse_released(mouse_button, val);
    return _ret;
}
static inline int _impl_get_mouse_x(int *val) {
    (void)val;
    int _ret = 0;
    _ret = lyte_get_mouse_x(val);
    return _ret;
}
static inline int _impl_get_mouse_y(int *val) {
    (void)val;
    int _ret = 0;
    _ret = lyte_get_mouse_y(val);
    return _ret;
}
static inline int _impl_get_gamepad_count(int *val) {
    (void)val;
    int _ret = 0;
    _ret = lyte_get_gamepad_count(val);
    return _ret;
}
static inline int _impl_get_gamepad_name(int index, const char * *val) {
    (void)index;(void)val;
    int _ret = 0;
    _ret = lyte_get_gamepad_name(index, val);
    return _ret;
}
static inline int _impl_is_gamepad_down(int index, lyte_GamepadButton gamepad_button, bool *val) {
    (void)index;(void)gamepad_button;(void)val;
    int _ret = 0;
    _ret = lyte_is_gamepad_down(index, gamepad_button, val);
    return _ret;
}
static inline int _impl_is_gamepad_pressed(int index, lyte_GamepadButton gamepad_button, bool *val) {
    (void)index;(void)gamepad_button;(void)val;
    int _ret = 0;
    _ret = lyte_is_gamepad_pressed(index, gamepad_button, val);
    return _ret;
}
static inline int _impl_is_gamepad_released(int index, lyte_GamepadButton gamepad_button, bool *val) {
    (void)index;(void)gamepad_button;(void)val;
    int _ret = 0;
    _ret = lyte_is_gamepad_released(index, gamepad_button, val);
    return _ret;
}
static inline int _impl_get_gamepad_axis(int index, lyte_GamepadAxis gamepad_axis, double *val) {
    (void)index;(void)gamepad_axis;(void)val;
    int _ret = 0;
    _ret = lyte_get_gamepad_axis(index, gamepad_axis, val);
    return _ret;
}
static inline int _impl_set_mastervolume(double mastervolume) {
    (void)mastervolume;
    int _ret = 0;
    _ret = lyte_set_mastervolume(mastervolume);
    return _ret;
}
static inline int _impl_get_mastervolume(double *val) {
    (void)val;
    int _ret = 0;
    _ret = lyte_get_mastervolume(val);
    return _ret;
}
static inline int _impl_play_music(lyte_Music music) {
    (void)music;
    int _ret = 0;
    _ret = lyte_play_music(music);
    return _ret;
}
static inline int _impl_pause_music(lyte_Music music) {
    (void)music;
    int _ret = 0;
    _ret = lyte_pause_music(music);
    return _ret;
}
static inline int _impl_resume_music(lyte_Music music) {
    (void)music;
    int _ret = 0;
    _ret = lyte_resume_music(music);
    return _ret;
}
static inline int _impl_stop_music(lyte_Music music) {
    (void)music;
    int _ret = 0;
    _ret = lyte_stop_music(music);
    return _ret;
}
static inline int _impl_is_music_playing(lyte_Music music, bool *val) {
    (void)music;(void)val;
    int _ret = 0;
    _ret = lyte_is_music_playing(music, val);
    return _ret;
}
static inline int _impl_get_music_length(lyte_Music music, double *val) {
    (void)music;(void)val;
    int _ret = 0;
    _ret = lyte_get_music_length(music, val);
    return _ret;
}
static inline int _impl_get_music_length_played(lyte_Music music, double *val) {
    (void)music;(void)val;
    int _ret = 0;
    _ret = lyte_get_music_length_played(music, val);
    return _ret;
}
static inline int _impl_seek_music(lyte_Music music, double secs) {
    (void)music;(void)secs;
    int _ret = 0;
    _ret = lyte_seek_music(music, secs);
    return _ret;
}
static inline int _impl_set_music_volume(lyte_Music music, double volume) {
    (void)music;(void)volume;
    int _ret = 0;
    _ret = lyte_set_music_volume(music, volume);
    return _ret;
}
static inline int _impl_set_music_pan(lyte_Music music, double pan) {
    (void)music;(void)pan;
    int _ret = 0;
    _ret = lyte_set_music_pan(music, pan);
    return _ret;
}
static inline int _impl_set_music_pitch(lyte_Music music, double pitch) {
    (void)music;(void)pitch;
    int _ret = 0;
    _ret = lyte_set_music_pitch(music, pitch);
    return _ret;
}
static inline int _impl_get_music_volume(lyte_Music music, double *val) {
    (void)music;(void)val;
    int _ret = 0;
    _ret = lyte_get_music_volume(music, val);
    return _ret;
}
static inline int _impl_get_music_pan(lyte_Music music, double *val) {
    (void)music;(void)val;
    int _ret = 0;
    _ret = lyte_get_music_pan(music, val);
    return _ret;
}
static inline int _impl_get_music_pitch(lyte_Music music, double *val) {
    (void)music;(void)val;
    int _ret = 0;
    _ret = lyte_get_music_pitch(music, val);
    return _ret;
}
static inline int _impl_play_sound(lyte_Sound sound) {
    (void)sound;
    int _ret = 0;
    _ret = lyte_play_sound(sound);
    return _ret;
}
static inline int _impl_pause_sound(lyte_Sound sound) {
    (void)sound;
    int _ret = 0;
    _ret = lyte_pause_sound(sound);
    return _ret;
}
static inline int _impl_resume_sound(lyte_Sound sound) {
    (void)sound;
    int _ret = 0;
    _ret = lyte_resume_sound(sound);
    return _ret;
}
static inline int _impl_stop_sound(lyte_Sound sound) {
    (void)sound;
    int _ret = 0;
    _ret = lyte_stop_sound(sound);
    return _ret;
}
static inline int _impl_is_sound_playing(lyte_Sound sound, bool *val) {
    (void)sound;(void)val;
    int _ret = 0;
    _ret = lyte_is_sound_playing(sound, val);
    return _ret;
}
static inline int _impl_set_sound_volume(lyte_Sound sound, double volume) {
    (void)sound;(void)volume;
    int _ret = 0;
    _ret = lyte_set_sound_volume(sound, volume);
    return _ret;
}
static inline int _impl_set_sound_pan(lyte_Sound sound, double pan) {
    (void)sound;(void)pan;
    int _ret = 0;
    _ret = lyte_set_sound_pan(sound, pan);
    return _ret;
}
static inline int _impl_set_sound_pitch(lyte_Sound sound, double pitch) {
    (void)sound;(void)pitch;
    int _ret = 0;
    _ret = lyte_set_sound_pitch(sound, pitch);
    return _ret;
}
static inline int _impl_get_sound_volume(lyte_Sound sound, double *val) {
    (void)sound;(void)val;
    int _ret = 0;
    _ret = lyte_get_sound_volume(sound, val);
    return _ret;
}
static inline int _impl_get_sound_pan(lyte_Sound sound, double *val) {
    (void)sound;(void)val;
    int _ret = 0;
    _ret = lyte_get_sound_pan(sound, val);
    return _ret;
}
static inline int _impl_get_sound_pitch(lyte_Sound sound, double *val) {
    (void)sound;(void)val;
    int _ret = 0;
    _ret = lyte_get_sound_pitch(sound, val);
    return _ret;
}
static inline int _impl_load_textfile(const char * file_path, const char * *val) {
    (void)file_path;(void)val;
    int _ret = 0;
    _ret = lyte_load_textfile(file_path, val);
    return _ret;
}
static inline int _impl_save_textfile(const char * file_path, const char * data) {
    (void)file_path;(void)data;
    int _ret = 0;
    _ret = lyte_save_textfile(file_path, data);
    return _ret;
}
static inline int _impl_save_textfile_append(const char * file_path, const char * data) {
    (void)file_path;(void)data;
    int _ret = 0;
    _ret = lyte_save_textfile_append(file_path, data);
    return _ret;
}
static inline int _impl_push_matrix(void) {
    int _ret = 0;
    _ret = lyte_push_matrix();
    return _ret;
}
static inline int _impl_pop_matrix(void) {
    int _ret = 0;
    _ret = lyte_pop_matrix();
    return _ret;
}
static inline int _impl_reset_matrix(void) {
    int _ret = 0;
    _ret = lyte_reset_matrix();
    return _ret;
}
static inline int _impl_translate(int delta_x, int delta_y) {
    (void)delta_x;(void)delta_y;
    int _ret = 0;
    _ret = lyte_translate(delta_x, delta_y);
    return _ret;
}
static inline int _impl_rotate(double angle) {
    (void)angle;
    int _ret = 0;
    _ret = lyte_rotate(angle);
    return _ret;
}
static inline int _impl_rotate_at(double angle, int x, int y) {
    (void)angle;(void)x;(void)y;
    int _ret = 0;
    _ret = lyte_rotate_at(angle, x, y);
    return _ret;
}
static inline int _impl_scale(double scale_x, double scale_y) {
    (void)scale_x;(void)scale_y;
    int _ret = 0;
    _ret = lyte_scale(scale_x, scale_y);
    return _ret;
}
static inline int _impl_scale_at(int scale_x, int scale_y, double x, double y) {
    (void)scale_x;(void)scale_y;(void)x;(void)y;
    int _ret = 0;
    _ret = lyte_scale_at(scale_x, scale_y, x, y);
    return _ret;
}
static inline int _impl_set_default_blendmode(lyte_BlendMode blendmode) {
    (void)blendmode;
    int _ret = 0;
    _ret = lyte_set_default_blendmode(blendmode);
    return _ret;
}
static inline int _impl_set_blendmode(lyte_BlendMode blendmode) {
    (void)blendmode;
    int _ret = 0;
    _ret = lyte_set_blendmode(blendmode);
    return _ret;
}
static inline int _impl_reset_blendmode(void) {
    int _ret = 0;
    _ret = lyte_reset_blendmode();
    return _ret;
}
static inline int _impl_set_default_filtermode(lyte_FilterMode filtermode) {
    (void)filtermode;
    int _ret = 0;
    _ret = lyte_set_default_filtermode(filtermode);
    return _ret;
}
static inline int _impl_set_filtermode(lyte_FilterMode filtermode) {
    (void)filtermode;
    int _ret = 0;
    _ret = lyte_set_filtermode(filtermode);
    return _ret;
}
static inline int _impl_reset_filtermode(void) {
    int _ret = 0;
    _ret = lyte_reset_filtermode();
    return _ret;
}
static inline int _impl_set_shader(lyte_Shader shader) {
    (void)shader;
    int _ret = 0;
    _ret = lyte_set_shader(shader);
    return _ret;
}
static inline int _impl_reset_shader(void) {
    int _ret = 0;
    _ret = lyte_reset_shader();
    return _ret;
}
static inline int _impl_set_shader_uniform(lyte_Shader shader, const char * uniform_name, lyte_ShaderUniformValue uniform_value, int which_uniform_value) {
    (void)shader;(void)uniform_name;(void)uniform_value;(void)which_uniform_value;
    int _ret = 0;
    _ret = lyte_set_shader_uniform(shader, uniform_name, uniform_value, which_uniform_value);
    return _ret;
}
static inline int _impl_reset_shader_uniform(lyte_Shader shader, const char * uniform_name) {
    (void)shader;(void)uniform_name;
    int _ret = 0;
    _ret = lyte_reset_shader_uniform(shader, uniform_name);
    return _ret;
}
static inline int _impl_shaderbuilder_uniform(lyte_ShaderBuilder shaderbuilder, const char * uniform_name, lyte_UniformType uniform_type) {
    (void)shaderbuilder;(void)uniform_name;(void)uniform_type;
    int _ret = 0;
    _ret = lyte_shaderbuilder_uniform(shaderbuilder, uniform_name, uniform_type);
    return _ret;
}
static inline int _impl_shaderbuilder_vertex(lyte_ShaderBuilder shaderbuilder, const char * vertex_code) {
    (void)shaderbuilder;(void)vertex_code;
    int _ret = 0;
    _ret = lyte_shaderbuilder_vertex(shaderbuilder, vertex_code);
    return _ret;
}
static inline int _impl_shaderbuilder_fragment(lyte_ShaderBuilder shaderbuilder, const char * fragment_code) {
    (void)shaderbuilder;(void)fragment_code;
    int _ret = 0;
    _ret = lyte_shaderbuilder_fragment(shaderbuilder, fragment_code);
    return _ret;
}
