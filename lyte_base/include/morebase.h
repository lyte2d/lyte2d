/* (c) mg */

#ifndef MOREBASE_H_INCLUDED
#define MOREBASE_H_INCLUDED

#include "moreconfig.h"

#include "mb_utils.h"
#include "mb_types.h"
//
#include "mb_keyboardkeys.h"
#include "mb_mousebuttons.h"
#include "mb_joysticks.h"
#include "mb_gamepadbuttons.h"
#include "mb_gamepadaxes.h"

// order and numbering important. must match sokol_gp
typedef enum M_FilterMode {
    M_FILTER_NEAREST = 1,
    M_FILTER_LINEAR = 2,
    M_NUM_FILTERMODES = 3,
} M_FilterMode;

// order and numbering important. must match sokol_gp
typedef enum M_BlendMode {
    M_BLENDMODE_NONE = 0, /* No blending.
                               dstRGBA = srcRGBA */
    M_BLENDMODE_BLEND,    /* Alpha blending.
                               dstRGB = (srcRGB * srcA) + (dstRGB * (1-srcA))
                               dstA = srcA + (dstA * (1-srcA)) */
    M_BLENDMODE_ADD,      /* Color add.
                               dstRGB = (srcRGB * srcA) + dstRGB
                               dstA = dstA */
    M_BLENDMODE_MOD,      /* Color modulate.
                               dstRGB = srcRGB * dstRGB
                               dstA = dstA */
    M_BLENDMODE_MUL,      /* Color multiply.
                               dstRGB = (srcRGB * dstRGB) + (dstRGB * (1-srcA))
                               dstA = (srcA * dstA) + (dstA * (1-srcA)) */
    M_NUM_BLENDMODES,
} M_BlendMode;

// order and numbering important. must match sokol_gp and api.c
typedef enum M_UniformType {
    M_UNIFORM_INVALID = 0,
    M_UNIFORM_FLOAT = 1,
    M_UNIFORM_FLOAT2 = 2,
    M_UNIFORM_FLOAT3 = 3,
    M_UNIFORM_FLOAT4 = 4,
    M_UNIFORM_INT = 5,
    M_UNIFORM_INT2 = 6,
    M_UNIFORM_INT3 = 7,
    M_UNIFORM_INT4 = 8,
    M_UNIFORM_MAT4 = 9,
    M_UNIFORM_SAMPLER2D = 10,
} M_UniformType;

typedef void (*M_FuncSimple)(void *app_data);

typedef void (*M_TickFunc)(void *app_data, float delta_time, int width, int height, bool resized, bool fullscreen);

typedef struct M_Config {
    char *title, *icon;
    int height, width;
    bool fullscreen, resizable, vsync;
    M_FilterMode defaultfiltermode;
    M_BlendMode defaultblendmode;
    int argc;
    char **argv;
} M_Config;


typedef struct M_Point {
    float x, y;
} M_Point;

typedef struct M_Line {
    float x1, y1, x2, y2;
} M_Line;

typedef struct M_Rect {
    float x, y, w, h;
} M_Rect;

typedef struct M_Triangle {
    float x1, y1, x2, y2, x3, y3;
} M_Triangle;

typedef struct M_Image {
    uint32_t id;
    int width;
    int height;
} M_Image;

typedef struct M_Canvas {
    uint32_t id_image;
    uint32_t id_depth_image;
    uint32_t id_pass;
    int width;
    int height;
    int _ref; //
} M_Canvas;

typedef struct M_ShaderDef {
    uint32_t _shader_id;
    void *_impl;
        // float *_uniform_data;
        // size_t _uniform_data_size;
        // uint32_t *_uniform_images;
        // bool * _uniform_image_deletes; // whether this image should be deleted
        // size_t _num_uniform_images; // array count, not image count
    struct M_UniformDef {
        const char *name;
        M_UniformType type;
        uint32_t _num_elems;
        uint32_t _loc;
    } *uniforms;
    size_t num_uniforms;
    const char *vert;
    const char *frag;
} M_ShaderDef;

typedef struct M_ShaderUniform {
    const char *name;
    void *data;
    size_t count;
} M_ShaderUniform;

typedef struct M_Shader {
    //const char *code;
    uint32_t id;
    uint32_t pip_id;
} M_Shader;

typedef struct M_Font {
    uint32_t id;
} M_Font;

typedef struct M_Music {
    uint32_t id;
} M_Music;

typedef struct M_SoundData {
    uint32_t id;
} M_SoundData;

typedef struct M_Sound {
    uint32_t data_id;
    uint32_t channel_idx;
} M_Sound;


// app model
//-----------------------------
bool M_system_WASM(void);
int M_app_init(M_Config *config);
void M_app_startloop(M_TickFunc tick_fn, void *app_data);
void M_app_cleanup(void);

void M_app_quit(void);
bool M_app_getfullscreen(void);
void M_app_setfullscreen(bool fullscreen);
//int M_app_getwindowwidth(void);
//int M_app_getwindowheight(void);
M_SizeI M_app_getwindowsize(void);
void M_app_setwindowsize(int w, int h);
void M_app_setwindowminsize(int w, int h);

void M_app_seticon(const char *path);
void M_app_settitle(const char *title);

bool M_app_getvsync(void);
void M_app_setvsync(bool vsync);


void M_app_setmargins(int left, int right, int top, int bottom);
void M_app_setpaddings(int left, int right, int top, int bottom);

bool M_app_hasarg(const char *key);
const char *M_app_getarg(const char *key);

// get margins/paddings?
// set/get title?
// set/get icon?


// filesystem
//-----------------------------
void M_filesystem_set_writepath(char *path);
bool M_filesystem_add_localpath(const char *name, char *mount_path, const char *physical_path);
void M_filesystem_add_zippath_async(const char *name, const char *mount_path, const char *physical_fetch_path, size_t buffer_size);
void M_filesystem_add_memoryzippath_withbuf(const char *name, const char *mount_path, void *buf, size_t buffer_size);
bool M_filesystem_zippath_is_done(const char *name);
bool M_filesystem_zippath_exists(const char *name);
const char *M_filesystem_get_error(void);
bool M_path_exists(const char *path);
size_t M_path_filesize(const char *path);
size_t M_path_readbytes(const char *path, const uint8_t *buf, size_t buffer_size);
size_t M_path_writebytes(const char *path, uint8_t *buf, size_t buffer_size);
size_t M_path_appendbytes(const char *path, uint8_t *buf, size_t buffer_size);
// bool M_filesystem_path_exists(const char *path);
// bool M_filesystem_path_remove(const char *internal_path);



// input
//-----------------------------
bool M_input_keydown(M_KeyboardKey key);
bool M_input_keyrepeat(M_KeyboardKey key);
bool M_input_keypressed(M_KeyboardKey key);
bool M_input_keyreleased(M_KeyboardKey key);
bool M_input_mousedown(M_MouseButton mousebut);
bool M_input_mousepressed(M_MouseButton mousebut);
bool M_input_mousereleased(M_MouseButton mousebut);
float M_input_mouse_x(void);
float M_input_mouse_y(void);
int M_input_numgamepads(void);
bool M_input_gamepaddown(M_JoystickID idx, M_GamepadButton gamepadbut);
bool M_input_gamepadpressed(M_JoystickID idx, M_GamepadButton gamepadbut);
bool M_input_gamepadreleased(M_JoystickID idx, M_GamepadButton gamepadbut);
float M_input_gamepadaxis(M_JoystickID idx, M_GamepadAxis axis);
const char  *M_input_gamepadname(M_JoystickID idx);
// gamepad is connected?


// graphics2d
//-----------------------------
void M_gfx_pushmatrix(void);
void M_gfx_popmatrix(void);
void M_gfx_identitymatrix(void);
void M_gfx_translate(float dx, float dy);
void M_gfx_rotate(float r);
void M_gfx_rotate_at(float rot, float x, float y);
void M_gfx_scale(float sx, float sy);
void M_gfx_scale_at(float sx, float sy, float x, float y);
void M_gfx_clear(float r, float g, float b, float a);
void M_gfx_setcolor(float r, float g, float b, float a);
void M_gfx_resetcolor(void);
void M_gfx_setdefaultblendmode(M_BlendMode blendmode);
void M_gfx_setblendmode(M_BlendMode blendmode);
void M_gfx_resetblendmode(void);
void M_gfx_setdefaultfiltermode(M_FilterMode filtermode);
void M_gfx_setfiltermode(M_FilterMode filtermode);
void M_gfx_resetfiltermode(void);

// canvas
M_Canvas M_newcanvas(int w, int h);
void M_canvas_cleanup(M_Canvas canvas);
M_Image M_canvas_get_image(M_Canvas canvas);
void M_canvas_set(M_Canvas canvas);
void M_canvas_unset(void);
// also rename these to match lua better

// image
M_Image M_newimage_load(const char *path);
void M_image_cleanup(M_Image image);
void M_image_draw(M_Image image, float x, float y);
void M_image_draw_rect_line(M_Image image, float x, float y, float img_x, float img_y, float rect_width, float rec_height);
// multiple rects from single image to help with batching

// shader
M_Shader M_newshader(M_ShaderDef shaderdef);
// M_Shader M_newshader_load(const char *path);
void M_shader_cleanup(M_Shader shader);
void M_shader_set(M_Shader shader);
void M_shader_unset(void);
void M_shader_send(M_Shader shader, M_ShaderUniform *uniforms, size_t count);

// font
M_Font M_newfont_load(const char *path, float size);
void M_font_cleanup(M_Font font);
void M_font_setfont(M_Font font);
M_Font M_font_getfont(void);
M_SizeI M_font_drawtext(const char *str, int x, int y);
M_SizeI M_font_measuretext(const char *str);
// TODO more to expose here

// draw
void M_gfx_drawpoint(float x, float y);
void M_gfx_drawline(float x1, float y1, float x2, float y2);
void M_gfx_drawrect(float x, float y, float w, float h);
void M_gfx_drawrect_filled(float x, float y, float w, float h);

void M_gfx_drawpoints(M_Point *points, int cnt);
void M_gfx_drawlines(M_Line *lines, int cnt);
void M_gfx_drawrects_filled(M_Rect *rects, int cnt);
void M_gfx_drawtriangles_filled(M_Triangle *triangles, int cnt);

// void M_gfx_drawstriplines(M_Point *pts, int cnt);
// void M_gfx_drawstriptriangles_filled(M_Point *pts, int cnt);


// audio
void M_app_setmastervolume(float volume);
float M_app_getmastervolume(void);

M_Music M_newmusic_load(const char *path);
void M_music_cleanup(M_Music music);
float M_music_get_volume(M_Music music);
void M_music_set_volume(M_Music music,float volume);
float M_music_get_pitch(M_Music music);
void M_music_set_pitch(M_Music music,float volume);
float M_music_get_pan(M_Music music);
void M_music_set_pan(M_Music music,float volume);
void M_music_play(M_Music music);
void M_music_pause(M_Music music);
void M_music_resume(M_Music music);
void M_music_seek(M_Music music,float secs);
void M_music_stop(M_Music music);
float M_music_get_length(M_Music music);
float M_music_get_length_played(M_Music music);
bool M_music_isplaying(M_Music music);

M_SoundData M_newsounddata_load(const char *path);
void M_sounddata_cleanup(M_SoundData sounddata);
float M_sounddata_get_volume(M_SoundData sound);
void M_sounddata_set_volume(M_SoundData sound, float volume);
float M_sounddata_get_pitch(M_SoundData sound);
void M_sounddata_set_pitch(M_SoundData sound, float volume);
float M_sounddata_get_pan(M_SoundData sound);
void M_sounddata_set_pan(M_SoundData sound, float volume);

M_Sound M_newsound(M_SoundData sounddata);
void M_sound_cleanup(M_Sound sound);
float M_sound_get_volume(M_Sound sound);
void M_sound_set_volume(M_Sound sound, float volume);
float M_sound_get_pitch(M_Sound sound);
void M_sound_set_pitch(M_Sound sound, float volume);
float M_sound_get_pan(M_Sound sound);
void M_sound_set_pan(M_Sound sound, float volume);
void M_sound_play(M_Sound sound);
void M_sound_pause(M_Sound sound);
void M_sound_resume(M_Sound sound);
void M_sound_stop(M_Sound sound);
bool M_sound_isplaying(M_Sound sound);

#endif  /* MOREBASE_H_INCLUDED */
