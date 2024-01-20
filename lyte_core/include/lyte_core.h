//

#ifndef LYTE_CORE_H_INCLUDED
#define LYTE_CORE_H_INCLUDED

#include "lyte_enums.h"
#include "lyte_types.h"


#if defined(__EMSCRIPTEN__)
#include <emscripten/emscripten.h>
#include "lyte_emsc.h"
#endif

#define SGP_UNIFORM_CONTENT_SLOTS 1024
#define SGP_TEXTURE_SLOTS 8


#ifndef MIN
#define MIN(a,b) (((a)<(b))?(a):(b))
#endif

#ifndef MAX
#define MAX(a,b) (((a)>(b))?(a):(b))
#endif

#ifndef M_PI
#define M_PI  3.14159265358979323846264f
#endif



// -------------------------
// core data types
// -------------------------

typedef struct lyte_Size {
    int width, height;
} lyte_Size;

typedef struct lyte_QuadSize {
    int left, right, top, bottom;
} lyte_QuadSize;

typedef struct lyte_Args {
    int argc;
    char **argv;
} lyte_Args;

typedef void (*lyte_TickFunction)(void *app_data, float delta_time, int width, int height, bool resized, bool fullscreen);

typedef struct lyte_Config {
    lyte_Args args;
    bool fullscreen;
    bool vsync;
    const char *exe_name;
    // const char *window_title;
    lyte_Size window_size;
    lyte_Size window_min_size;
    lyte_BlendMode blendmode;
    lyte_FilterMode filtermode;
} lyte_Config;

typedef struct lyte_CoreState {
    lyte_Args args;

    lyte_BlendMode default_blendmode;
    lyte_FilterMode default_filtermode;

    const char *exe_name;
    const char *window_title;
    lyte_Size window_size;
    lyte_Size window_min_size;
    bool fullscreen;
    bool vsync;
    lyte_BlendMode blendmode;
    lyte_FilterMode filtermode;
    lyte_QuadSize window_margins;
    lyte_QuadSize window_paddings;

    float current_color[4];

    void *window; // GLFWwindow
    void *monitor; // GLFWmonitor
    void *mode; // GLFWVidMode

    void *shader; // ShaderItem (internal)

    bool do_quit; // set to true to quit the app
    bool first_frame; // first frame of the tick function

    lyte_TickFunction tick_fn;
    void *app_data;

} lyte_CoreState;


// -------------------------
// core state
// -------------------------

extern lyte_CoreState lytecore_state;

int lyte_core_state_init(lyte_Config config);

bool lyte_core_state_has_arg(const char *name);
const char *lyte_core_state_get_arg(const char *name);
bool lyte_core_state_get_arg_bool(const char *name);

int lyte_quit(void);
int lyte_set_color(double r, double g, double b, double a);
int lyte_reset_color(void);
int lyte_set_default_blendmode(lyte_BlendMode blendmode);
int lyte_set_blendmode(lyte_BlendMode blendmode);
int lyte_reset_blendmode(void);
int lyte_set_default_filtermode(lyte_FilterMode filtermode);
int lyte_set_filtermode(lyte_FilterMode filtermode);
int lyte_reset_filtermode(void);
int lyte_cls(double r, double g, double b, double a);
int lyte_push_matrix(void);
int lyte_pop_matrix(void);
int lyte_reset_matrix(void);
int lyte_translate(double delta_x, double delta_y);
int lyte_rotate(double angle);
int lyte_rotate_at(double angle, double x, double y);
int lyte_scale(double scale_x, double scale_y);
int lyte_scale_at(double scale_x, double scale_y, double x, double y);


// -------------------------
// core_window
// -------------------------

int lyte_core_window_init(void);
int lyte_core_window_cleanup(void);

int lyte_get_monitor_count(int *val);
int lyte_get_monitor_name(int index, const char * *val);
int lyte_get_monitor_width(int index, int *val);
int lyte_get_monitor_height(int index, int *val);
int lyte_set_window_monitor(int index);
int lyte_set_window_resizable(bool resizable);
int lyte_set_window_minsize(int width, int height);
int lyte_set_window_size(int width, int height);
int lyte_get_window_width(int *val);
int lyte_get_window_height(int *val);
int lyte_set_window_position(int x, int y);
int lyte_set_fullscreen(bool fullscreen);
int lyte_is_fullscreen(bool *val);
int lyte_set_window_title(const char * title);
int lyte_set_window_icon_file(const char * icon_path);
int lyte_set_window_vsync(bool vsync);
int lyte_is_window_vsync(bool *val);
int lyte_set_window_margins(int left, int right, int top, int bottom);
int lyte_set_window_paddings(int left, int right, int top, int bottom);


// -------------------------
// core_input
// -------------------------

int lyte_core_input_init(void);
int lyte_core_input_cleanup(void);
int lyte_core_input_update_state(void);

int lyte_is_key_down(lyte_KeyboardKey key, bool *val);
int lyte_is_key_pressed(lyte_KeyboardKey key, bool *val);
int lyte_is_key_released(lyte_KeyboardKey key, bool *val);
int lyte_is_key_repeat(lyte_KeyboardKey key, bool *val);
int lyte_is_mouse_down(lyte_MouseButton mouse_button, bool *val);
int lyte_is_mouse_pressed(lyte_MouseButton mouse_button, bool *val);
int lyte_is_mouse_released(lyte_MouseButton mouse_button, bool *val);
int lyte_get_mouse_x(int *val);
int lyte_get_mouse_y(int *val);
int lyte_get_gamepad_count(int *val);
int lyte_get_gamepad_name(int index, const char * *val);
int lyte_is_gamepad_down(int index, lyte_GamepadButton gamepad_button, bool *val);
int lyte_is_gamepad_pressed(int index, lyte_GamepadButton gamepad_button, bool *val);
int lyte_is_gamepad_released(int index, lyte_GamepadButton gamepad_button, bool *val);
int lyte_get_gamepad_axis(int index, lyte_GamepadAxis gamepad_axis, double *val);


// -------------------------
// core_loop
// -------------------------

int lyte_core_start_loop(lyte_TickFunction tick_fn, void *app_data);
int lyte_core_set_loop(lyte_TickFunction tick_fn, void *app_data);


// -------------------------
// core_filesystem
// -------------------------

int lyte_core_filesystem_init(void);
int lyte_core_filesystem_cleanup(void);
int lyte_core_filesystem_update_tasks(void);

bool lyte_core_filesystem_check_fetch_file_in_progress(uint32_t handle);
bool lyte_core_filesystem_check_fetch_file_failed(uint32_t handle);
bool lyte_core_filesystem_check_fetch_file_succeeded(uint32_t handle);
uint32_t lyte_core_filesystem_fetch_file_async(const char *name, const char *path, size_t est_max_size, const char *mount_path);
int lyte_core_filesystem_set_writeable_path(const char* path);
int lyte_core_filesystem_add_path_local(const char* path, const char *mount_path);
int lyte_core_filesystem_add_path_memory(const char *name, void *buf, size_t size, const char *mount_path);

int lyte_load_textfile(const char * file_path, const char * *val);
int lyte_save_textfile(const char * file_path, const char * data);
int lyte_save_textfile_append(const char * file_path, const char * data);


// -------------------------
// core_image
// -------------------------

int lyte_core_image_init(void);
int lyte_core_image_cleanup(void);

int lyte_load_image(const char *path, lyte_Image *img);
int lyte_new_canvas(int w, int h, lyte_Image *img);
int lyte_Image_cleanup(lyte_Image image);

int lyte_get_image_width(lyte_Image image, int *val);
int lyte_get_image_height(lyte_Image image, int *val);

int lyte_draw_image(lyte_Image image, double x, double y);
int lyte_draw_image_ex(lyte_Image image, double x, double y, double angle, double sx, double sy, double ox, double oy);
int lyte_draw_image_rect(lyte_Image image, double x, double y, double src_x, double src_y, double src_w, double src_h);
int lyte_draw_image_rect_ex(lyte_Image image, double x, double y, double src_x, double src_y, double src_w, double src_h, double angle, double sx, double sy, double ox, double oy);

int lyte_set_canvas(lyte_Image image);
int lyte_reset_canvas(void);
int lyte_is_image_canvas(lyte_Image image, bool *val);

int lyte_new_imagebatch(lyte_Image image, lyte_ImageBatch *val);
int lyte_ImageBatch_cleanup(lyte_ImageBatch imagebatch);
int lyte_reset_imagebatch(lyte_ImageBatch imagebatch);
int lyte_add_imagebatch_rect(lyte_ImageBatch imagebatch, double dest_x, double dest_y, double dest_width, double dest_height, double src_x, double src_y, double src_width, double src_height);
int lyte_get_imagebatch_rect_count(lyte_ImageBatch imagebatch, int *val);
int lyte_draw_imagebatch(lyte_ImageBatch imagebatch);


// -------------------------
// core_shapes
// -------------------------

int lyte_draw_point(double x, double y);
int lyte_draw_line(double x1, double y1, double x2, double y2);
int lyte_draw_triangle(double ax, double ay, double bx, double by, double cx, double cy);
int lyte_draw_triangle_line(double ax, double ay, double bx, double by, double cx, double cy);
int lyte_draw_rect(double dest_x, double dest_y, double rect_width, double rect_height);
int lyte_draw_rect_line(double dest_x, double dest_y, double rect_width, double rect_height);
int lyte_draw_circle(double dest_x, double dest_y, double radius);
int lyte_draw_circle_line(double dest_x, double dest_y, double radius);
int lyte_draw_ellipse(double dest_x, double dest_y, double radius_x, double radius_y);
int lyte_draw_ellipse_line(double dest_x, double dest_y, double radius_x, double radius_y);


// -------------------------
// core_audio
// -------------------------

int lyte_core_audio_init(void);
int lyte_core_audio_cleanup(void);
int lyte_core_audio_update_music_streams(void); // needs to run each frame

// general
int lyte_get_mastervolume(double *vol);
int lyte_set_mastervolume(double vol);

// music
int lyte_load_music(const char *path, lyte_Music *mus);
int lyte_Music_cleanup(lyte_Music mus);

int lyte_play_music(lyte_Music mus);
int lyte_pause_music(lyte_Music mus);
int lyte_resume_music(lyte_Music mus);
int lyte_stop_music(lyte_Music mus);
int lyte_is_music_playing(lyte_Music mus, bool *val);
int lyte_get_music_volume(lyte_Music mus, double *val);
int lyte_get_music_pan(lyte_Music mus, double *val);
int lyte_get_music_pitch(lyte_Music mus, double *val);
int lyte_get_music_length(lyte_Music mus, double *secs);
int lyte_get_music_length_played(lyte_Music mus, double *secs);
int lyte_set_music_volume(lyte_Music mus, double vol);
int lyte_set_music_pan(lyte_Music mus, double pan);
int lyte_set_music_pitch(lyte_Music mus, double pitch);
int lyte_seek_music(lyte_Music mus, double secs);

// sound
int lyte_load_sound(const char * sound_path, lyte_Sound *val);
int lyte_clone_sound(lyte_Sound orig, lyte_Sound *val);
int lyte_Sound_cleanup(lyte_Sound sound);

int lyte_play_sound(lyte_Sound snd);
int lyte_pause_sound(lyte_Sound snd);
int lyte_resume_sound(lyte_Sound snd);
int lyte_stop_sound(lyte_Sound snd);
int lyte_is_sound_playing(lyte_Sound snd, bool *val);
int lyte_get_sound_volume(lyte_Sound snd, double *val);
int lyte_get_sound_pan(lyte_Sound snd, double *val);
int lyte_get_sound_pitch(lyte_Sound snd, double *val);
int lyte_set_sound_volume(lyte_Sound snd, double volume);
int lyte_set_sound_pan(lyte_Sound snd, double pan);
int lyte_set_sound_pitch(lyte_Sound snd, double pitch);

// -------------------------
// core_font
// -------------------------

int lyte_core_font_init(void);
int lyte_core_font_cleanup(void);

int lyte_load_font(const char * font_path, double size, lyte_Font *val);
int lyte_Font_cleanup(lyte_Font font);

int lyte_set_font(lyte_Font font);
int lyte_draw_text(const char * text, double dest_x, double dest_y);
int lyte_get_text_width(const char * text, int *val);
int lyte_get_text_height(const char * text, int *val);


// -------------------------
// core_shader
// -------------------------

int lyte_core_shader_init(void);
int lyte_core_shader_cleanup(void);
int lyte_core_shader_set_color(void);

// ShaderBuilder
int lyte_new_shaderbuilder(lyte_ShaderBuilder *val);
int lyte_ShaderBuilder_cleanup(lyte_ShaderBuilder shaderbuilder);

int lyte_shaderbuilder_uniform(lyte_ShaderBuilder shaderbuilder, const char * uniform_name, lyte_UniformType uniform_type);
int lyte_shaderbuilder_vertex(lyte_ShaderBuilder shaderbuilder, const char * vertex_code);
int lyte_shaderbuilder_fragment(lyte_ShaderBuilder shaderbuilder, const char * fragment_code);

// Shader
int lyte_shaderbuilder_build(lyte_ShaderBuilder shaderbuilder, lyte_Shader *shader);
int lyte_Shader_cleanup(lyte_Shader shader);

int lyte_set_shader(lyte_Shader shader);
int lyte_reset_shader(void);
int lyte_set_shader_uniform(lyte_Shader shader, const char * uniform_name, lyte_ShaderUniformValue uniform_value);
int lyte_reset_shader_uniform(lyte_Shader shader, const char * uniform_name);


// -------------------------
// core_physics
// -------------------------

int lyte_physics_init(void);
int lyte_physics_cleanup(void);

#endif  // LYTE_CORE_H_INCLUDED
