//

#ifndef LYTE_CORE_H_INCLUDED
#define LYTE_CORE_H_INCLUDED

#include "lyte_enums.h"
#include "lyte_types.h"


#if defined(__EMSCRIPTEN__)
#include <emscripten/emscripten.h>
#include "lyte_emsc.h"
#endif


// -------------------------
// core data types
// -------------------------

typedef struct lyte_Size {
    int width, height;
} lyte_Size;


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


// -------------------------
// core state
// -------------------------

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
int lyte_get_pressed_keys(int **keys, size_t *num_keys);
int lyte_get_textinput(const char **val);
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
int lyte_draw_image_ex(lyte_Image image, double x, double y, double angle, double ox, double oy, double sx, double sy);
int lyte_draw_image_rect(lyte_Image image, double x, double y, double src_x, double src_y, double src_w, double src_h);
int lyte_draw_image_rect_ex(lyte_Image image, double x, double y, double src_x, double src_y, double src_w, double src_h, double angle, double ox, double oy, double sx, double sy);

int lyte_set_canvas(lyte_Image image);
int lyte_reset_canvas(void);
int lyte_is_image_canvas(lyte_Image image, bool *val);
int lyte_capture_image(int x, int y, int w, int h, lyte_Image *val);

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


// // -------------------------
// // core_physics
// // -------------------------

// int lyte_core_physics_init(void);
// int lyte_core_physics_cleanup(void);

// // World
// int lyte_new_world(lyte_World *world);
// int lyte_World_cleanup(lyte_World world);
// int lyte_world_set_gravity(lyte_World world, double x, double y);
// int lyte_world_set_ERP(lyte_World world, double erp);
// int lyte_world_set_CFM(lyte_World world, double cfm);
// // World update
// int lyte_world_update_accurate(lyte_World world, double step_size);
// int lyte_world_update_fast(lyte_World world, double step_size);
// // World damping (TBD)
// // World contact params (TBD)

// // Body
// int lyte_new_body(lyte_World world, lyte_Body *body);
// int lyte_Body_cleanup(lyte_Body body);
// int lyte_body_set_position(lyte_Body body, double x, double y);
// int lyte_body_get_position(lyte_Body body, double *x, double *y);
// int lyte_body_set_rotation(lyte_Body body, double angle);
// int lyte_body_get_rotation(lyte_Body body, double *angle);
// int lyte_body_set_linear_velocity(lyte_Body body, double x, double y);
// int lyte_body_get_linear_velocity(lyte_Body body, double *x, double *y);
// int lyte_body_set_angular_velocity(lyte_Body body, double z);
// int lyte_body_get_angular_velocity(lyte_Body body, double *z);
// int lyte_body_set_mass_circle(lyte_Body body, double mass, double radius);
// int lyte_body_set_mass_rect(lyte_Body body, double mass, double width, double height);
// int lyte_body_add_force(lyte_Body body, double fx, double fy);
// int lyte_body_add_torque(lyte_Body body, double fz);
// int lyte_body_add_rel_force(lyte_Body body, double fx, double fy);
// int lyte_body_add_rel_torque(lyte_Body body, double fz);
// int lyte_body_add_force_at(lyte_Body body, double fx, double fy, double px, double py);
// int lyte_body_add_force_at_rel(lyte_Body body, double fx, double fy, double px, double py);
// int lyte_body_add_rel_force_at(lyte_Body body, double fx, double fy, double px, double py);
// int lyte_body_add_rel_force_at_rel(lyte_Body body, double fx, double fy, double px, double py);
// // Body set force/torque directly. useful possibly for "sleeping bodies" (TBD)
// int lyte_body_get_force(lyte_Body body, double *x, double *y);
// int lyte_body_get_torque(lyte_Body body, double *z);
// int lyte_body_set_kinematic(lyte_Body body, bool val); // kinematic: doesn't react to forces. false by default
// int lyte_body_is_kinematic(lyte_Body body, bool *is_kinematic); // kinematic: doesn't react to forces
// // Body "utility" find relative to world pos, vel, etc. for points on the body. (TBD)
// // Body enable/disable/autoenable/autodisable etc. (TBD)
// // Body damping (TBD)
// // Body misc (attach custom data, finite rotation) (TBD)
// // Body TODO: get body joints
// // Body TODO: get body geoms
// // additional utilities for 2D (https://ode.org/wiki/index.php/Constrain_Objects_to_2D)
// // these are "internal". new_body should set the constraint
// int _lyte_body_2D_constraint(lyte_World world, lyte_Body body); // do on object creation. creates a planejoint
// int _lyte_body_2D_fix_angular_drift(lyte_Body body, bool z_rotate_enabled); // do on each update. non-Z axis rotations are cancelled with this


// // Joints
// int lyte_Joint_cleanup(lyte_Joint joint);
// int lyte_joint_get_class(lyte_Joint joint, lyte_JointClass *cls);
// int lyte_joint_get_body(lyte_Joint joint, int index, lyte_Body *body);
// int lyte_joint_attach(lyte_Joint joint, lyte_Body body1, lyte_Body body2);
// int lyte_joint_attach_one(lyte_Joint joint, lyte_Body body);
// // Joint TODO: enable/disable joints. get/set custom data. are connected...
// // Joint feedback TODO: set/get feedback (force/torque application to either body!) (TBD)
// // int lyte_joint_set_hinge_axis(lyte_Joint joint, double z); // auto?
// int lyte_joint_new_hinge(lyte_World world, lyte_JointGroup jointgroup, lyte_Joint *joint);
// int lyte_joint_new_slider(lyte_World world, lyte_JointGroup jointgroup, lyte_Joint *joint);
// int lyte_joint_new_fixed(lyte_World world, lyte_JointGroup jointgroup, lyte_Joint *joint);
// int lyte_joint_set_hinge_anchor(lyte_Joint joint, double x, double y);
// int lyte_joint_get_hinge_anchor1(lyte_Joint joint, double *x, double *y);
// int lyte_joint_get_hinge_anchor2(lyte_Joint joint, double *x, double *y);
// int lyte_joint_get_hinge_angle(lyte_Joint joint, double *angle);
// int lyte_joint_get_hinge_angle_rate(lyte_Joint joint, double *angle);
// int lyte_joint_set_slider_axis(lyte_Joint joint, double x, double y);
// int lyte_joint_get_slider_axis(lyte_Joint joint, double *x, double *y);
// int lyte_joint_get_slider_position(lyte_Joint joint, double *pos);
// int lyte_joint_get_slider_position_rate(lyte_Joint joint, double *posrate);
// int lyte_joint_set_fixed(lyte_Joint joint);
// // Joint TODO: parameter functions!


// // Geom
// int lyte_Geom_cleanup(lyte_Geom geom);
// int lyte_geom_set_body(lyte_Geom geom, lyte_Body body);
// int lyte_geom_get_body(lyte_Geom geom, lyte_Body *body);
// // Geom set/get position, rot/quat etc. Maybe not needed since Body has these. (TBD)

// int lyte_geom_set_position(lyte_Geom geom, double x, double y);
// int lyte_geom_get_position(lyte_Geom geom, double *x, double *y);
// int lyte_geom_set_rotation(lyte_Geom geom, double angle);
// int lyte_geom_get_rotation(lyte_Geom geom, double *angle);
// // int lyte_geom_set_linear_velocity(lyte_Geom geom, double x, double y);
// // int lyte_geom_get_linear_velocity(lyte_Geom geom, double *x, double *y);
// // int lyte_geom_set_angular_velocity(lyte_Geom geom, double z);
// // int lyte_geom_get_angular_velocity(lyte_Geom geom, double *z);


// int lyte_geom_set_offset_position(lyte_Geom geom, double x, double y);
// int lyte_geom_get_offset_position(lyte_Geom geom, double *x, double *y);
// int lyte_geom_set_offset_rotation(lyte_Geom geom, double angle);
// int lyte_geom_get_offset_rotation(lyte_Geom geom, double *angle);
// int lyte_geom_clear_offset(lyte_Geom geom);
// int lyte_geom_get_AABB(lyte_Geom geom, double *minx, double *miny, double *maxx, double *maxy);
// // Geom IsSpace, GetSpace (TBD)
// int lyte_geom_get_class(lyte_Geom geom, lyte_GeomClass *cls);
// int lyte_geom_set_category_bit(lyte_Geom geom, int category_bit); // can have multiple. value between 0 and 63
// int lyte_geom_is_category_bit_set(lyte_Geom geom, int category_bit, bool *is_set);
// int lyte_geom_set_collide_bit(lyte_Geom geom, int collide_bit); // can have multiple. value between 0 and 63
// int lyte_geom_is_collide_bit_set(lyte_Geom geom, int collide_bit, bool *is_set);
// // Geom enable/disable (TBD)
// int lyte_new_geom_circle(lyte_Space space, double radius, lyte_Geom *geom);
// int lyte_geom_circle_set_radius(lyte_Geom geom, double radius);
// int lyte_geom_circle_get_radius(lyte_Geom geom, double *radius);
// int lyte_geom_circle_get_point_depth(lyte_Geom geom, double x, double y, double *depth); // depth: inside positive, outside negative, surface zer
// int lyte_new_geom_rect(lyte_Space space, double width, double height, lyte_Geom *geom);
// int lyte_geom_rect_set_size(lyte_Space space, double width, double height);
// int lyte_geom_rect_get_size(lyte_Space space, double *width, double *height);
// int lyte_geom_rect_get_point_depth(lyte_Geom geom, double x, double y, double *depth); // depth: inside positive, outside negative, surface zero
// // Geom other types, especially capsule and possibly heightfield
// // Geom utilities

// // collision stuff
// int lyte_coll_update_check_collisions(lyte_World world, lyte_Space space, lyte_JointGroup jointgroup);
// int lyte_coll_update_correct_drifts(lyte_Space space);

// int lyte_body_get_coll_count(lyte_Body body, int *count);
// int lyte_body_get_coll_data_at(lyte_Body body, int index, lyte_Body *body2, double *pos_x, double *pos_y, double *depth);

// // Space creation and management.. hashspace, simplespace, ... (TODO: needed for geom creation)
// int lyte_Space_cleanup(lyte_Space space);
// int lyte_new_space_simple(lyte_Space *space);
// // Space: hashspace, spaces inside other spaces etc. (TBD)
// // Space: space add/query etc. not needed? Geoms handle these once given a space ID on creation

// // JointGroup
// int _lyte_jointgroup_empty(lyte_JointGroup jointgroup);

// int lyte_JointGroup_cleanup(lyte_JointGroup jointgroup);
// int lyte_new_jointgroup(lyte_JointGroup *jointgroup);


#endif  // LYTE_CORE_H_INCLUDED
