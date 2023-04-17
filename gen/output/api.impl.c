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
    // XTODO
    return 0;
}
static inline int _impl_ctor_load_image(const char * image_path, lyte_Image *val) {
    // XTODO
    return 0;
}
static inline int _impl_ctor_load_music(const char * music_path, lyte_Music *val) {
    // XTODO
    return 0;
}
static inline int _impl_ctor_load_sounddata(const char * sounddata_path, lyte_SoundData *val) {
    // XTODO
    return 0;
}
static inline int _impl_ctor_new_canvas(int width, int height, lyte_Canvas *val) {
    // XTODO
    return 0;
}
static inline int _impl_ctor_new_shader(lyte_ShaderDef shaderdef, lyte_Shader *val) {
    // XTODO
    return 0;
}
static inline int _impl_ctor_new_sound(lyte_SoundData sounddata, lyte_Sound *val) {
    // XTODO
    return 0;
}
static inline int _destroy_lyte_ShaderDef(lyte_ShaderDef *shaderdef) {
    // XTODO
    return 0;
}
static inline int _destroy_lyte_Shader(lyte_Shader *shader) {
    // XTODO
    return 0;
}
static inline int _destroy_lyte_Canvas(lyte_Canvas *canvas) {
    // XTODO
    return 0;
}
static inline int _destroy_lyte_Font(lyte_Font *font) {
    // XTODO
    return 0;
}
static inline int _destroy_lyte_Image(lyte_Image *image) {
    // XTODO
    return 0;
}
static inline int _destroy_lyte_Music(lyte_Music *music) {
    // XTODO
    return 0;
}
static inline int _destroy_lyte_Sound(lyte_Sound *sound) {
    // XTODO
    return 0;
}
static inline int _destroy_lyte_SoundData(lyte_SoundData *sounddata) {
    // XTODO
    return 0;
}
static inline int _impl_cls(double r, double g, double b, double a) {
    // XTODO
    return 0;
}
static inline int _impl_draw_image(lyte_Image image, int dest_x, int dest_y) {
    // XTODO
    return 0;
}
static inline int _impl_draw_image_rect(lyte_Image image, int dest_x, int dest_y, int src_x, int src_y, int rect_width, int rect_height) {
    // XTODO
    return 0;
}
static inline int _impl_draw_line(int x1, int y1, int x2, int y2) {
    // XTODO
    return 0;
}
static inline int _impl_draw_point(int x, int y) {
    // XTODO
    return 0;
}
static inline int _impl_draw_rect(int dest_x, int dest_y, int rect_width, int rect_height) {
    // XTODO
    return 0;
}
static inline int _impl_draw_rect_line(int dest_x, int dest_y, int rect_width, int rect_height) {
    // XTODO
    return 0;
}
static inline int _impl_draw_text(const char * text, int dest_x, int dest_y) {
    // XTODO
    return 0;
}
static inline int _impl_get_gamepad_axis(int index, lyte_GamepadAxis gamepad_axis, double *val) {
    // XTODO
    return 0;
}
static inline int _impl_get_gamepad_count(int *val) {
    // XTODO
    return 0;
}
static inline int _impl_get_gamepad_name(int index, const char * *val) {
    // XTODO
    return 0;
}
static inline int _impl_get_mastervolume(double *val) {
    // XTODO
    return 0;
}
static inline int _impl_get_mouse_x(int *val) {
    // XTODO
    return 0;
}
static inline int _impl_get_mouse_y(int *val) {
    // XTODO
    return 0;
}
static inline int _impl_get_music_length(lyte_Music music, double *val) {
    // XTODO
    return 0;
}
static inline int _impl_get_music_length_played(lyte_Music music, double *val) {
    // XTODO
    return 0;
}
static inline int _impl_get_music_pan(lyte_Music music, double *val) {
    // XTODO
    return 0;
}
static inline int _impl_get_music_pitch(lyte_Music music, double *val) {
    // XTODO
    return 0;
}
static inline int _impl_get_music_volume(lyte_Music music, double *val) {
    // XTODO
    return 0;
}
static inline int _impl_get_sound_pan(lyte_Sound sound, double *val) {
    // XTODO
    return 0;
}
static inline int _impl_get_sound_pitch(lyte_Sound sound, double *val) {
    // XTODO
    return 0;
}
static inline int _impl_get_sound_volume(lyte_Sound sound, double *val) {
    // XTODO
    return 0;
}
static inline int _impl_get_sounddata_pan(lyte_SoundData sounddata, double *val) {
    // XTODO
    return 0;
}
static inline int _impl_get_sounddata_pitch(lyte_SoundData sounddata, double *val) {
    // XTODO
    return 0;
}
static inline int _impl_get_sounddata_volume(lyte_SoundData sounddata, double *val) {
    // XTODO
    return 0;
}
static inline int _impl_get_text_width(const char * text, int *val) {
    // XTODO
    return 0;
}
static inline int _impl_get_text_height(const char * text, int *val) {
    // XTODO
    return 0;
}
static inline int _impl_get_window_width(int *val) {
    // XTODO
    return 0;
}
static inline int _impl_get_window_height(int *val) {
    // XTODO
    return 0;
}
static inline int _impl_get_image_width(lyte_Image image, int *val) {
    // XTODO
    return 0;
}
static inline int _impl_get_image_height(lyte_Image image, int *val) {
    // XTODO
    return 0;
}
static inline int _impl_get_canvas_width(lyte_Canvas canvas, int *val) {
    // XTODO
    return 0;
}
static inline int _impl_get_canvas_height(lyte_Canvas canvas, int *val) {
    // XTODO
    return 0;
}
static inline int _impl_get_canvas_image(lyte_Canvas canvas, Image_UNKNOWN_TODO *val) {
    // XTODO
    return 0;
}
static inline int _impl_is_fullscreen(bool *val) {
    // XTODO
    return 0;
}
static inline int _impl_is_gamepad_down(int index, lyte_GamepadButton gamepad_button, bool *val) {
    // XTODO
    return 0;
}
static inline int _impl_is_gamepad_pressed(int index, lyte_GamepadButton gamepad_button, bool *val) {
    // XTODO
    return 0;
}
static inline int _impl_is_gamepad_released(int index, lyte_GamepadButton gamepad_button, bool *val) {
    // XTODO
    return 0;
}
static inline int _impl_is_key_down(lyte_KeyboardKey key, bool *val) {
    // XTODO
    return 0;
}
static inline int _impl_is_key_pressed(lyte_KeyboardKey key, bool *val) {
    // XTODO
    return 0;
}
static inline int _impl_is_key_released(lyte_KeyboardKey key, bool *val) {
    // XTODO
    return 0;
}
static inline int _impl_is_key_repeat(lyte_KeyboardKey key, bool *val) {
    // XTODO
    return 0;
}
static inline int _impl_is_mouse_down(lyte_MouseButton mouse_button, bool *val) {
    // XTODO
    return 0;
}
static inline int _impl_is_mouse_pressed(lyte_MouseButton mouse_button, bool *val) {
    // XTODO
    return 0;
}
static inline int _impl_is_mouse_released(lyte_MouseButton mouse_button, bool *val) {
    // XTODO
    return 0;
}
static inline int _impl_is_music_playing(lyte_Music music, bool *val) {
    // XTODO
    return 0;
}
static inline int _impl_is_sound_playing(lyte_Sound sound, bool *val) {
    // XTODO
    return 0;
}
static inline int _impl_is_window_vsync(bool *val) {
    // XTODO
    return 0;
}
static inline int _impl_load_file(const char * file_path, const char * *val) {
    // XTODO
    return 0;
}
static inline int _impl_pause_music(lyte_Music music) {
    // XTODO
    return 0;
}
static inline int _impl_pause_sound(lyte_Sound sound) {
    // XTODO
    return 0;
}
static inline int _impl_play_music(lyte_Music music) {
    // XTODO
    return 0;
}
static inline int _impl_play_sound(lyte_Sound sound) {
    // XTODO
    return 0;
}
static inline int _impl_pop_matrix() {
    // XTODO
    return 0;
}
static inline int _impl_push_matrix() {
    // XTODO
    return 0;
}
static inline int _impl_quit() {
    // XTODO
    return 0;
}
static inline int _impl_reset_blendmode() {
    // XTODO
    return 0;
}
static inline int _impl_reset_canvas() {
    // XTODO
    return 0;
}
static inline int _impl_reset_color() {
    // XTODO
    return 0;
}
static inline int _impl_reset_filtermode() {
    // XTODO
    return 0;
}
static inline int _impl_reset_font() {
    // XTODO
    return 0;
}
static inline int _impl_reset_matrix() {
    // XTODO
    return 0;
}
static inline int _impl_reset_shader() {
    // XTODO
    return 0;
}
static inline int _impl_resume_music(lyte_Music music) {
    // XTODO
    return 0;
}
static inline int _impl_resume_sound(lyte_Sound sound) {
    // XTODO
    return 0;
}
static inline int _impl_rotate(double angle) {
    // XTODO
    return 0;
}
static inline int _impl_rotate_at(double angle, int x, int y) {
    // XTODO
    return 0;
}
static inline int _impl_save_file_append(const char * file_path, const char * data) {
    // XTODO
    return 0;
}
static inline int _impl_save_file_write(const char * file_path, const char * data) {
    // XTODO
    return 0;
}
static inline int _impl_scale(double scale_x, double scale_y) {
    // XTODO
    return 0;
}
static inline int _impl_scale_at(int scale_x, int scale_y, double x, double y) {
    // XTODO
    return 0;
}
static inline int _impl_seek_music(lyte_Music music, double secs) {
    // XTODO
    return 0;
}
static inline int _impl_send_shader_uniforms(lyte_Shader shader, lyte_ShaderUniforms uniforms) {
    // XTODO
    return 0;
}
static inline int _impl_set_blendmode(lyte_BlendMode blendmode) {
    // XTODO
    return 0;
}
static inline int _impl_set_canvas(lyte_Canvas canvas) {
    // XTODO
    return 0;
}
static inline int _impl_set_color(double r, double g, double b, double a) {
    // XTODO
    return 0;
}
static inline int _impl_set_default_blendmode(lyte_BlendMode blendmode) {
    // XTODO
    return 0;
}
static inline int _impl_set_default_filtermode(lyte_FilterMode filtermode) {
    // XTODO
    return 0;
}
static inline int _impl_set_filtermode(lyte_FilterMode filtermode) {
    // XTODO
    return 0;
}
static inline int _impl_set_font(lyte_Font font) {
    // XTODO
    return 0;
}
static inline int _impl_set_fullscreen(bool fullscreen) {
    // XTODO
    return 0;
}
static inline int _impl_set_mastervolume(double mastervolume) {
    // XTODO
    return 0;
}
static inline int _impl_set_music_pan(lyte_Music music, double pan) {
    // XTODO
    return 0;
}
static inline int _impl_set_music_pitch(lyte_Music music, double pitch) {
    // XTODO
    return 0;
}
static inline int _impl_set_music_volume(lyte_Music music, double volume) {
    // XTODO
    return 0;
}
static inline int _impl_set_shader(lyte_Shader shader) {
    // XTODO
    return 0;
}
static inline int _impl_set_sound_pan(lyte_Sound sound, double pan) {
    // XTODO
    return 0;
}
static inline int _impl_set_sound_pitch(lyte_Sound sound, double pitch) {
    // XTODO
    return 0;
}
static inline int _impl_set_sound_volume(lyte_Sound sound, double volume) {
    // XTODO
    return 0;
}
static inline int _impl_set_sounddata_pan(lyte_SoundData sounddata, double pan) {
    // XTODO
    return 0;
}
static inline int _impl_set_sounddata_pitch(lyte_SoundData sounddata, double pitch) {
    // XTODO
    return 0;
}
static inline int _impl_set_sounddata_volume(lyte_SoundData sounddata, double volume) {
    // XTODO
    return 0;
}
static inline int _impl_set_window_icon(const char * icon_path) {
    // XTODO
    return 0;
}
static inline int _impl_set_window_margins(int left, int right, int top, int bottom) {
    // XTODO
    return 0;
}
static inline int _impl_set_window_minsize(int width, int height) {
    // XTODO
    return 0;
}
static inline int _impl_set_window_paddings(int left, int right, int top, int bottom) {
    // XTODO
    return 0;
}
static inline int _impl_set_window_size(int width, int height) {
    // XTODO
    return 0;
}
static inline int _impl_set_window_title(const char * title) {
    // XTODO
    return 0;
}
static inline int _impl_set_window_vsync(bool vsync) {
    // XTODO
    return 0;
}
static inline int _impl_stop_music(lyte_Music music) {
    // XTODO
    return 0;
}
static inline int _impl_stop_sound(lyte_Sound sound) {
    // XTODO
    return 0;
}
static inline int _impl_translate(int delta_x, int delta_y) {
    // XTODO
    return 0;
}
