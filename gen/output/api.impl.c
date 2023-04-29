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

static inline int _impl_ctor_load_font(const char * font_path, double size, lyte_Font *val) {
    (void)font_path;
    (void)size;
    (void)val;
    // implementation
    return 0;
}
static inline int _impl_ctor_load_image(const char * image_path, lyte_Image *val) {
    (void)image_path;
    (void)val;
    // implementation
    return 0;
}
static inline int _impl_ctor_load_music(const char * music_path, lyte_Music *val) {
    (void)music_path;
    (void)val;
    // implementation
    return 0;
}
static inline int _impl_ctor_load_sounddata(const char * sounddata_path, lyte_SoundData *val) {
    (void)sounddata_path;
    (void)val;
    // implementation
    return 0;
}
static inline int _impl_ctor_new_canvas(int width, int height, lyte_Image *val) {
    (void)width;
    (void)height;
    (void)val;
    // implementation
    return 0;
}
static inline int _impl_ctor_new_sound(lyte_SoundData sounddata, lyte_Sound *val) {
    (void)sounddata;
    (void)val;
    // implementation
    return 0;
}
static inline int _impl_ctor_new_shaderbuilder(lyte_ShaderBuilder *val) {
    (void)val;
    // implementation
    return 0;
}
static inline int _impl_ctor_shaderbuilder_build(lyte_ShaderBuilder shaderbuilder, lyte_Shader *shader) {
    (void)shaderbuilder;
    (void)shader;
    // implementation
    return 0;
}
static inline int _destroy_lyte_ShaderBuilder(lyte_ShaderBuilder *shaderbuilder) {
    (void)shaderbuilder;
    // implementation
    return 0;
}
static inline int _destroy_lyte_Shader(lyte_Shader *shader) {
    (void)shader;
    // implementation
    return 0;
}
static inline int _destroy_lyte_Image(lyte_Image *image) {
    (void)image;
    // implementation
    return 0;
}
static inline int _destroy_lyte_Font(lyte_Font *font) {
    (void)font;
    // implementation
    return 0;
}
static inline int _destroy_lyte_Music(lyte_Music *music) {
    (void)music;
    // implementation
    return 0;
}
static inline int _destroy_lyte_Sound(lyte_Sound *sound) {
    (void)sound;
    // implementation
    return 0;
}
static inline int _destroy_lyte_SoundData(lyte_SoundData *sounddata) {
    (void)sounddata;
    // implementation
    return 0;
}
static inline int _impl_cls(double r, double g, double b, double a) {
    (void)r;
    (void)g;
    (void)b;
    (void)a;
    // implementation
    return 0;
}
static inline int _impl_draw_circle(int dest_x, int dest_y, int radius) {
    (void)dest_x;
    (void)dest_y;
    (void)radius;
    // implementation
    return 0;
}
static inline int _impl_draw_circle_line(int dest_x, int dest_y, int radius) {
    (void)dest_x;
    (void)dest_y;
    (void)radius;
    // implementation
    return 0;
}
static inline int _impl_draw_image(lyte_Image image, int dest_x, int dest_y) {
    (void)image;
    (void)dest_x;
    (void)dest_y;
    // implementation
    return 0;
}
static inline int _impl_draw_image_rect(lyte_Image image, int dest_x, int dest_y, int src_x, int src_y, int rect_width, int rect_height) {
    (void)image;
    (void)dest_x;
    (void)dest_y;
    (void)src_x;
    (void)src_y;
    (void)rect_width;
    (void)rect_height;
    // implementation
    return 0;
}
static inline int _impl_draw_line(int x1, int y1, int x2, int y2) {
    (void)x1;
    (void)y1;
    (void)x2;
    (void)y2;
    // implementation
    return 0;
}
static inline int _impl_draw_point(int x, int y) {
    (void)x;
    (void)y;
    // implementation
    return 0;
}
static inline int _impl_draw_rect(int dest_x, int dest_y, int rect_width, int rect_height) {
    (void)dest_x;
    (void)dest_y;
    (void)rect_width;
    (void)rect_height;
    // implementation
    return 0;
}
static inline int _impl_draw_rect_line(int dest_x, int dest_y, int rect_width, int rect_height) {
    (void)dest_x;
    (void)dest_y;
    (void)rect_width;
    (void)rect_height;
    // implementation
    return 0;
}
static inline int _impl_draw_text(const char * text, int dest_x, int dest_y) {
    (void)text;
    (void)dest_x;
    (void)dest_y;
    // implementation
    return 0;
}
static inline int _impl_get_gamepad_axis(int index, lyte_GamepadAxis gamepad_axis, double *val) {
    (void)index;
    (void)gamepad_axis;
    (void)val;
    // implementation
    return 0;
}
static inline int _impl_get_gamepad_count(int *val) {
    (void)val;
    // implementation
    return 0;
}
static inline int _impl_get_gamepad_name(int index, const char * *val) {
    (void)index;
    (void)val;
    // implementation
    return 0;
}
static inline int _impl_get_mastervolume(double *val) {
    (void)val;
    // implementation
    return 0;
}
static inline int _impl_get_mouse_x(int *val) {
    (void)val;
    // implementation
    return 0;
}
static inline int _impl_get_mouse_y(int *val) {
    (void)val;
    // implementation
    return 0;
}
static inline int _impl_get_music_length(lyte_Music music, double *val) {
    (void)music;
    (void)val;
    // implementation
    return 0;
}
static inline int _impl_get_music_length_played(lyte_Music music, double *val) {
    (void)music;
    (void)val;
    // implementation
    return 0;
}
static inline int _impl_get_music_pan(lyte_Music music, double *val) {
    (void)music;
    (void)val;
    // implementation
    return 0;
}
static inline int _impl_get_music_pitch(lyte_Music music, double *val) {
    (void)music;
    (void)val;
    // implementation
    return 0;
}
static inline int _impl_get_music_volume(lyte_Music music, double *val) {
    (void)music;
    (void)val;
    // implementation
    return 0;
}
static inline int _impl_get_sound_pan(lyte_Sound sound, double *val) {
    (void)sound;
    (void)val;
    // implementation
    return 0;
}
static inline int _impl_get_sound_pitch(lyte_Sound sound, double *val) {
    (void)sound;
    (void)val;
    // implementation
    return 0;
}
static inline int _impl_get_sound_volume(lyte_Sound sound, double *val) {
    (void)sound;
    (void)val;
    // implementation
    return 0;
}
static inline int _impl_get_sounddata_pan(lyte_SoundData sounddata, double *val) {
    (void)sounddata;
    (void)val;
    // implementation
    return 0;
}
static inline int _impl_get_sounddata_pitch(lyte_SoundData sounddata, double *val) {
    (void)sounddata;
    (void)val;
    // implementation
    return 0;
}
static inline int _impl_get_sounddata_volume(lyte_SoundData sounddata, double *val) {
    (void)sounddata;
    (void)val;
    // implementation
    return 0;
}
static inline int _impl_get_text_width(const char * text, int *val) {
    (void)text;
    (void)val;
    // implementation
    return 0;
}
static inline int _impl_get_text_height(const char * text, int *val) {
    (void)text;
    (void)val;
    // implementation
    return 0;
}
static inline int _impl_get_window_width(int *val) {
    (void)val;
    // implementation
    return 0;
}
static inline int _impl_get_window_height(int *val) {
    (void)val;
    // implementation
    return 0;
}
static inline int _impl_get_image_width(lyte_Image image, int *val) {
    (void)image;
    (void)val;
    // implementation
    return 0;
}
static inline int _impl_get_image_height(lyte_Image image, int *val) {
    (void)image;
    (void)val;
    // implementation
    return 0;
}
static inline int _impl_is_fullscreen(bool *val) {
    (void)val;
    // implementation
    return 0;
}
static inline int _impl_is_gamepad_down(int index, lyte_GamepadButton gamepad_button, bool *val) {
    (void)index;
    (void)gamepad_button;
    (void)val;
    // implementation
    return 0;
}
static inline int _impl_is_gamepad_pressed(int index, lyte_GamepadButton gamepad_button, bool *val) {
    (void)index;
    (void)gamepad_button;
    (void)val;
    // implementation
    return 0;
}
static inline int _impl_is_gamepad_released(int index, lyte_GamepadButton gamepad_button, bool *val) {
    (void)index;
    (void)gamepad_button;
    (void)val;
    // implementation
    return 0;
}
static inline int _impl_is_key_down(lyte_KeyboardKey key, bool *val) {
    (void)key;
    (void)val;
    // implementation
    return 0;
}
static inline int _impl_is_key_pressed(lyte_KeyboardKey key, bool *val) {
    (void)key;
    (void)val;
    // implementation
    return 0;
}
static inline int _impl_is_key_released(lyte_KeyboardKey key, bool *val) {
    (void)key;
    (void)val;
    // implementation
    return 0;
}
static inline int _impl_is_key_repeat(lyte_KeyboardKey key, bool *val) {
    (void)key;
    (void)val;
    // implementation
    return 0;
}
static inline int _impl_is_mouse_down(lyte_MouseButton mouse_button, bool *val) {
    (void)mouse_button;
    (void)val;
    // implementation
    return 0;
}
static inline int _impl_is_mouse_pressed(lyte_MouseButton mouse_button, bool *val) {
    (void)mouse_button;
    (void)val;
    // implementation
    return 0;
}
static inline int _impl_is_mouse_released(lyte_MouseButton mouse_button, bool *val) {
    (void)mouse_button;
    (void)val;
    // implementation
    return 0;
}
static inline int _impl_is_music_playing(lyte_Music music, bool *val) {
    (void)music;
    (void)val;
    // implementation
    return 0;
}
static inline int _impl_is_sound_playing(lyte_Sound sound, bool *val) {
    (void)sound;
    (void)val;
    // implementation
    return 0;
}
static inline int _impl_is_window_vsync(bool *val) {
    (void)val;
    // implementation
    return 0;
}
static inline int _impl_is_image_canvas(lyte_Image image, bool *val) {
    (void)image;
    (void)val;
    // implementation
    return 0;
}
static inline int _impl_load_file(const char * file_path, const char * *val) {
    (void)file_path;
    (void)val;
    // implementation
    return 0;
}
static inline int _impl_pause_music(lyte_Music music) {
    (void)music;
    // implementation
    return 0;
}
static inline int _impl_pause_sound(lyte_Sound sound) {
    (void)sound;
    // implementation
    return 0;
}
static inline int _impl_play_music(lyte_Music music) {
    (void)music;
    // implementation
    return 0;
}
static inline int _impl_play_sound(lyte_Sound sound) {
    (void)sound;
    // implementation
    return 0;
}
static inline int _impl_pop_matrix(void) {
    // implementation
    return 0;
}
static inline int _impl_push_matrix(void) {
    // implementation
    return 0;
}
static inline int _impl_quit(void) {
    // implementation
    return 0;
}
static inline int _impl_reset_blendmode(void) {
    // implementation
    return 0;
}
static inline int _impl_reset_canvas(void) {
    // implementation
    return 0;
}
static inline int _impl_reset_color(void) {
    // implementation
    return 0;
}
static inline int _impl_reset_filtermode(void) {
    // implementation
    return 0;
}
static inline int _impl_reset_font(void) {
    // implementation
    return 0;
}
static inline int _impl_reset_matrix(void) {
    // implementation
    return 0;
}
static inline int _impl_reset_shader(void) {
    // implementation
    return 0;
}
static inline int _impl_resume_music(lyte_Music music) {
    (void)music;
    // implementation
    return 0;
}
static inline int _impl_resume_sound(lyte_Sound sound) {
    (void)sound;
    // implementation
    return 0;
}
static inline int _impl_rotate(double angle) {
    (void)angle;
    // implementation
    return 0;
}
static inline int _impl_rotate_at(double angle, int x, int y) {
    (void)angle;
    (void)x;
    (void)y;
    // implementation
    return 0;
}
static inline int _impl_save_file_append(const char * file_path, const char * data) {
    (void)file_path;
    (void)data;
    // implementation
    return 0;
}
static inline int _impl_save_file_write(const char * file_path, const char * data) {
    (void)file_path;
    (void)data;
    // implementation
    return 0;
}
static inline int _impl_scale(double scale_x, double scale_y) {
    (void)scale_x;
    (void)scale_y;
    // implementation
    return 0;
}
static inline int _impl_scale_at(int scale_x, int scale_y, double x, double y) {
    (void)scale_x;
    (void)scale_y;
    (void)x;
    (void)y;
    // implementation
    return 0;
}
static inline int _impl_seek_music(lyte_Music music, double secs) {
    (void)music;
    (void)secs;
    // implementation
    return 0;
}
static inline int _impl_set_blendmode(lyte_BlendMode blendmode) {
    (void)blendmode;
    // implementation
    return 0;
}
static inline int _impl_set_canvas(lyte_Image canvas_image) {
    (void)canvas_image;
    // implementation
    return 0;
}
static inline int _impl_set_color(double r, double g, double b, double a) {
    (void)r;
    (void)g;
    (void)b;
    (void)a;
    // implementation
    return 0;
}
static inline int _impl_set_default_blendmode(lyte_BlendMode blendmode) {
    (void)blendmode;
    // implementation
    return 0;
}
static inline int _impl_set_default_filtermode(lyte_FilterMode filtermode) {
    (void)filtermode;
    // implementation
    return 0;
}
static inline int _impl_set_filtermode(lyte_FilterMode filtermode) {
    (void)filtermode;
    // implementation
    return 0;
}
static inline int _impl_set_font(lyte_Font font) {
    (void)font;
    // implementation
    return 0;
}
static inline int _impl_set_fullscreen(bool fullscreen) {
    (void)fullscreen;
    // implementation
    return 0;
}
static inline int _impl_set_mastervolume(double mastervolume) {
    (void)mastervolume;
    // implementation
    return 0;
}
static inline int _impl_set_music_pan(lyte_Music music, double pan) {
    (void)music;
    (void)pan;
    // implementation
    return 0;
}
static inline int _impl_set_music_pitch(lyte_Music music, double pitch) {
    (void)music;
    (void)pitch;
    // implementation
    return 0;
}
static inline int _impl_set_music_volume(lyte_Music music, double volume) {
    (void)music;
    (void)volume;
    // implementation
    return 0;
}
static inline int _impl_set_shader(lyte_Shader shader) {
    (void)shader;
    // implementation
    return 0;
}
static inline int _impl_set_sound_pan(lyte_Sound sound, double pan) {
    (void)sound;
    (void)pan;
    // implementation
    return 0;
}
static inline int _impl_set_sound_pitch(lyte_Sound sound, double pitch) {
    (void)sound;
    (void)pitch;
    // implementation
    return 0;
}
static inline int _impl_set_sound_volume(lyte_Sound sound, double volume) {
    (void)sound;
    (void)volume;
    // implementation
    return 0;
}
static inline int _impl_set_sounddata_pan(lyte_SoundData sounddata, double pan) {
    (void)sounddata;
    (void)pan;
    // implementation
    return 0;
}
static inline int _impl_set_sounddata_pitch(lyte_SoundData sounddata, double pitch) {
    (void)sounddata;
    (void)pitch;
    // implementation
    return 0;
}
static inline int _impl_set_sounddata_volume(lyte_SoundData sounddata, double volume) {
    (void)sounddata;
    (void)volume;
    // implementation
    return 0;
}
static inline int _impl_set_window_icon(const char * icon_path) {
    (void)icon_path;
    // implementation
    return 0;
}
static inline int _impl_set_window_margins(int left, int right, int top, int bottom) {
    (void)left;
    (void)right;
    (void)top;
    (void)bottom;
    // implementation
    return 0;
}
static inline int _impl_set_window_minsize(int width, int height) {
    (void)width;
    (void)height;
    // implementation
    return 0;
}
static inline int _impl_set_window_paddings(int left, int right, int top, int bottom) {
    (void)left;
    (void)right;
    (void)top;
    (void)bottom;
    // implementation
    return 0;
}
static inline int _impl_set_window_size(int width, int height) {
    (void)width;
    (void)height;
    // implementation
    return 0;
}
static inline int _impl_set_window_title(const char * title) {
    (void)title;
    // implementation
    return 0;
}
static inline int _impl_set_window_vsync(bool vsync) {
    (void)vsync;
    // implementation
    return 0;
}
static inline int _impl_stop_music(lyte_Music music) {
    (void)music;
    // implementation
    return 0;
}
static inline int _impl_stop_sound(lyte_Sound sound) {
    (void)sound;
    // implementation
    return 0;
}
static inline int _impl_translate(int delta_x, int delta_y) {
    (void)delta_x;
    (void)delta_y;
    // implementation
    return 0;
}
static inline int _impl_shaderbuilder_uniform(lyte_ShaderBuilder shaderbuilder, const char * uniform_name, lyte_UniformType uniform_type) {
    (void)shaderbuilder;
    (void)uniform_name;
    (void)uniform_type;
    // implementation
    return 0;
}
static inline int _impl_shaderbuilder_vertex(lyte_ShaderBuilder shaderbuilder, const char * vertex_code) {
    (void)shaderbuilder;
    (void)vertex_code;
    // implementation
    return 0;
}
static inline int _impl_shaderbuilder_fragment(lyte_ShaderBuilder shaderbuilder, const char * fragment_code) {
    (void)shaderbuilder;
    (void)fragment_code;
    // implementation
    return 0;
}
static inline int _impl_send_shader_uniform(lyte_Shader shader, const char * uniform_name, lyte_ShaderUniformValue uniform_value, int which_uniform_value) {
    (void)shader;
    (void)uniform_name;
    (void)uniform_value;
    (void)which_uniform_value;
    // implementation
    return 0;
}
