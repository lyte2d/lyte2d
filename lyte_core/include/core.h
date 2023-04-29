#ifndef CORE_H_INCLUDED
#define CORE_H_INCLUDED

#include "api_generated.h" // types and enums

// core_state

typedef struct lyte_State {
    bool vsync;
    lyte_BlendMode blendmode;
    lyte_FilterMode filtermode;

} lyte_State;

extern lyte_State state;

// core_image

void lyte_core_image_init(void);
void lyte_core_image_cleanup(void);

int lyte_load_image(const char *path, lyte_Image *img);
int lyte_new_canvas_image(int w, int h, lyte_Image *img);
void lyte_cleanup_image(lyte_Image image);

int lyte_image_width(lyte_Image image);
int lyte_image_height(lyte_Image image);
int lyte_draw_image(lyte_Image image, int x, int y);
int lyte_draw_image_rect(lyte_Image image, int x, int y, int src_x, int src_y, int w, int h);
int lyte_set_canvas(lyte_Image image);
int lyte_reset_canvas(void);


// core_audio

void lyte_core_audio_init(void);
void lyte_core_audio_cleanup(void);

float lyte_get_mastervolume(void);
void lyte_set_mastervolume(float vol);

// music
int lyte_load_music(const char *path, lyte_Music *mus);
void lyte_cleanup_music(lyte_Music mus);

void lyte_audio_update_music_streams(); // needs to run each frame

void lyte_play_music(lyte_Music mus);
void lyte_pause_music(lyte_Music mus);
void lyte_resume_music(lyte_Music mus);
void lyte_stop_music(lyte_Music mus);
bool lyte_is_music_playing(lyte_Music mus);
float lyte_get_music_volume(lyte_Music mus);
float lyte_get_music_pan(lyte_Music mus);
float lyte_get_music_pitch(lyte_Music mus);
float lyte_get_music_length(lyte_Music mus);
float lyte_get_music_length_played(lyte_Music mus);
void lyte_set_music_volume(lyte_Music mus, float vol);
void lyte_set_music_pan(lyte_Music mus, float pan);
void lyte_set_music_pitch(lyte_Music mus, float pitch);
void lyte_seek_music(lyte_Music mus, float secs);

// sound


// core_font

void lyte_core_font_init(void);
void lyte_core_font_cleanup(void);



// core_shader



#endif  /* CORE_H_INCLUDED */
