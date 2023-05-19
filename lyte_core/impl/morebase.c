/* (c) mg */

#include "morebase.h"
#include "lyte_core.h"


#define XLOG

// #define SOKOL_LOG(s) printf(s)
#define SOKOL_LOG(s) XLOG(s)    // sokol logs

#define SGP_UNIFORM_CONTENT_SLOTS 1024
#define SGP_TEXTURE_SLOTS 8
// #define SGP_BATCH_OPTIMIZER_DEPTH 0
// #define SOKOL_VALIDATE_NON_FATAL

// #define SOKOL_IMPL // !!!!!!!moved to core_impls

#if defined(__EMSCRIPTEN__)
#include <emscripten/emscripten.h>
#include "lyte_emsc.h"
// #define SOKOL_GLES3
// #define GLFW_INCLUDE_ES3
// #else
// #define SOKOL_GLCORE33
#endif


#include <sokol_gfx.h>
#define GLFW_INCLUDE_NONE
#include <GLFW/glfw3.h>

#include <physfs.h>

#include <sokol_glue.h>
#include <sokol_gp.h>
#include <sokol_fetch.h>
#include <stdio.h> // for fprintf()
#include <stdlib.h> // for exit()
#include <math.h> // for sinf() and cosf()
#include <string.h> // memset
#include <stb_image.h>

// #define FONTSTASH_IMPLEMENTATION ///  // !!!!!!!moved to core_impls
#define FONS_USE_FREETYPE
#if defined(_MSC_VER )
#pragma warning(disable:4996)   // strncpy use in fontstash.h
#endif
#if defined(__GNUC__) || defined(__clang__)
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wunused-function"
#pragma GCC diagnostic ignored "-Wsign-conversion"
#endif
#include "fontstash.h"
#if defined(__GNUC__) || defined(__clang__)
#pragma GCC diagnostic pop
#endif

#include <raudio.h>

#include <sokol_args.h>


//
// DATA SHAPES
//


// THIS MAYBE REQUIRED ON AN OLDER VERSION OF EMSCRIPTEN
// #if defined(__EMSCRIPTEN__)
// typedef struct GLFWgamepadstate
// {
//     /*! The states of each [gamepad button](@ref gamepad_buttons), `GLFW_PRESS`
//      *  or `GLFW_RELEASE`.
//      */
//     unsigned char buttons[15*2];
//     /*! The states of each [gamepad axis](@ref gamepad_axes), in the range -1.0
//      *  to 1.0 inclusive.
//      */
//     float axes[6];
// } GLFWgamepadstate;
// #endif


//
// GLOBAL DATA
//


typedef struct ShaderInternal {
    float *_uniform_data;
    uint32_t *_uniform_images;
    bool * _uniform_image_deletes;

    uint32_t _uniform_data_count;
    uint32_t _uniform_images_count;
    uint32_t pip_id;
} ShaderInternal;

// "global"  _input
static struct {
    uint8_t keys_rep[M_NUM_KEYBOARD_KEYS];
    uint8_t keys_cur[M_NUM_KEYBOARD_KEYS];
    uint8_t keys_prev[M_NUM_KEYBOARD_KEYS];
    uint8_t mousebuttons_cur[M_NUM_MOUSEBUTTONS];
    uint8_t mousebuttons_prev[M_NUM_MOUSEBUTTONS];
    float mouse_x, mouse_y;


    // these two are handled by joystick connet/disconnect events
    uint8_t joystick_connected[M_NUM_JOYSTICKS];
    struct {
        int joystick_id;
        bool is_gamepad;
        const char *name;
    } gamepad_info[M_NUM_JOYSTICKS];
    GLFWgamepadstate gamepad_states_prev[M_NUM_JOYSTICKS];
    GLFWgamepadstate gamepad_states_cur[M_NUM_JOYSTICKS];

} __m_input_data = {0}, *_input = &__m_input_data;

// "global"  (to be _time)
static double curr_t, delta_time, last_t;

// "global"  _lib
static struct {
    bool quit;
    void *app_data;
    M_TickFunc tick_fn;
    GLFWwindow* window;
    GLFWmonitor* monitor;
    bool fullscreen;
    bool fullscreen_next;
    int last_xpos, last_ypos;  // before fullscreen
    int last_width_whole, last_height_whole;  // before fullscreen
    int width, height;
    bool vsync;
    M_BlendMode defaultblendmode;
    M_BlendMode blendmode;
    M_FilterMode defaultfiltermode;
    M_FilterMode filtermode;
    float padding_left;
    float padding_right;
    float padding_top;
    float padding_bottom;
    float margin_left;
    float margin_right;
    float margin_top;
    float margin_bottom;
    M_Image current_canvas;
    float current_color[4];
    GLFWvidmode* mode;
    M_ShaderDef shaderdefs[M_MAX_SHADERDEFS];
    uint32_t last_shaderid;
    ShaderInternal *_current_shader;
} __m_lib_data = {0}, *_lib = &__m_lib_data;

// "global"  _fs
static struct {
    struct {
        const char *name;
        const char *mount_path;
        const char *physical_path;
        uint8_t *buf;
        size_t buffer_size;
        bool done;
        bool exists;
        int error;
    } path_info[M_FILESYSTEM_MAX_PATHS];
    int current_idx;
} __m_filesystem_data = {0}, *_fs = &__m_filesystem_data;


//
// (WIP: audio)
//

static struct {
    float master_volume;

    struct MusicInfo {
        uint32_t id;
        Music music;
        float volume;
        float pan;
        float pitch;
        void *data;
        size_t data_size;
    } *music_items;
    size_t num_musicinfo_items;
    int next_musicinfo_index;
    uint32_t last_music_id;

    struct SoundInfo {
        uint32_t id;
        Wave wave;
        float volume;
        float pan;
        float pitch;
        void *data;
        size_t data_size;
        struct ChannelInfo {
            bool in_use;
            Sound sound;
            float volume;
            float pan;
            float pitch;
        } *channels;
        int num_channels;
    } *sound_items;
    size_t num_soundinfo_items;
    int next_soundinfo_index;
    uint32_t last_sounddatainfo_id;

} __m_audio_data = {0}, *_audio = &__m_audio_data;

static void audio_init() {
    InitAudioDevice();
    if (!IsAudioDeviceReady()) {
        // ASSERT(false);
    } else {
        M_app_setmastervolume(0.7);

        _audio->num_musicinfo_items = MAX_MUSIC_ITEMS;
        _audio->music_items = malloc(sizeof(struct MusicInfo)*_audio->num_musicinfo_items);
        memset(_audio->music_items, 0, sizeof(struct MusicInfo)*_audio->num_musicinfo_items);

        _audio->num_soundinfo_items = MAX_SOUNDDATA_ITEMS;
        _audio->sound_items = malloc(sizeof(struct SoundInfo)*_audio->num_soundinfo_items);
        memset(_audio->sound_items, 0, sizeof(struct SoundInfo)*_audio->num_soundinfo_items);

    }
}

static void audio_cleanup() {
    CloseAudioDevice();
    for (int i=0; i<_audio->num_soundinfo_items; i++) {
        if(_audio->sound_items[i].id != 0) {
            M_sounddata_cleanup((M_SoundData){.id=_audio->sound_items[i].id}); // it'll clean it's own channels
        }
    }
    for (int i=0;i<_audio->num_musicinfo_items; i++) {
        if(_audio->music_items[i].id != 0) {
            M_music_cleanup((M_Music){.id=_audio->music_items[i].id});
        }
    }
    free(_audio->sound_items);
    _audio->num_soundinfo_items = 0;
    free(_audio->music_items);
    _audio->num_musicinfo_items = 0;
}

static void audio_add_musicinfo(struct MusicInfo info) {
    // ASSERT_(_audio->next_musicinfo_index < _audio->num_musicinfo_items, "Too many music files!");
    _audio->music_items[_audio->next_musicinfo_index++] = info;
}

static struct MusicInfo *audio_find_musicinfo(uint32_t id) {
    struct MusicInfo *info = NULL;
    for (int i=0; i<_audio->num_musicinfo_items; i++) {
        struct MusicInfo *mi = &_audio->music_items[i];
        if (mi->id == id) {
            info = mi;
            break;
        }
    }
    return info;
}

static void audio_add_sounddatainfo(struct SoundInfo info) {
    // ASSERT_(_audio->next_soundinfo_index < _audio->num_soundinfo_items, "Too many sound files!");
    _audio->sound_items[_audio->next_soundinfo_index++] = info;
}


static struct SoundInfo *audio_find_sounddatainfo(uint32_t id) {
    struct SoundInfo *info = NULL;
    for (int i=0; i<_audio->num_soundinfo_items; i++) {
        struct SoundInfo *si = &_audio->sound_items[i];
        if (si->id == id) {
            info = si;
            break;
        }
    }
    return info;
}


static void audio_dowork() {
    // update music if any;
    for (int i=0; i<_audio->num_musicinfo_items; i++) {
        struct MusicInfo *mi = &_audio->music_items[i];
        if (mi->id != 0) {
            if (IsMusicStreamPlaying(mi->music)) {
                UpdateMusicStream(mi->music);
                UpdateMusicStream(mi->music);
                UpdateMusicStream(mi->music);
                UpdateMusicStream(mi->music);
            }
        }
    }

    // if (_audio->current_music_item) {
    //     // printf("looping: %d sb: %zu\n",_audio->current_music_item->music.looping, _audio->current_music_item->music.stream.buffer);
    //     for (int i = 0; i<  NUM_MUSICSTREAMUPDATES_PER_FRAME; i++) {
    //         UpdateMusicStream(_audio->current_music_item->music);
    //     }
    // }
}

static inline const char *audio_getfiletypewithdot(const char *path) {
    return &path[strlen(path)-4];
}


M_SoundData M_newsounddata_load(const char *path) {
    struct SoundInfo sndinfo = {0};
    sndinfo.id = ++_audio->last_sounddatainfo_id;
    sndinfo.volume = 1.0;
    sndinfo.pitch = 1.0;
    sndinfo.pan = 0.5;

    PHYSFS_Stat stat;
    PHYSFS_stat(path, &stat);
    size_t data_size = stat.filesize; // TODO same logic for image and font loading too. should be an api so that while using readbytes one can know what to send
    uint8_t *data = malloc(data_size);
    memset(data, 0, data_size);
    size_t read_size  = M_path_readbytes(path, data, data_size);
    // ASSERT_(data_size == read_size, "sound loading: readbytes. read size doesn't match file size.");
    const char *format = audio_getfiletypewithdot(path);
    Wave wave =  LoadWaveFromMemory(format, data, data_size);
    sndinfo.data = data;
    sndinfo.data_size = data_size;
    sndinfo.wave = wave;

    sndinfo.num_channels = MAX_SOUNDCHANNEL_PER_SOUNDDATA;
    sndinfo.channels = malloc(sizeof(struct ChannelInfo)*sndinfo.num_channels);
    memset(sndinfo.channels, 0, sizeof(struct ChannelInfo)*sndinfo.num_channels);
    // for(int i=0; i< sndinfo.num_channels; i++) {

    //     // nothing to do, really; memory in place, M_newsound will handle data.
    // }

    audio_add_sounddatainfo(sndinfo);
    M_SoundData snd = (M_SoundData){.id = sndinfo.id};
    return snd;
}

void M_sounddata_cleanup(M_SoundData sounddata) {
    struct SoundInfo *info = audio_find_sounddatainfo(sounddata.id);
    if (info) {
        if (info->channels) {
            for(int i=0; i< info->num_channels; i++) {
                if (info->channels[i].in_use) {
                    M_Sound ch = {0};
                    ch.data_id = sounddata.id;
                    ch.channel_idx = i;
                    M_sound_cleanup(ch);
                }
            }
            free(info->channels);
            info->channels = NULL;
        }
        if (info->data)
        {
            free(info->data);
            info->data = NULL;
        }
        // UnloadWave(info->wave);
    }
}

float M_sounddata_get_volume(M_SoundData sound) {
    struct SoundInfo *info = audio_find_sounddatainfo(sound.id);
    return info->volume;
}
void M_sounddata_set_volume(M_SoundData sound, float volume) {
    struct SoundInfo *info = audio_find_sounddatainfo(sound.id);
    info->volume = volume;
}
float M_sounddata_get_pitch(M_SoundData sound) {
    struct SoundInfo *info = audio_find_sounddatainfo(sound.id);
    return info->pitch;
}
void M_sounddata_set_pitch(M_SoundData sound, float pitch) {
    struct SoundInfo *info = audio_find_sounddatainfo(sound.id);
    info->pitch = pitch;
}
float M_sounddata_get_pan(M_SoundData sound) {
    struct SoundInfo *info = audio_find_sounddatainfo(sound.id);
    return info->pan;
}
void M_sounddata_set_pan(M_SoundData sound, float pan) {
    struct SoundInfo *info = audio_find_sounddatainfo(sound.id);
    info->pan = pan;
}

M_Sound M_newsound(M_SoundData sounddata) {
    struct SoundInfo *info = audio_find_sounddatainfo(sounddata.id);
    struct ChannelInfo *chinfo = NULL;
    int chinfo_idx = -1;
    for (int i=0; i<info->num_channels; i++) {
        if (!info->channels[i].in_use) {
            chinfo = &info->channels[i];
            chinfo_idx = i;
            break;
        }
    }
    if (chinfo) {
        chinfo->volume = info->volume;
        chinfo->pan = info->pan;
        chinfo->pitch = info->pitch;
        chinfo->sound = LoadSoundFromWave(info->wave);
        SetSoundVolume(chinfo->sound, chinfo->volume);
        SetSoundPan(chinfo->sound, chinfo->pan);
        SetSoundPitch(chinfo->sound, chinfo->pitch);
        chinfo->in_use = true;
    } else {
        // ASSERT(false);
    }
    M_Sound ch = (M_Sound){
        .data_id = info->id,
        .channel_idx = chinfo_idx,
    };
    return ch;
}

void M_sound_cleanup(M_Sound sound) {
    struct SoundInfo *info = audio_find_sounddatainfo(sound.data_id);
    struct ChannelInfo *chinfo = &info->channels[sound.channel_idx];
    if (chinfo->in_use) {
        UnloadSound(chinfo->sound);
        chinfo->in_use = false;
    }
}

float M_sound_get_volume(M_Sound sound) {
    struct SoundInfo *info = audio_find_sounddatainfo(sound.data_id);
    struct ChannelInfo *chinfo = &info->channels[sound.channel_idx];
    return chinfo->volume;
}
void M_sound_set_volume(M_Sound sound, float volume) {
    struct SoundInfo *info = audio_find_sounddatainfo(sound.data_id);
    struct ChannelInfo *chinfo = &info->channels[sound.channel_idx];
    chinfo->volume = volume;
    SetSoundVolume(chinfo->sound, volume);
}
float M_sound_get_pitch(M_Sound sound) {
    struct SoundInfo *info = audio_find_sounddatainfo(sound.data_id);
    struct ChannelInfo *chinfo = &info->channels[sound.channel_idx];
    return chinfo->pitch;
}
void M_sound_set_pitch(M_Sound sound, float pitch) {
    struct SoundInfo *info = audio_find_sounddatainfo(sound.data_id);
    struct ChannelInfo *chinfo = &info->channels[sound.channel_idx];
    chinfo->pitch = pitch;
    SetSoundPitch(chinfo->sound, pitch);
}
float M_sound_get_pan(M_Sound sound) {
    struct SoundInfo *info = audio_find_sounddatainfo(sound.data_id);
    struct ChannelInfo *chinfo = &info->channels[sound.channel_idx];
    return chinfo->pan;
}
void M_sound_set_pan(M_Sound sound, float pan) {
    struct SoundInfo *info = audio_find_sounddatainfo(sound.data_id);
    struct ChannelInfo *chinfo = &info->channels[sound.channel_idx];
    chinfo->pan = pan;
    SetSoundPan(chinfo->sound, pan);
}

void M_sound_play(M_Sound sound) {
    struct SoundInfo *info = audio_find_sounddatainfo(sound.data_id);
    struct ChannelInfo *chinfo = &info->channels[sound.channel_idx];
    if (chinfo->in_use) {
        PlaySound(chinfo->sound);
    } else {
        // ASSERT(false);
    }
}

void M_sound_pause(M_Sound sound) {
    struct SoundInfo *info = audio_find_sounddatainfo(sound.data_id);
    struct ChannelInfo *chinfo = &info->channels[sound.channel_idx];
    PauseSound(chinfo->sound);
}
void M_sound_resume(M_Sound sound) {
    struct SoundInfo *info = audio_find_sounddatainfo(sound.data_id);
    struct ChannelInfo *chinfo = &info->channels[sound.channel_idx];
    ResumeSound(chinfo->sound);
}
void M_sound_stop(M_Sound sound) {
    struct SoundInfo *info = audio_find_sounddatainfo(sound.data_id);
    struct ChannelInfo *chinfo = &info->channels[sound.channel_idx];
    StopSound(chinfo->sound);
}

bool M_sound_isplaying(M_Sound sound) {
    struct SoundInfo *info = audio_find_sounddatainfo(sound.data_id);
    struct ChannelInfo *chinfo = &info->channels[sound.channel_idx];
    if (chinfo->in_use) {
        return IsSoundPlaying(chinfo->sound);
    } else {
        // ASSERT(false);
    }
    return false;
}


// music
M_Music M_newmusic_load(const char *path) {
    struct MusicInfo musinfo = {0};
    musinfo.id = ++_audio->last_music_id;
    musinfo.volume = 1.0;
    musinfo.pitch = 1.0;
    musinfo.pan = 0.5;


    PHYSFS_Stat stat;
    PHYSFS_stat(path, &stat);
    size_t data_size = stat.filesize; // TODO same logic for image and font loading too. should be an api so that while using readbytes one can know what to send
    uint8_t *data = malloc(data_size);
    size_t read_size  = M_path_readbytes(path, data, data_size);
    // ASSERT_(data_size == read_size, "music loading: readbytes. read size doesn't match file size.");
    const char *format = audio_getfiletypewithdot(path);
    Music rm =  LoadMusicStreamFromMemory(format, data, data_size);
    // memset(data, 0, data_size); // rayaudio does NOT copy
    // free(data);

    rm.looping = true;
    musinfo.data = data;
    musinfo.data_size = data_size;
    musinfo.music = rm;

    audio_add_musicinfo(musinfo);

    M_Music mus = {.id = musinfo.id};
    return mus;
}

void M_music_cleanup(M_Music music) {
    struct MusicInfo *info = audio_find_musicinfo(music.id);
    if (info) {
        UnloadMusicStream(info->music);
        free(info->data);
        *info = (struct MusicInfo){0};
    }
}

float M_music_get_volume(M_Music music) {
    struct MusicInfo *info = audio_find_musicinfo(music.id);
    return info->volume;
}

void M_music_set_volume(M_Music music, float volume) {
    struct MusicInfo *info = audio_find_musicinfo(music.id);
    info->volume = volume;
    SetMusicVolume(info->music, volume);
}


float M_music_get_pan(M_Music music) {
    struct MusicInfo *info = audio_find_musicinfo(music.id);
    return info->pan;
}

void M_music_set_pan(M_Music music, float pan) {
    struct MusicInfo *info = audio_find_musicinfo(music.id);
    info->pan = pan;
    SetMusicPan(info->music, pan);
}

float M_music_get_pitch(M_Music music) {
    struct MusicInfo *info = audio_find_musicinfo(music.id);
    return info->pitch;
}

void M_music_set_pitch(M_Music music,float pitch) {
    struct MusicInfo *info = audio_find_musicinfo(music.id);
    info->pitch = pitch;
    SetMusicPitch(info->music, pitch);
}


void M_music_play(M_Music music) {
    struct MusicInfo *info = audio_find_musicinfo(music.id);
    // ASSERT(info);
    info = info;
    PlayMusicStream(info->music);
}

void M_music_pause(M_Music music) {
    struct MusicInfo *info = audio_find_musicinfo(music.id);
    PauseMusicStream(info->music);
}

void M_music_resume(M_Music music) {
    struct MusicInfo *info = audio_find_musicinfo(music.id);
    ResumeMusicStream(info->music);
}

void M_music_stop(M_Music music) {
    struct MusicInfo *info = audio_find_musicinfo(music.id);
    StopMusicStream(info->music);
    info = NULL;
}

bool M_music_isplaying(M_Music music) {
    struct MusicInfo *info = audio_find_musicinfo(music.id);
    return (info != NULL && IsMusicStreamPlaying(info->music));
}

void M_music_seek(M_Music music,float secs) {
    struct MusicInfo *info = audio_find_musicinfo(music.id);
    SeekMusicStream(info->music, secs);
}

float M_music_get_length(M_Music music) {
    struct MusicInfo *info = audio_find_musicinfo(music.id);
    return GetMusicTimeLength(info->music);
}

float M_music_get_length_played(M_Music music) {
    struct MusicInfo *info = audio_find_musicinfo(music.id);
    return GetMusicTimePlayed(info->music);
}



void M_app_setmastervolume(float volume) {
    _audio->master_volume = volume;
    SetMasterVolume(volume);
}
float M_app_getmastervolume() {
    return _audio->master_volume;
}


struct {
    struct FontInfo {
        FONScontext* fons;
        int font;
        int atlas_dim;
        uint32_t id;
        float fntsize;
    } *font_items;
    struct FontInfo *current_font_item;
    int num_fontinfos;
    int next_fontinfo_index;
    int last_fontinfo_id;
} __m_font_data, *_fontdata = &__m_font_data;


static void font_init() {
    _fontdata->num_fontinfos = MAX_FONT_ITEMS;
    _fontdata->font_items = malloc(sizeof(struct FontInfo)*_fontdata->num_fontinfos);
    memset(_fontdata->font_items, 0, sizeof(struct FontInfo)*_fontdata->num_fontinfos);
}

static void font_cleanup() {
    for (int i=0; i<_fontdata->num_fontinfos; i++) {
        if (_fontdata->font_items[i].id != 0) {
            M_font_cleanup((M_Font){.id=_fontdata->font_items[i].id});
            _fontdata->font_items[i] = (struct FontInfo){0};
        }
    }
    free(_fontdata->font_items);
    _fontdata->num_fontinfos = 0;
}

static struct FontInfo *font_find_fontinfo(uint32_t id) {
    struct FontInfo *info = NULL;
    for (int i=0; i<_fontdata->num_fontinfos; i++) {
        if (_fontdata->font_items[i].id == id) {
            info = &_fontdata->font_items[i];
            break;
        }
    }
    return info;
}

static void font_add_fontinfo(struct FontInfo info) {
    // ASSERT_(_fontdata->next_fontinfo_index < _fontdata->num_fontinfos,"Too many font files!");
    _fontdata->font_items[_fontdata->next_fontinfo_index++] = info;
}


static int fons__renderCreate(void* userPtr, int width, int height) {

    return 1;
}

static int fons__renderResize(void* userPtr, int width, int height) {
	// Reuse create to resize too.
	return fons__renderCreate(userPtr, width, height);
}

static void fons__renderUpdate(void* userPtr, int* rect, const unsigned char* data) {
    // note leaking right now!!

    M_Image *c = (M_Image *)userPtr;
    sg_image_desc imdesc = (sg_image_desc) {
        .width = c->width,
        .height = c->height,
        // .pixel_format = SG_PIXELFORMAT_R8,
        .pixel_format = SG_PIXELFORMAT_RGBA8,
        // .min_filter = SG_FILTER_LINEAR,
        // .mag_filter = SG_FILTER_LINEAR,
        .min_filter = (sg_filter)_lib->filtermode,  // filtermode for fonts
        .mag_filter = (sg_filter)_lib->filtermode,
        .type = SG_IMAGETYPE_2D,
        .usage = SG_USAGE_DYNAMIC,

    };
    // const int MINCOL = 40;
    // const int LIMCOL = 120;
    uint8_t *mydata = malloc(c->width*c->height*4);
    for(int i=0; i<c->width*c->height;i++) {
        // TODO: do this is only font is marked as "pixel"
        uint8_t val = data[i];// > MINCOL ? (data[i]>LIMCOL ? 255 : data[i]) : 0;
        mydata[i*4] = val;//   data[i] > MINCOL ? 255 : 0;
        mydata[i*4+1] = val;//  data[i] > MINCOL ? 255 : 0;
        mydata[i*4+2] = val;//  data[i] > MINCOL ? 255 : 0;
        mydata[i*4+3] = val;
        // mydata[i*4+3] = data[i] > MINCOL? 255 : 0;
    }

    sg_image img = sg_make_image(&imdesc);
    sg_image_data imdat = {0};
    imdat.subimage[0][0].ptr = mydata,
    imdat.subimage[0][0].size = c->width*c->height*4,
    sg_update_image(img, &imdat);
    c->handle = img.id;
}

static void fons__renderDraw(void* userPtr, const float* verts, const float* tcoords, const unsigned int* colors, int nverts) {
    M_Image *c = (M_Image *)userPtr;
    M_Image img = *c; //M_canvas_get_image(*c);
    sgp_set_image(0,(sg_image){.id=img.handle});
    sgp_set_blend_mode((sgp_blend_mode)_lib->blendmode);
    int W = _lib->width;
    int H = _lib->height;
    // M_image_draw(img,W/2,H/2);

    for (int i=0; i<nverts-2; i += 3) {
        int q = 0;
        float p1x = verts[(q+i)*2];
        float p1y = verts[(q+i)*2+1];
        float t1x = tcoords[(q+i)*2];
        float t1y = tcoords[(q+i)*2+1];
        q++;
        float p2x = verts[(q+i)*2];
        float p2y = verts[(q+i)*2+1];
        float t2x = tcoords[(q+i)*2];
        float t2y = tcoords[(q+i)*2+1];
        q++;
        float p3x = verts[(q+i)*2];
        float p3y = verts[(q+i)*2+1];
        float t3x = tcoords[(q+i)*2];
        float t3y = tcoords[(q+i)*2+1];

        sgp_push_transform();
        sgp_scale(1.0/M_FONT_MULT,1.0/M_FONT_MULT);
        sgp_translate(p1x,p1y);
        sgp_draw_textured_rect_ex(0, (sgp_rect){0,0,(p3x-p1x), (p3y-p1y)}, (sgp_rect){t1x*c->width, t1y*c->height, (t3x-t1x)*c->width, (t3y-t1y)*c->height});
        sgp_pop_transform();

    }
    // M_canvas_unset();
    // sgp_unset_image(0);
    sgp_reset_image(0);

}

static void fons__renderDelete(void* userPtr) {
    // remove canvas
}

FONScontext *fons_create(int width, int height, uint8_t flags) {
	FONSparams params;
    M_Image *canvas = malloc(sizeof(M_Image));
    *canvas = M_newcanvas(width, height);
    // fntc = canvas;

    if (flags == 0) {
        flags = FONS_ZERO_TOPLEFT;
    }

	memset(&params, 0, sizeof(params));
	params.width = width;
	params.height = height;
	params.flags = (unsigned char)flags;
	params.renderCreate = fons__renderCreate;
	params.renderResize = fons__renderResize;
	params.renderUpdate = fons__renderUpdate;
	params.renderDraw = fons__renderDraw;
	params.renderDelete = fons__renderDelete;
	params.userPtr = canvas;

	return fonsCreateInternal(&params);
}

void fons_destroy(FONScontext* ctx) {
	fonsDeleteInternal(ctx);
}

M_Font M_newfont_load(const char *path, float fntsize) {
    struct FontInfo info = {0};
    info.font = FONS_INVALID;
    info.id = ++_fontdata->last_fontinfo_id;
    info.atlas_dim = M_FONTATLAS_SIZE;
    info.fons = fons_create(info.atlas_dim, info.atlas_dim, 0);
    info.fntsize = fntsize * M_FONT_MULT;

    PHYSFS_Stat stat;
    PHYSFS_stat(path, &stat);
    size_t data_size = stat.filesize; // TODO same logic for image and font loading too. should be an api so that while using readbytes one can know what to send
    uint8_t *buf = malloc(data_size);
    int actual_size = M_path_readbytes(path, buf, data_size);
    // ASSERT_(data_size==actual_size, "font file load issue");

    // COMMENTED OUT TO COMPILE -- functionality now in core_font
    // info.font = fonsAddFontMem(info.fons, "sans", (void*)buf, (int)actual_size,  true);

    font_add_fontinfo(info);

    M_Font fnt = { .id = info.id };
    return fnt;
}

void M_font_cleanup(M_Font font) {
    struct FontInfo *inf = font_find_fontinfo(font.id);
    // enable these lines in core_font!
    // if (inf->fons->atlas) {
    //     fons_destroy(inf->fons);
    // }
    font.id = 0;
}

void M_font_setfont(M_Font font) {
    struct FontInfo *inf = font_find_fontinfo(font.id);
    _fontdata->current_font_item = inf;
}

M_Font M_font_getfont(void) {
    struct FontInfo *inf = _fontdata->current_font_item;
    return (M_Font){.id = inf->id};
}

M_SizeI M_font_drawtext(const char *str, int x, int y) {
    //FONTSTASHTEST
    M_SizeI size = {0};
    if (_fontdata->current_font_item) {

        FONScontext* fs = _fontdata->current_font_item->fons;
        float fntsz =  _fontdata->current_font_item->fntsize;
        fonsClearState(fs);
        float lh = 0.0f;
        if ( _fontdata->current_font_item->font != FONS_INVALID) {
            fonsSetFont(fs,  _fontdata->current_font_item->font);
            // fonsSetSize(fs, 2*16.0f*dpis);
            fonsSetSize(fs, fntsz);
            fonsVertMetrics(fs, NULL, NULL, &lh);
            fonsSetBlur(fs, 0);
            float dx = fonsDrawText(fs, x*M_FONT_MULT, (y*M_FONT_MULT+lh), str, NULL);
            size.w = (dx - x);///M_FONT_MULT;
            size.h = lh;///M_FONT_MULT;


        }
    } else {
    }
    return size;
}

M_SizeI M_font_measuretext(const char *str) {
    M_SizeI size = {0};
    if (_fontdata->current_font_item) {

        FONScontext* fs = _fontdata->current_font_item->fons;
        float fntsz =  _fontdata->current_font_item->fntsize;
        fonsClearState(fs);
        if (_fontdata->current_font_item->font != FONS_INVALID) {
            fonsSetFont(fs,  _fontdata->current_font_item->font);
            // fonsSetSize(fs, 2*16.0f*dpis);
            fonsSetSize(fs, fntsz/M_FONT_MULT);
            float w = fonsTextBounds(fs, 0, 0, str, str + strlen(str), NULL);
            float h = 0.0f;
            fonsVertMetrics(fs, NULL, NULL, &h);
            size.w = w;//M_FONT_MULT;
            size.h = h;//M_FONT_MULT;
        }
    }
    return size;
}





//
// PUBLIC API
//


double M_app_gettime(void) {
    return glfwGetTime();
}

double M_app_gettime_since(double t) {
    return glfwGetTime() - t;
}



static const char *_show_physfs_error() {
    int err = PHYSFS_getLastErrorCode();
    const char *err_str = PHYSFS_getErrorByCode(err);
    return err_str;
}

void M_filesystem_set_writepath(char *path) {
#if defined(__EMSCRIPTEN__)
    path=".";
#endif
    int success = PHYSFS_setWriteDir(path);
    if (!success) {
        int errcode = PHYSFS_getLastErrorCode();
        fprintf(stderr, "Failed to set PHYSFS write dir: %d %d, %s\n", success, errcode, PHYSFS_getErrorByCode(errcode));
        // return 5556;
    }
}


bool M_filesystem_add_localpath(const char *name, char *mount_path, const char *physical_path) {
#if defined(__EMSCRIPTEN__)
    mount_path=".";
#endif
    int success = PHYSFS_mount(mount_path, physical_path, 1);
    if (success) {
        return true;
    } else {
        _show_physfs_error();
        return false;
    }
}

int _filesystem_find_index_phys_path(const char *physical_path) {
    int idx = -1;
    for (int i = 0; i<_fs->current_idx; i++) {
        if (strcmp(_fs->path_info[i].physical_path, physical_path) == 0) {
            idx = i;
            break;
        }
    }
    return idx;
}

int _filesystem_find_index_internal_path(const char *name) {
    int idx = -1;
    for (int i = 0; i<_fs->current_idx; i++) {
        if (strcmp(_fs->path_info[i].name, name) == 0) {
            idx = i;
            break;
        }
    }
    return idx;
}

static void _filesystem_add_zippath_async_callback(const sfetch_response_t* response) {
    if (response->fetched) {
        // data has been loaded into the provided buffer, do something
        // with the data...
        const void* data = response->buffer.ptr;
        sfetch_range_t range = response->data;

        int idx = _filesystem_find_index_phys_path(response->path);
        // ASSERT_(idx>=0, "NOT FOUND.. internal issue?");

        _fs->path_info[idx].buffer_size = response->data.size;
        // realloc?

        int success = PHYSFS_mountMemory(_fs->path_info[idx].buf, _fs->path_info[idx].buffer_size, NULL, _fs->path_info[idx].name, _fs->path_info[idx].mount_path, 1);

        if (!success) {
            int errcode = PHYSFS_getLastErrorCode();
            // fprintf(stderr, "Failed to mount folder: %d %d, %s\n", success, errcode, PHYSFS_getErrorByCode(errcode));
            _fs->path_info[idx].exists = false;
        } else {
            _fs->path_info[idx].exists = true;
        }

        _fs->path_info[idx].done = true;

    } else if (response->failed) {
        // the finished flag is set both on success and failure
        // oops, something went wrong
        int idx = _filesystem_find_index_phys_path(response->path);

        switch (response->error_code) {
            case SFETCH_ERROR_FILE_NOT_FOUND: {

            } break;
            case SFETCH_ERROR_BUFFER_TOO_SMALL: {
            } break;
            default: {
            } break;
        }
        _fs->path_info[idx].done = true;
        _fs->path_info[idx].exists = false;
    } else {
    }
}

void M_filesystem_add_zippath_async(const char *name, const char *mount_path, const char *physical_fetch_path, size_t buffer_size) {
    _fs->path_info[_fs->current_idx].name = name;
    _fs->path_info[_fs->current_idx].mount_path = mount_path;
    _fs->path_info[_fs->current_idx].physical_path = physical_fetch_path;
    _fs->path_info[_fs->current_idx].buffer_size = buffer_size;
    _fs->path_info[_fs->current_idx].buf = malloc(buffer_size * 1);
    _fs->path_info[_fs->current_idx].done = false;

    sfetch_send(&(sfetch_request_t){
        .path = physical_fetch_path,
        .callback = _filesystem_add_zippath_async_callback,
        .buffer.ptr = _fs->path_info[_fs->current_idx].buf,
        .buffer.size = buffer_size,
    });
    _fs->current_idx++;
}

void M_filesystem_add_memoryzippath_withbuf(const char *name, const char *mount_path, void *buf, size_t buffer_size) {
    _fs->path_info[_fs->current_idx].name = name;
    _fs->path_info[_fs->current_idx].mount_path = mount_path;
    _fs->path_info[_fs->current_idx].physical_path = mount_path;
    _fs->path_info[_fs->current_idx].buffer_size = buffer_size;
    _fs->path_info[_fs->current_idx].buf = buf;
    _fs->path_info[_fs->current_idx].done = false;
    int idx = _fs->current_idx;
    int success = PHYSFS_mountMemory(_fs->path_info[idx].buf, _fs->path_info[idx].buffer_size, NULL, _fs->path_info[idx].name, _fs->path_info[idx].mount_path, 1);
    if (!success) {
        int errcode = PHYSFS_getLastErrorCode();
        _fs->path_info[idx].exists = false;
    } else {
        _fs->path_info[idx].exists = true;
    }
    _fs->path_info[idx].done = true;

    _fs->current_idx++;
}


bool M_filesystem_zippath_is_done(const char *name) {
    int idx = _filesystem_find_index_internal_path(name);
    if (idx < 0) {
        return false;
    } else {
        return _fs->path_info[idx].done;
    }
}

bool M_filesystem_zippath_exists(const char *name) {
    int idx = _filesystem_find_index_internal_path(name);
    if (idx < 0) {
        //printf("Warning: file is not even being downloaded: %s\n", name);
        return false;
    } else {
        // printf("File is ready at idx: %d -- done: %d\n", idx, _fs->path_info[idx].done);
        return _fs->path_info[idx].exists;
    }
}


size_t M_path_readbytes(const char *path, const uint8_t *buf, size_t buffer_size) {
    size_t len = 0;
    // printf("opening...%s\n", path);
    PHYSFS_File *file = PHYSFS_openRead(path);
    if (!file) {
        int errcode = PHYSFS_getLastErrorCode();
        const char *errstr = PHYSFS_getErrorByCode(errcode);
        // printf("File null. Issue? %s\n", errstr);
        //printf("File null. Issue? %s\n", errstr);
    } else {
        // printf("read.....\n");
        len = PHYSFS_readBytes(file, (void *)buf, buffer_size);
        // printf("close....\n");
        PHYSFS_close(file);
    }
    return len;
}

const char *M_filesystem_get_error() {
    return _show_physfs_error();
}

size_t M_path_writebytes(const char *path, uint8_t *buf, size_t buffer_size) {
    size_t len = 0;
    PHYSFS_File *file = PHYSFS_openWrite(path);
    if (!file) {
        int errcode = PHYSFS_getLastErrorCode();
        const char *errstr = PHYSFS_getErrorByCode(errcode);
        // printf("File null. Issue? %s\n", errstr);
    } else {
        len = PHYSFS_writeBytes(file, buf, buffer_size);
        PHYSFS_close(file);
    }
    return len;
}

size_t M_path_appendbytes(const char *path, uint8_t *buf, size_t buffer_size) {
    size_t len = 0;
    PHYSFS_File *file = PHYSFS_openAppend(path);
    if (!file) {
        int errcode = PHYSFS_getLastErrorCode();
        const char *errstr = PHYSFS_getErrorByCode(errcode);
        // printf("File null. Issue? %s\n", errstr);
    } else {
        len = PHYSFS_writeBytes(file, buf, buffer_size);
        PHYSFS_close(file);
    }
    return len;
}



bool M_path_exists(const char *path) {
    return PHYSFS_exists(path);
}

size_t M_path_filesize(const char *path) {
    PHYSFS_Stat stat;
    PHYSFS_stat(path, &stat);
    size_t data_size = stat.filesize;
    return data_size;
}

bool M_input_keydown(M_KeyboardKey key) {
    return _input->keys_cur[key];
}

bool M_input_keyrepeat(M_KeyboardKey key) {
    return _input->keys_rep[key];
}

bool M_input_keypressed(M_KeyboardKey key) {
    return _input->keys_cur[key] && !_input->keys_prev[key];
}

bool M_input_keyreleased(M_KeyboardKey key) {
    return !_input->keys_cur[key] && _input->keys_prev[key];
}

bool M_input_mousedown(M_MouseButton mousebut) {
    return _input->mousebuttons_cur[mousebut];
}

bool M_input_mousepressed(M_MouseButton mousebut) {
    return _input->mousebuttons_cur[mousebut] && !_input->mousebuttons_prev[mousebut];
}

bool M_input_mousereleased(M_MouseButton mousebut) {
    return !_input->mousebuttons_cur[mousebut] && _input->mousebuttons_prev[mousebut];
}

float M_input_mouse_x(void) {
    return _input->mouse_x - _lib->margin_left - _lib->padding_left;
}

float M_input_mouse_y(void) {
    return _input->mouse_y - _lib->margin_top - _lib->padding_top;
}

int M_input_numgamepads() {
    int cnt = 0;
    for (int i=0; i<M_NUM_JOYSTICKS; i++) {
        if (_input->gamepad_info[i].is_gamepad) {
            cnt++;
        }
    }
    return cnt;
}

const char *M_input_gamepadname(M_JoystickID idx) {
    return _input->gamepad_info[idx].name;
}

bool M_input_gamepaddown(M_JoystickID idx, M_GamepadButton gamepadbut) {
    return _input->gamepad_states_cur[idx].buttons[gamepadbut];
}

bool M_input_gamepadpressed(M_JoystickID idx, M_GamepadButton gamepadbut) {
    return _input->gamepad_states_cur[idx].buttons[gamepadbut] && !_input->gamepad_states_prev[idx].buttons[gamepadbut];
}

bool M_input_gamepadreleased(M_JoystickID idx, M_GamepadButton gamepadbut) {
    return !_input->gamepad_states_cur[idx].buttons[gamepadbut] && _input->gamepad_states_prev[idx].buttons[gamepadbut];
}

float M_input_gamepadaxis(M_JoystickID idx, M_GamepadAxis gamepadaxis) {
    return _input->gamepad_states_cur[idx].axes[gamepadaxis];
}

bool M_app_getfullscreen() {
    return _lib->fullscreen;
}

void M_app_setfullscreen(bool fullscreen) {
    _lib->fullscreen_next = fullscreen;
}


void _update_to_nextfullscreen() {
    bool fullscreen = _lib->fullscreen_next;
#if defined(__EMSCRIPTEN__)
    if (fullscreen) {
        emscripten_request_fullscreen("#canvas", false);
        _lib->fullscreen = true;
    } else {
        emscripten_exit_fullscreen();
        _lib->fullscreen = false;
    }
#else
    const GLFWvidmode* mode =  _lib->mode; // glfwGetVideoMode(_lib->monitor);
    // glfwSwapInterval(0);
    if (fullscreen) {
        _lib->mode = (GLFWvidmode *)mode;
        glfwGetWindowPos(_lib->window, &_lib->last_xpos, &_lib->last_ypos);

        _lib->last_width_whole = _lib->width + _lib->padding_left + _lib->padding_right;
        _lib->last_height_whole = _lib->height + _lib->padding_top + _lib->padding_bottom;
        glfwSetWindowMonitor(_lib->window, _lib->monitor,  0, 0, mode->width, mode->height, mode->refreshRate);
        _lib->fullscreen = true;
    } else {
        glfwSetWindowMonitor(_lib->window, NULL,  _lib->last_xpos, _lib->last_ypos, _lib->last_width_whole, _lib->last_height_whole, GLFW_DONT_CARE);
        _lib->fullscreen = false;
    }


#endif
}

void M_app_quit(void) {
    _lib->quit = true;
}


void M_app_setmargins(int left, int right, int top, int bottom) {
    _lib->margin_left = left;
    _lib->margin_right = right;
    _lib->margin_top = top;
    _lib->margin_bottom = bottom;
}

void M_app_setpaddings(int left, int right, int top, int bottom) {
    _lib->padding_left = left;
    _lib->padding_right = right;
    _lib->padding_top = top;
    _lib->padding_bottom = bottom;
}

// int M_app_getwindowwidth() {
//     int w, h;
// #if defined(__EMSCRIPTEN__)
//         w = emsc_width();
//         h = emsc_height();
// #else
//     glfwGetWindowSize(_lib->window, &w, &h);
// #endif
//     return w;
// }

// int M_app_getwindowheight() {
//     int w, h;
// #if defined(__EMSCRIPTEN__)
//         w = emsc_width();
//         h = emsc_height();
// #else
//     glfwGetWindowSize(_lib->window, &w, &h);
// #endif
//     return h;
// }

M_SizeI M_app_getwindowsize(void) {
    M_SizeI size = {0};
#if defined(__EMSCRIPTEN__)
        size.w = emsc_width();
        size.h = emsc_height();
#else
    glfwGetWindowSize(_lib->window, &size.w, &size.h);
#endif
    return size;
}

void M_app_setwindowsize(int w, int h) {
    glfwSetWindowSize(_lib->window, w, h);
    _lib->mode = (GLFWvidmode *)glfwGetVideoMode(_lib->monitor);
    glfwSetWindowPos(
        _lib->window,
        _lib->mode->width/2 - w/2,
        _lib->mode->height/2 - h/2);
}

void M_app_setwindowminsize(int w, int h) {
    glfwSetWindowSizeLimits(_lib->window, w, h, GLFW_DONT_CARE, GLFW_DONT_CARE);
    _lib->mode = (GLFWvidmode *)glfwGetVideoMode(_lib->monitor);
    glfwSetWindowPos(
        _lib->window,
        _lib->mode->width/2 - w/2,
        _lib->mode->height/2 - h/2);
}


bool M_app_getvsync(void) {
    return _lib->vsync;
}

void M_app_setvsync(bool vsync) {
    _lib->vsync = vsync;
    if (_lib->vsync) {
        glfwSwapInterval(1);
    } else {
        glfwSwapInterval(0);
    }
}


void  M_gfx_pushmatrix() {
    sgp_push_transform();
}
void M_gfx_popmatrix() {
    sgp_pop_transform();
}
void M_gfx_identitymatrix() {
    sgp_reset_transform();
}
void M_gfx_translate(float dx, float dy) {
    sgp_translate(dx, dy);
}
void M_gfx_rotate(float r) {
    sgp_rotate(r);
}
void M_gfx_scale(float sx, float sy) {
    sgp_scale(sx, sy);
}
void M_gfx_rotate_at(float rot, float x, float y) {
    sgp_rotate_at(rot, x, y);
}
void M_gfx_scale_at(float sx, float sy, float x, float y) {
    sgp_scale_at(sx, sy, x, y); // not
}
void M_gfx_setdefaultblendmode(M_BlendMode blendmode) {
    _lib->defaultblendmode = blendmode;
}
void M_gfx_setblendmode(M_BlendMode blendmode) {
    _lib->blendmode = blendmode;
    sgp_set_blend_mode((sgp_blend_mode)_lib->blendmode);
}
void M_gfx_resetblendmode() {
    _lib->blendmode = _lib->defaultblendmode;
    sgp_set_blend_mode((sgp_blend_mode)_lib->blendmode);
}
void M_gfx_setdefaultfiltermode(M_FilterMode filtermode) {
    _lib->defaultfiltermode = filtermode;
}
void M_gfx_setfiltermode(M_FilterMode filtermode) {
    _lib->filtermode = filtermode;
}
void M_gfx_resetfiltermode(void) {
    _lib->filtermode = _lib->defaultfiltermode;
}





M_Image M_newcanvas(int w, int h) {
    M_Image canvas = {.width = w, .height = h, .is_canvas = true};

    // create frame buffer image
    sg_image_desc fb_image_desc = {0};
    // memset(&fb_image_desc, 0, sizeof(sg_image_desc));
    fb_image_desc.render_target = true;
    fb_image_desc.width = w;
    fb_image_desc.height = h;
    // fb_image_desc.min_filter = SG_FILTER_LINEAR;
    // fb_image_desc.mag_filter = SG_FILTER_LINEAR;
    fb_image_desc.min_filter = (sg_filter)_lib->filtermode; // filtermode for canvas
    fb_image_desc.mag_filter = (sg_filter)_lib->filtermode;
    fb_image_desc.wrap_u = SG_WRAP_CLAMP_TO_EDGE;
    fb_image_desc.wrap_v = SG_WRAP_CLAMP_TO_EDGE;
    sg_image fb_image = sg_make_image(&fb_image_desc);
    if(sg_query_image_state(fb_image) != SG_RESOURCESTATE_VALID) {
        fprintf(stderr, "Failed to create frame buffer image\n");
        exit(-1);
    }
    canvas.handle = fb_image.id;

    // create frame buffer depth stencil
    sg_image_desc fb_depth_image_desc = {0};
    // memset(&fb_depth_image_desc, 0, sizeof(sg_image_desc));
    fb_depth_image_desc.render_target = true;
    fb_depth_image_desc.width = w;
    fb_depth_image_desc.height = h;
    fb_depth_image_desc.pixel_format = SG_PIXELFORMAT_DEPTH_STENCIL;
    sg_image fb_depth_image = sg_make_image(&fb_depth_image_desc);
    if(sg_query_image_state(fb_depth_image) != SG_RESOURCESTATE_VALID) {
        fprintf(stderr, "Failed to create frame buffer depth image\n");
        exit(-1);
    }
    canvas.id_depth_image = fb_depth_image.id;

    // create frame buffer pass
    sg_pass_desc pass_desc = {0};
    // memset(&pass_desc, 0, sizeof(sg_pass_desc));
    pass_desc.color_attachments[0].image = fb_image;
    pass_desc.depth_stencil_attachment.image = fb_depth_image;
    sg_pass fb_pass = sg_make_pass(&pass_desc);
    if(sg_query_pass_state(fb_pass) != SG_RESOURCESTATE_VALID) {
        fprintf(stderr, "Failed to create frame buffer pass\n");
        exit(-1);
    }
    canvas.id_pass = fb_pass.id;
    return canvas;
}

void M_canvas_cleanup(M_Image canvas) {
    sg_image fb_image;
    fb_image = (sg_image){.id=canvas.handle};
    sg_destroy_image(fb_image);

    if (canvas.is_canvas) {
        sg_image fb_depth_image;
        sg_pass fb_pass;
        fb_depth_image = (sg_image){.id=canvas.id_depth_image};
        fb_pass = (sg_pass){.id=canvas.id_pass};
        sg_destroy_image(fb_depth_image);
        sg_destroy_pass(fb_pass);
    }
}

// // TODO remove
// M_CanvasImage M_canvas_get_image(M_CanvasImage canvas) {
//     // M_Image img = {.width = canvas.width, .height = canvas.height, .handle = canvas.handle};
//     // return img;
//     return canvas;
// }

void M_canvas_set(M_Image canvas) {
    if (!canvas.is_canvas) {
        printf("Only images that are created as a canvas can be set.");
        exit(0); // TODO error handling overall
    }
    _lib->current_canvas = canvas;
    sgp_begin(canvas.width, canvas.height);
    sgp_set_blend_mode((sgp_blend_mode)_lib->blendmode);
    sgp_scale(1.0, -1.0);
    sgp_translate(0, -canvas.height);
    sgp_push_transform();
    // sgp_project(0, 128, 128, 0);
    // draw_triangles();
}


void M_canvas_unset(void) {
    sgp_pop_transform();
    sg_pass canvas_pass = (sg_pass){.id=_lib->current_canvas.id_pass};
    sg_pass_action pass_action;
    memset(&pass_action, 0, sizeof(sg_pass_action));
    pass_action.colors[0].action = SG_ACTION_CLEAR;
    pass_action.colors[0].value.r = 1.0f;
    pass_action.colors[0].value.g = 1.0f;
    pass_action.colors[0].value.b = 1.0f;
    // pass_action.colors[0].value.a = 0.2f;
    pass_action.colors[0].value.a = 1.0f;
    sg_begin_pass(canvas_pass, &pass_action);
    sgp_flush();
    sgp_end();
    sg_end_pass();

}


bool M_image_is_canvas(M_Image image) {
    return image.is_canvas;
}

// shader

#if !defined(__EMSCRIPTEN__)
static const char *shader_header = "\n\n#version 330\n// ---\n\n";
// static const char *shader_header = "#version 330 core\n// ---\n";
#else
static const char *shader_header = "#version 300 es\nprecision highp float;\n// ---\n";
//static const char *shader_header = "#version 300 es\nprecision mediump float;\n// ---\n";
// static const char *shader_header = "\n\n#version 300 es\n// ---\n\n";
#endif

static const char *vert_footer = "\n// ---\nvoid main() { vert_main(); }\n";
static const char *frag_footer = "\n// ---\nvoid main() { frag_main(); }\n";
static const char *frag_header_1 = "uniform sampler2D current_image;\n";
static const char *frag_header_2 = "uniform vec4 current_color;\n";
static const char *frag_sep = "// ---\n\n";

static inline char *_get_uniforms_text(struct M_UniformDef *uniforms, size_t num_uniforms) {

    char *ret = malloc(256*(num_uniforms+1)); // freed in new shader;
                                          //
    sprintf(ret, "// uniform declarations...\n");
    for (int i=0; i<num_uniforms;i++) {
        const char *type = NULL;
        M_UniformType utype = uniforms[i].type;
        switch (utype) {
            case M_UNIFORM_FLOAT: {type = "float";} break;
            case M_UNIFORM_FLOAT2: {type = "vec2";} break;
            case M_UNIFORM_FLOAT3: {type = "vec3";} break;
            case M_UNIFORM_FLOAT4: {type = "vec4";} break;
            case M_UNIFORM_INT: {type = "int";} break;
            case M_UNIFORM_INT2: {type = "ivec3";} break;
            case M_UNIFORM_INT3: {type = "ivec3";} break;
            case M_UNIFORM_INT4: {type = "ivec4";} break;
            case M_UNIFORM_MAT4: {type = "mat4";} break;
            case M_UNIFORM_SAMPLER2D: {type = "sampler2D";} break;
            default: {
                printf("Unknown uniform type: %d", utype);
                exit(1);
            } break;
        }
        const char *name = uniforms[i].name;
        sprintf(ret+strlen(ret), "uniform %s %s;\n", type, name);
    }
    return ret;
}

static inline char *_get_vert_code(const char *str, const char *uniforms_text) {
    size_t orig_len = strlen(str);
    size_t new_len = orig_len + 1000;
    char *ret = malloc(new_len); // freed in new_shader
    memset(ret, 0, new_len);
    // printf("VERT: %s%s%s", shader_header, str, vert_footer);
    // sprintf(ret, "%s", str);
    sprintf(ret, "%s%s%s%s%s%s", shader_header, uniforms_text, frag_sep, str, frag_sep, vert_footer);
    return ret;
}

static inline char *_get_frag_code(const char *str, const char *uniforms_text) {
    size_t orig_len = strlen(str);
    size_t new_len = orig_len + 1000;
    char *ret =malloc(new_len); // freed in newshader
    memset(ret, 0, new_len);
    // printf("FRAG: %s%s%s%s%s", shader_header, frag_header_1, frag_header_2, frag_header_3, str, frag_footer);
    // sprintf(ret, "%s", str);
    sprintf(ret, "%s%s%s%s%s%s%s%s", shader_header, frag_header_1, frag_header_2, frag_sep, uniforms_text, frag_sep, str, frag_footer);
    return ret;
}

static inline int _get_uniform_count(M_UniformType t) {
    int ret = 0;
    switch (t) {
            case M_UNIFORM_FLOAT:
            case M_UNIFORM_INT: { ret = 1; } break;
            case M_UNIFORM_FLOAT2:
            case M_UNIFORM_INT2: { ret = 2; } break;
            case M_UNIFORM_FLOAT3:
            case M_UNIFORM_INT3: { ret = 3; } break;
            case M_UNIFORM_FLOAT4:
            case M_UNIFORM_INT4: { ret = 4; } break;
            case M_UNIFORM_MAT4: { ret = 16; } break;
            case M_UNIFORM_INVALID:
            case M_UNIFORM_SAMPLER2D: { ret = 0; } break;

    }
    return ret;
}


M_ShaderDef *M_shaderdef_find(uint32_t shader_id) {
    struct M_ShaderDef *def = NULL;
    for (size_t i=0; i<M_MAX_SHADERDEFS; i++) {
        if (_lib->shaderdefs[i]._shader_id == shader_id) {
            def = &_lib->shaderdefs[i];
            break;
        }
    }
    return def;
}


// static void shader_init_shaderdef(M_ShaderDef *def) {
//     uint32_t id = def->_shader_id;
//     // memcpy(&_lib->shaderdefs[id], def, sizeof(M_ShaderDef));
//     _lib->shaderdefs[id]._shader_id = id;
//     _lib->shaderdefs[id]._impl = malloc(sizeof(ShaderInternal)); // free in cleanup_shader
//     return;
// }



M_ShaderDef *M_shaderdef_create() {
    uint32_t id = 0;
    for (size_t i=0; i<M_MAX_SHADERDEFS; i++) {
        if (_lib->shaderdefs[i]._shader_id == 0) {
            id = _lib->last_shaderid++;
            // memcpy(&_lib->shaderdefs[i], def, sizeof(M_ShaderDef));
            _lib->shaderdefs[i]._shader_id = id;
            _lib->shaderdefs[i]._impl = malloc(sizeof(ShaderInternal)); // free in cleanup_shader
            _lib->shaderdefs[i].uniforms = NULL;
            _lib->shaderdefs[i].num_uniforms = 0;

            // _lib->last_shaderid = id;
            break;
        }
    }
    M_ShaderDef *dest = M_shaderdef_find(id);
    dest->uniforms = NULL;
    dest->num_uniforms = 0;
    // shader_init_shaderdef(dest);
    return dest;
}

void M_shaderdef_uniform(M_ShaderDef *shaderdef, const char *name, M_UniformType type) {
    int i = shaderdef->num_uniforms;
    shaderdef->num_uniforms++;
    shaderdef->uniforms = (void *)realloc(shaderdef->uniforms , shaderdef->num_uniforms * sizeof(struct M_UniformDef));
    shaderdef->uniforms[i].name = name;
    shaderdef->uniforms[i].type = type;

}

void M_shaderdef_vertex(M_ShaderDef *shaderdef, const char *code) {
    // M_ShaderDef *dest = shader_find_shaderdef(shaderdef->_shader_id);
    // dest->vert = code;
    shaderdef->vert = code;
}

void M_shaderdef_fragment(M_ShaderDef *shaderdef, const char *code) {
    // M_ShaderDef *dest = shader_find_shaderdef(shaderdef->_shader_id);
    // dest->frag = code;
    shaderdef->frag = code;
}

// static sg_pipeline _shader_pip;
// static float _uniform_vals[SGP_TEXTURE_SLOTS] = {0};
// size_t _total_uniforms_size = 0;

M_Shader M_newshader(M_ShaderDef *shaderdef) {
    // uint32_t id = shaderdef->_shader_id;
    // if (id == 0) {
    //     printf("Can't add more shaders, Max number reached: %d\n", M_MAX_SHADERDEFS);
    //     exit(-1);
    // }
    // shader_init_shaderdef(shaderdef);


    M_Shader shader = { .id = shaderdef->_shader_id };

    const char *frag_code = shaderdef->frag;
    const char *vert_code = shaderdef->vert;
    struct M_UniformDef *uniforms = shaderdef->uniforms;
    size_t num_uniforms = shaderdef->num_uniforms;

    const char *uniforms_text = _get_uniforms_text(uniforms, num_uniforms);
    const char *vert_code_full = _get_vert_code(vert_code, uniforms_text);
    const char *frag_code_full = _get_frag_code(frag_code, uniforms_text);


    // M_ShaderDef *_def = shader_find_shaderdef(id);
    ShaderInternal *_idef = (ShaderInternal *) shaderdef->_impl;

    _idef->_uniform_data_count = SGP_UNIFORM_CONTENT_SLOTS;
    _idef->_uniform_data = malloc(SGP_UNIFORM_CONTENT_SLOTS*sizeof(float));
    _idef->_uniform_images_count = SGP_TEXTURE_SLOTS;
    _idef->_uniform_images = malloc(SGP_TEXTURE_SLOTS*sizeof(uint32_t));
    _idef->_uniform_image_deletes = malloc(SGP_TEXTURE_SLOTS*sizeof(bool));

    memset(_idef->_uniform_data, 0, SGP_UNIFORM_CONTENT_SLOTS*sizeof(float));
    memset(_idef->_uniform_images, 0, SGP_TEXTURE_SLOTS*sizeof(uint32_t));
    memset(_idef->_uniform_image_deletes, 0, SGP_TEXTURE_SLOTS*sizeof(bool));

    // initialize shader pipeline
    sgp_pipeline_desc pip_desc = {0};

    pip_desc.blend_mode = (sgp_blend_mode)_lib->blendmode;

    // shader desc
    sg_shader_desc shader_desc = {0};
    shader_desc.vs.source = vert_code_full;
    shader_desc.fs.source = frag_code_full;
    shader_desc.vs.entry = "main";
    shader_desc.fs.entry = "main";
    shader_desc.label = "lyteshaderprogram";



    // default color (MAGIC name current_color)
    shader_desc.fs.uniform_blocks->uniforms[0].name = "current_color";
    shader_desc.fs.uniform_blocks->uniforms[0].type = (sg_uniform_type)M_UNIFORM_FLOAT4;
    shader_desc.fs.uniform_blocks->uniforms[0].array_count = 1;

    shader_desc.vs.uniform_blocks->uniforms[0].name = "current_color";
    shader_desc.vs.uniform_blocks->uniforms[0].type = (sg_uniform_type)M_UNIFORM_FLOAT4;
    shader_desc.vs.uniform_blocks->uniforms[0].array_count = 1;

    _idef->_uniform_data_count = 4;

    // if user calls draw_image, this is the corresponding MAGIC image name
    shader_desc.fs.images[0].name="current_image";
    shader_desc.fs.images[0].image_type=SG_IMAGETYPE_2D;
    shader_desc.fs.images[0].sampler_type=SG_SAMPLERTYPE_FLOAT;

    // shader_desc.vs.images[0].name="current_image";
    // shader_desc.vs.images[0].image_type=SG_IMAGETYPE_2D;
    // shader_desc.vs.images[0].sampler_type=SG_SAMPLERTYPE_FLOAT;

    // fill
    int img_idx = 1; // idx 0 is for current_image
    int dat_idx = 1; // idx 0..3 (float4) is for current_color
    // enumerate other uniforms

    for (int i=0; i<num_uniforms; i++) {
        const char *name = uniforms[i].name;
        M_UniformType type = uniforms[i].type;
        // this uniform should have this many elemenets
        size_t c = _get_uniform_count(type);
        uniforms[i]._num_elems = c;

        if (type > M_UNIFORM_INVALID && type < M_UNIFORM_SAMPLER2D) {
            uniforms[i]._loc = dat_idx-1;
            // printf("SHD: uniform types: %s: %d\n", name, type);
            // uniforms in fragment shader
            //shader_desc.fs.uniform_blocks->size
            shader_desc.fs.uniform_blocks[0].uniforms[dat_idx].name = name;
            shader_desc.fs.uniform_blocks[0].uniforms[dat_idx].type = (sg_uniform_type)type;
            shader_desc.fs.uniform_blocks[0].uniforms[dat_idx].array_count = 1;
            // uniforms in vertex shader (same)
            shader_desc.vs.uniform_blocks[0].uniforms[dat_idx].name = name;
            shader_desc.vs.uniform_blocks[0].uniforms[dat_idx].type = (sg_uniform_type)type;
            shader_desc.vs.uniform_blocks[0].uniforms[dat_idx].array_count = 1;

            _idef->_uniform_data_count += c;
            dat_idx++;
        } else if (type == M_UNIFORM_SAMPLER2D) {
            uniforms[i]._loc = img_idx;
            // printf("SHD: uniform sampler2D: %s at idx %d\n", name, img_idx);
            shader_desc.fs.images[img_idx].name=name;
            shader_desc.fs.images[img_idx].image_type=SG_IMAGETYPE_2D;
            shader_desc.fs.images[img_idx].sampler_type=SG_SAMPLERTYPE_FLOAT;
            img_idx++;
        } else {
            printf("Error: unknown uniform type: %s --> %d\n", name, type);
            exit(-1);
        }
    }

    shader_desc.fs.uniform_blocks[0].size = _idef->_uniform_data_count * 4;

    // enmumarete other sampler2Ds


    // printf("make pipeline...(total uniforms size: %d\n", _total_uniforms_size);
    pip_desc.shader = shader_desc;
    // shader.pip_id = sgp_make_pipeline(&pip_desc).id;
    _idef->pip_id = sgp_make_pipeline(&pip_desc).id;
    sg_resource_state state = sg_query_pipeline_state((sg_pipeline){.id=_idef->pip_id});
    if (state != SG_RESOURCESTATE_VALID) {
        fprintf(stderr, "Error: failed to make custom pipeline: %d\n ", state);
        exit(-1);
    }

    // printf("//=== NEW_SHADER_READY\n//VERTEX\n%s//FRAGMENT\n%s\n//================\n", vert_code_full, frag_code_full);

    free ((void *)uniforms_text);
    free ((void *)vert_code_full);
    free ((void *)frag_code_full);

    return shader;
}

// M_Shader M_newshader_load(const char *path) {
//     (void)path;
//     // TODO implement
//     const char *code = NULL;
//     printf("SHD: load shader\n");
//     M_Shader shader = M_newshader(code);
//     return shader;
// }

void M_shader_cleanup(M_Shader shader) {
    printf("SHD: cleanup shader\n");
    M_ShaderDef *def = M_shaderdef_find(shader.id);
    ShaderInternal *_idef = (ShaderInternal *) def->_impl;
    sg_destroy_pipeline((sg_pipeline){.id=_idef->pip_id});
    free(_idef->_uniform_data);
    free(_idef->_uniform_images);
    free(_idef->_uniform_image_deletes);
    free(def->_impl);

    *def = (M_ShaderDef){0};
    // remove memory allocated (check if any)
}


void _shader_update_images(M_ShaderDef *def) {
    ShaderInternal *_idef = (ShaderInternal *) def->_impl;
    // image 0 is for "current_image"
    for (int i=1; i<_idef->_uniform_images_count; i++) {
        if (_idef->_uniform_image_deletes[i]) {
            // delete{
            if (_idef->_uniform_images[i] != 0) {
                sgp_reset_image(i);
                _idef->_uniform_image_deletes[i] = false;
                _idef->_uniform_data[i] = 0;
            } else {
                // printf("       !! shouldn't happen\n");
            }
        } else {
            if (_idef->_uniform_images[i] != 0) {
                uint32_t id = _idef->_uniform_images[i];
                sg_image _sgimg = (sg_image){.id=id};
                sgp_set_image(i, _sgimg);
            }
        }
    }
}

void M_shader_set(M_Shader shader) {
    (void)shader;
    // printf("SHD: set shader\n");
    M_ShaderDef *def = M_shaderdef_find(shader.id);
    ShaderInternal *_idef = (ShaderInternal *) def->_impl;

    sgp_set_pipeline((sg_pipeline){.id=_idef->pip_id});

    // MAGIC current_color
    // TODO: correct amount of uniforms
    // store the "uniforms" state in the object
    // sgp_set_uniform(_lib->current_color, 4*4);
    // memcpy(_uniform_vals, _lib->current_color, 16);
    memcpy(_idef->_uniform_data, _lib->current_color, 16);
    // sgp_set_uniform(_uniform_vals, _total_uniforms_size);

    sgp_set_uniform(_idef->_uniform_data, _idef->_uniform_data_count*4 );
    // M_shader_send(shader, NULL, 0);
    _shader_update_images(def);
    sgp_set_blend_mode((sgp_blend_mode)_lib->blendmode);
    _lib->_current_shader = _idef;
}

void M_shader_unset(void) {
    // printf("SHD: reset shader\n");
    // TODO clean uniforms here
     sgp_reset_pipeline();
     _lib->_current_shader = NULL;
}


// void M_shader_send(M_Shader shader, M_ShaderUniform *uniforms, size_t count) {
//     M_ShaderDef *def = shader_find_shaderdef(shader.id);
//     ShaderInternal *_idef = (ShaderInternal *)def->_impl;
//     // float *_vals = _idef->_uniform_data;

//     if (def == NULL) {
//         printf("Shader definition not found: id %d\n", shader.id);
//         exit(-1);
//     }

//     if (count > def->num_uniforms) {
//         printf("Too many uniforms are sent: %zd. Expected %zd\n", count, def->num_uniforms);
//         exit(1);
//     }


//     for (int i=0; i<count; i++) {
//         M_ShaderUniform uf = uniforms[i];
//         float *uf_data = (float *)uf.data;
//         const char *uf_name = uf.name;
//         int cnt_floats = uf.count;
//         M_UniformType deftype = M_UNIFORM_INVALID;
//         int def_cnt_floats = 0;
//         int def_loc = 0;
//         bool wipe_uniform = false;

//         // find the uniform declaration (type, location, and number of elements)
//         for (int j=0; j<def->num_uniforms; j++) {
//             if (strcmp(def->uniforms[j].name, uf_name) == 0) {
//                 deftype = def->uniforms[j].type;
//                 def_cnt_floats = def->uniforms[j]._num_elems;
//                 def_loc = def->uniforms[j]._loc;
//                 break;
//             }
//         }

//         if (deftype == M_UNIFORM_INVALID) {
//             printf("Uniform definition not found for name: %s\n", uf_name);
//             exit(-1);
//         }

//         if (def_cnt_floats != cnt_floats) {
//             if (cnt_floats == 1 && uf_data[0] == 0.0f) {
//                 wipe_uniform = true;
//             } else {
//                 printf("Expecting %d numbers, but got %d for uniform: %s\n", def_cnt_floats, cnt_floats, uf_name);
//                 exit(-1);
//             }
//         }

//         if (cnt_floats == 0) {
//             // sampler2D TODO: set binding
//             M_Image *img = uf.data;

//             // sg_image _sgimg = (sg_image){.id=img->id};
//             // sgp_set_image(def_loc, _sgimg);
//             _idef->_uniform_image_deletes[def_loc] = false;
//             _idef->_uniform_images[def_loc] = img->handle;

//         } else {

//             if (wipe_uniform) {
//                 if (deftype == M_UNIFORM_SAMPLER2D) {
//                     // sgp_reset_image(def_loc);
//                     _idef->_uniform_image_deletes[def_loc] = true;

//                 } else {
//                     // memset(&_vals[def_loc+4], 0, def_cnt_floats*4);
//                     memset(& _idef->_uniform_data[def_loc+4], 0, def_cnt_floats*4);
//                 }
//             } else {
//                 // memcpy(&_vals[def_loc+4], uf_data, def_cnt_floats*4);
//                 memcpy(& _idef->_uniform_data[def_loc+4], uf_data, def_cnt_floats*4);
//             }
//         }

//     }
//     // current_color
//     memcpy(_idef->_uniform_data, _lib->current_color, 16);
//     // sgp_set_uniform(_vals, _idef->_uniform_data_count * 4);
//     sgp_set_uniform( _idef->_uniform_data, _idef->_uniform_data_count * 4);

//     _shader_update_images(def);
// }


void M_shader_send(M_Shader shader, M_ShaderUniform uf) {
    M_ShaderDef *def = M_shaderdef_find(shader.id);
    ShaderInternal *_idef = (ShaderInternal *)def->_impl;
    // float *_vals = _idef->_uniform_data;

    if (def == NULL) {
        printf("Shader definition not found: id %d\n", shader.id);
        exit(-1);
    }


    float *uf_data = (float *)uf.data;
    const char *uf_name = uf.name;
    int cnt_floats = uf.count;
    M_UniformType deftype = M_UNIFORM_INVALID;
    int def_cnt_floats = 0;
    int def_loc = 0;
    bool wipe_uniform = false;

    // find the uniform declaration (type, location, and number of elements)
    for (int j=0; j<def->num_uniforms; j++) {
        if (strcmp(def->uniforms[j].name, uf_name) == 0) {
            deftype = def->uniforms[j].type;
            def_cnt_floats = def->uniforms[j]._num_elems;
            def_loc = def->uniforms[j]._loc;
            break;
        }
    }

    if (deftype == M_UNIFORM_INVALID) {
        printf("Uniform definition not found for name: %s\n", uf_name);
        exit(-1);
    }

    if (def_cnt_floats != cnt_floats) {
        if (cnt_floats == 1 && uf_data[0] == 0.0f) {
            wipe_uniform = true;
        } else {
            printf("Expecting %d numbers, but got %d for uniform: %s\n", def_cnt_floats, cnt_floats, uf_name);
            exit(-1);
        }
    }

    if (cnt_floats == 0) {
        // sampler2D TODO: set binding
        M_Image *img = uf.data;

        // sg_image _sgimg = (sg_image){.id=img->id};
        // sgp_set_image(def_loc, _sgimg);
        _idef->_uniform_image_deletes[def_loc] = false;
        _idef->_uniform_images[def_loc] = img->handle;

    } else {

        if (wipe_uniform) {
            if (deftype == M_UNIFORM_SAMPLER2D) {
                // sgp_reset_image(def_loc);
                _idef->_uniform_image_deletes[def_loc] = true;

            } else {
                // memset(&_vals[def_loc+4], 0, def_cnt_floats*4);
                memset(& _idef->_uniform_data[def_loc+4], 0, def_cnt_floats*4);
            }
        } else {
            // memcpy(&_vals[def_loc+4], uf_data, def_cnt_floats*4);
            memcpy(& _idef->_uniform_data[def_loc+4], uf_data, def_cnt_floats*4);
        }
    }


    // current_color
    memcpy(_idef->_uniform_data, _lib->current_color, 16);
    // sgp_set_uniform(_vals, _idef->_uniform_data_count * 4);
    sgp_set_uniform( _idef->_uniform_data, _idef->_uniform_data_count * 4);

    _shader_update_images(def);
}


///////////

void M_gfx_clear(float r, float g, float b, float a) {
    sgp_set_color(r,g,b,a);
    sgp_clear();
    sgp_reset_color();
}

void M_gfx_setcolor(float r, float g, float b, float a) {
    _lib->current_color[0] = r;
    _lib->current_color[1] = g;
    _lib->current_color[2] = b;
    _lib->current_color[3] = a;

    if (!_lib->_current_shader) {
        sgp_set_color(r,g,b,a);
    } else {
        ShaderInternal *_idef = _lib->_current_shader;
        memcpy(_idef->_uniform_data, _lib->current_color, 16);
        sgp_set_uniform( _idef->_uniform_data, _idef->_uniform_data_count * 4);
    }

}

void M_gfx_resetcolor() {
    //sgp_reset_color();
    M_gfx_setcolor(1.0,1.0,1.0,1.0);
}

void M_gfx_drawpoint(float x, float y) {
    sgp_draw_point(x, y);
}

void M_gfx_drawline(float x1, float y1, float x2, float y2) {
    sgp_draw_line(x1, y1, x2, y2);
}

void M_gfx_drawrect(float x, float y, float w, float h) {
    // sgp_point points[5] = {
    //     {x, y},
    //     {x+w, y},
    //     {x+w, y+h},
    //     {x, y+h},
    //     {x, y},
    // };
    // sgp_draw_lines_strip(points, 5);


    sgp_line lines[4] = {
        (sgp_line){{x, y}, {x, y+h}},
        (sgp_line){{x, y+h}, {x+w, y+h}},
        (sgp_line){{x+w, y+h}, {x+w, y}},
        (sgp_line){{x+w, y}, {x, y+1}},
    };

    sgp_draw_lines(lines, 4);

}

void M_gfx_drawrect_filled(float x, float y, float w, float h) {
    sgp_draw_filled_rect(x, y, w, h);
}


void M_gfx_drawpoints(M_Point *points, int cnt) {
    sgp_draw_points((const sgp_point *)(void *)points, cnt);
}

void M_gfx_drawlines(M_Line *lines, int cnt) {
    sgp_draw_lines((const sgp_line *)(void *)lines, cnt);
}

void M_gfx_drawrects_filled(M_Rect *rects, int cnt) {
    sgp_draw_filled_rects((const sgp_rect *)(void *)rects, cnt);
}

void M_gfx_drawtriangles_filled(M_Triangle *triangles, int cnt) {
    sgp_draw_filled_triangles((const sgp_triangle *)(void *)triangles, cnt);
}

// static buffer size for circle drawing triangles/lines
#define _MAX_MANY_TRIS 1024

void M_gfx_drawcircle(float x, float y, float r) {
    static sgp_line lines[_MAX_MANY_TRIS];
    int count = MIN(MAX(7, 2.0f * r / M_PI), _MAX_MANY_TRIS);
    float delta_angle = 2.0*M_PI/(float)count;

    for (int i=0; i<count; i++) {
        lines[i].a.x = x + r/2.0f * sinf(i * delta_angle);
        lines[i].a.y = y - r/2.0f * cosf(i * delta_angle);

        lines[i].b.x = x + r/2.0f * sinf((i+1)* delta_angle);
        lines[i].b.y = y - r/2.0f * cosf((i+1) * delta_angle);
    }

    sgp_draw_lines(lines, count);
}

void M_gfx_drawcircle_filled(float x, float y, float r) {
    static sgp_triangle tris[_MAX_MANY_TRIS];
    int count = MIN(MAX(7, 2.0f * r / M_PI), _MAX_MANY_TRIS);
    float delta_angle = 2.0*M_PI/(float)count;

    for (int i=0; i<count; i++) {
        tris[i].a.x = x;
        tris[i].a.y = y;

        tris[i].b.x = x + r/2.0f * sinf(i * delta_angle);
        tris[i].b.y = y - r/2.0f * cosf(i * delta_angle);

        tris[i].c.x = x + r/2.0f * sinf((i+1)* delta_angle);
        tris[i].c.y = y - r/2.0f * cosf((i+1) * delta_angle);
    }

    sgp_draw_filled_triangles(tris, count);
}

// void M_gfx_drawstriplines(M_Point *pts, int cnt) {
//     sgp_draw_lines_strip((const sgp_point *)(void *)pts, cnt);
// }

// void M_gfx_drawstriptriangles_filled(M_Point *pts, int cnt) {
//     sgp_draw_filled_triangles_strip((const sgp_point *)(void *)pts, cnt);
// }


M_Image M_newimage_load(const char *path) {
    sg_image _image = {SG_INVALID_ID};;

    // TODO: size?
    uint8_t buffer[1024*1024/2]; // half meg?
    size_t len = M_path_readbytes(path, buffer, sizeof(buffer));


    int width, height, channels;
    uint8_t* data = stbi_load_from_memory(buffer, len,  &width, &height, &channels, 4);
    if(!data) {
        return (M_Image){0};
    }
    sg_image_desc image_desc;
    memset(&image_desc, 0, sizeof(sg_image_desc));
    image_desc.width = width;
    image_desc.height = height;
    image_desc.min_filter = (sg_filter)_lib->filtermode; // filtermode for images
    image_desc.mag_filter = (sg_filter)_lib->filtermode;
    // image_desc.wrap_u = SG_WRAP_REPEAT;
    // image_desc.wrap_v = SG_WRAP_REPEAT;
    image_desc.wrap_u = SG_WRAP_CLAMP_TO_EDGE;
    image_desc.wrap_v = SG_WRAP_CLAMP_TO_EDGE;
    image_desc.data.subimage[0][0].ptr = data;
    image_desc.data.subimage[0][0].size = (size_t)(width * height * 4);

    _image = sg_make_image(&image_desc);

    stbi_image_free(data);


    M_Image img = {
        .handle= _image.id,
        .width = width,
        .height = height,
        .is_canvas = false,
    };

    return img;
}

// void M_image_cleanup(M_CanvasImage image) {
//     // image.height = 0;
//     // image.width = 0;
//     sg_image img = (sg_image){.id=image.handle};
//     sg_destroy_image(img);
// }

void M_image_draw(M_Image image, float x, float y) {
    sg_image img = (sg_image){.id=image.handle};
    if (img.id != 0) {
        sgp_set_blend_mode((sgp_blend_mode)_lib->blendmode);

        sgp_set_image(0, img);
        //sgp_set_color(1,1,1,1);
        sgp_draw_textured_rect(x, y, image.width, image.height);
        sgp_reset_image(0); // todo check the channels
    }
}

void M_image_draw_rect_line(M_Image image, float x, float y, float img_x, float img_y, float rect_width, float rec_height) {
    sg_image img = (sg_image){.id=image.handle};
    //sgp_set_blend_mode(_lib->blendmode);
    if (img.id != 0) {
        // printf("draw: %f %f %f %f %f %f\n", x, y, img_x, img_y, rect_width, rec_height);

        sgp_set_image(0, img);
        //sgp_set_color(1,1,1,1);
        // sgp_draw_textured_rect(x, y, image.width, image.height);
        sgp_draw_textured_rect_ex(0, (sgp_rect){x, y, rect_width, rec_height}, (sgp_rect){img_x, img_y, rect_width, rec_height});
        sgp_reset_image(0); // todo check the channels
    }
}

//
// FRAME FUNCTION
//

// tick input helper
static inline void _tick_input_next() {
    // keyboard keys
    memcpy(_input->keys_prev, _input->keys_cur, M_NUM_KEYBOARD_KEYS);
    memset(_input->keys_rep, 0, M_NUM_KEYBOARD_KEYS);
    // mouse buttons
    memcpy(_input->mousebuttons_prev, _input->mousebuttons_cur, M_NUM_MOUSEBUTTONS);
    // gamepad/joystick states
    memcpy(_input->gamepad_states_prev, _input->gamepad_states_cur, sizeof(GLFWgamepadstate) * M_NUM_JOYSTICKS);
    for (int i=0; i<M_NUM_JOYSTICKS; i++) {
#if !defined(__EMSCRIPTEN__)
        if (glfwGetGamepadState(i, &_input->gamepad_states_cur[i])) { /* TODO: we could count num  gamepads here for convenience */
        }
#else
        // emscripten... doesn't have gamepad API for glfw. just joystics.
        int count;
        const float* axes = glfwGetJoystickAxes(i, &count);
        // printf("Num gamepad axes: Count: %d", count);
        // ASSERT_(count <= M_NUM_GAMEPADAXISES, "Too many gamepad axes. Possibly internal error.");
        for (int a=0; a<count; a++) {
            _input->gamepad_states_cur[i].axes[a] = axes[a];
        }
        const unsigned char* buttons = glfwGetJoystickButtons(i, &count);
        // printf("Num gamepad buttons: Count: %d", count);
        // ASSERT_(count <= M_NUM_GAMEPADBUTTONS*2, "Too many gamepad buttons. Possibly internal error");
        for (int a=0; a<count; a++) {
            _input->gamepad_states_cur[i].buttons[a] = buttons[a];
        }
        // MG NOTE:
        // wasm case: trigger axises in webstandards is that they are buttons.
        // so map the buttons to axises here. if pressed 1.0 if not 0.0.
        // good enough for web demos, unless your game heavily depends on trigger sensitivity
        if (_input->gamepad_states_cur[i].buttons[M_GAMEPADBUTTON_INTERNAL_LEFT_TRIGGER]) {
            _input->gamepad_states_cur[i].axes[M_GAMEPADAXIS_LEFT_TRIGGER] = 1.0;
        } else {
            _input->gamepad_states_cur[i].axes[M_GAMEPADAXIS_LEFT_TRIGGER] = 0.0;
        }
        if (_input->gamepad_states_cur[i].buttons[M_GAMEPADBUTTON_INTERNAL_RIGHT_TRIGGER]) {
            _input->gamepad_states_cur[i].axes[M_GAMEPADAXIS_RIGHT_TRIGGER] = 1.0;
        } else {
            _input->gamepad_states_cur[i].axes[M_GAMEPADAXIS_RIGHT_TRIGGER] = 0.0;
        }

#endif
    }

}


#define PERF_BEGIN() _t1 = M_app_gettime()
#define PERF_END(n) if(_prt_perf) printf("%s:\t%f\n", (n), M_app_gettime_since(_t1))


// int setting_fullscreen = 0;
// tick: used by both regular glfw and emscripten one
// that's why it's a separate function
static inline void tick(void) {
    // bool _prt_perf = M_input_keypressed(M_KEY_SEMICOLON);
    bool _prt_perf = M_input_keydown(M_KEY_SEMICOLON);
    double _t1 = 0.0;

    if (_prt_perf) {
        printf("---\n");
    }


    // PERF_BEGIN();

    // show perf when ; is down

#if defined(__EMSCRIPTEN__)
    // Note this is for emscripten case. Non-emscripten quit is handled in M_app_startloop()
    if(_lib->quit) {
        emscripten_cancel_main_loop();
    }
#endif

        /* Timing */
        curr_t = glfwGetTime();
        delta_time = curr_t - last_t;
        last_t = curr_t;

        int prev_w, prev_h;
        prev_w = _lib->width;
        prev_h = _lib->height;

        int win_w, win_h;

        float RECT_DELT_L = _lib->padding_left;
        float RECT_DELT_R = _lib->padding_right;
        float RECT_DELT_T = _lib->padding_top;
        float RECT_DELT_B = _lib->padding_bottom;

        float EMPTY_L = _lib->margin_left;
        float EMPTY_R = _lib->margin_right;
        float EMPTY_T = _lib->margin_top;
        float EMPTY_B = _lib->margin_bottom;

#if defined(__EMSCRIPTEN__)
        // _lib->width = emsc_width();
        // _lib->height = emsc_height();
        win_w = emsc_width();
        win_h = emsc_height();
#else
        glfwGetFramebufferSize(_lib->window, &win_w, &win_h);
#endif

        int fwidth = win_w - RECT_DELT_L - RECT_DELT_R;
        int fheight = win_h - RECT_DELT_T - RECT_DELT_B; // BUGG?
        _lib->width = win_w;
        _lib->height = win_h;
        bool resized = false;
        if (prev_w != _lib->width || prev_h != _lib->height) {
            resized = true;
        }

        // MG: updated now
        // // fullscreen check and update. at the end of the tick (hope this fixes tearing)
        // if (_lib->fullscreen != _lib->fullscreen_next) {
        //     // glfwSwapInterval(0);
        //     _update_to_nextfullscreen();
        //     // if (_lib->vsync) {
        //     //     glfwSwapInterval(1);
        //     // } else {
        //     //     glfwSwapInterval(0);
        //     // }
        //     // glfwSwapBuffers(_lib->window);
        // }




        sgp_begin(win_w, win_h);

        sgp_viewport(EMPTY_L, EMPTY_T, win_w-EMPTY_L-EMPTY_R, win_h-EMPTY_T-EMPTY_B);
        sgp_project(-RECT_DELT_L, fwidth+RECT_DELT_R, -RECT_DELT_T, fheight+RECT_DELT_B);
        sgp_set_blend_mode((sgp_blend_mode)lyte_state.blendmode);

        // PERF_END("head");



        PERF_BEGIN();
        M_gfx_pushmatrix();
        _lib->tick_fn(_lib->app_data, delta_time, win_w, win_h, resized, lyte_state.fullscreen);
        M_gfx_popmatrix();
        PERF_END("tick");

        // NOTE: at this point only sgp state has been changed, and sg has not
        // so for optimization, we can decide if any drawing was done or not here
        // and possibly skip all this, including swapping of buffers.
        // this way, it can be kind of like a non-immediate mode gui for app that like it

        // PERF_BEGIN();
        sg_pass_action pass_action = {0};
        sg_begin_default_pass(&pass_action, win_w, win_h);
        sgp_flush();
        sgp_end();
        sg_end_pass();
        sg_commit();
        // PERF_END("work");

        PERF_BEGIN();
        glfwSwapBuffers(_lib->window);
        PERF_END("swap");

        // PERF_BEGIN();
        // PERF_BEGIN();
        audio_dowork();

        lyte_core_audio_update_music_streams(); // new "dowork"

        lyte_core_input_update_state();

        // PERF_END("audio");
        // PERF_BEGIN();
        lyte_core_filesystem_update_tasks(); // sfetch_dowork covered here
        // sfetch_dowork();
        // PERF_END("fetch");
        // PERF_BEGIN();


        // lyte_core_input_update_statet() takes over this:
        // _tick_input_next();

        // PERF_END("input");
        // PERF_END("misc");

        // Note: this has to be the last (or after inputs at least)
        // otherwise keypressed events won't work
        // PERF_BEGIN();
        glfwPollEvents();
        // PERF_END("poll");
}

//
// CALLBACKS
//

static void cursor_position_callback(GLFWwindow* window, double xpos, double ypos) {
    _input->mouse_x = xpos;
    _input->mouse_y = ypos;
}

static void mouse_button_callback(GLFWwindow* window, int button, int action, int mods) {
    if (action == GLFW_PRESS) {
        _input->mousebuttons_cur[button] = true;
    } else if (action == GLFW_RELEASE) {
        _input->mousebuttons_cur[button] = false;
    } else {
        // ASSERT(false);
    }
}

static void joystick_callback(int jid, int event) {
    if (event == GLFW_CONNECTED) {
        _input->joystick_connected[jid] = true;
        _input->gamepad_info[jid].joystick_id = jid;
#if !defined(__EMSCRIPTEN__)
        _input->gamepad_info[jid].is_gamepad = glfwJoystickIsGamepad(jid);
        _input->gamepad_info[jid].name = _input->gamepad_info[jid].is_gamepad  ? glfwGetGamepadName(jid) : glfwGetJoystickName(jid);
#else
        _input->gamepad_info[jid].is_gamepad = true; // TODO: check if everything in webasm is gamepad or other joysticks are used too...
        _input->gamepad_info[jid].name =  glfwGetJoystickName(jid);
#endif
    } else if (event == GLFW_DISCONNECTED) {
        _input->joystick_connected[jid] = false;
#if !defined(__EMSCRIPTEN__)
        _input->gamepad_info[jid].is_gamepad = false;
#endif
        _input->gamepad_info[jid].name = "";
    }
}

static void key_callback(GLFWwindow* window, int key, int scancode, int action, int mods)
{
    if (key == GLFW_KEY_ENTER && action == GLFW_PRESS && mods&GLFW_MOD_ALT) {
        M_app_setfullscreen(!_lib->fullscreen);
    } else if (key == GLFW_KEY_BACKSPACE && action == GLFW_PRESS && mods&GLFW_MOD_ALT) {
        M_app_quit();
    } else {
        if (action == GLFW_PRESS) {
            _input->keys_cur[key] = true;
        } else if (action == GLFW_RELEASE) {
            _input->keys_cur[key] = false;
            _input->keys_rep[key] = false;
        } else if (action == GLFW_REPEAT) {
            _input->keys_rep[key] = true;
        } else {
            // ASSERT(false);
        }
    }
}

#define M_ICON_BUF_SIZE 1024*1024*2
void M_app_seticon(const char *path) {
    // stbi_load_from_memory(buf, len, )
    uint8_t *buf = malloc(M_ICON_BUF_SIZE);
    size_t read_size = M_path_readbytes(path, buf, M_ICON_BUF_SIZE);
    if (read_size <= 0) {
    } else {
        GLFWimage images[1];
        images[0].pixels = stbi_load_from_memory(buf, read_size, &images[0].width, &images[0].height, 0, 4);
        // images[0].pixels = stbi_load(config->icon, &images[0].width, &images[0].height, 4, 4); //rgba channels
        glfwSetWindowIcon(_lib->window, 1, images);
        stbi_image_free(images[0].pixels);
    }
    free(buf);
}

void M_app_settitle(const char *title) {
#if defined(__EMSCRIPTEN__)
    emscripten_set_window_title(title);
#else
    glfwSetWindowTitle(_lib->window, title);
#endif
}

bool M_app_hasarg(const char *key) {
    return sargs_exists(key);
}

const char *M_app_getarg(const char *key) {
    if (sargs_exists(key)) {
        return sargs_value(key);
    } else {
        return NULL;
    }
}

bool M_system_WASM() {
#if defined(__EMSCRIPTEN__)
    return true;
#else
    return false;
#endif
}

int M_app_init(M_Config *config) {

    lyte_core_state_init((lyte_Config){
        .vsync = config->vsync,
        .blendmode = config->defaultblendmode,
        .filtermode = config->defaultfiltermode,
        .window_title = config->title,
        .window_size = (lyte_Size){ .width=config->width, .height=config->height },
        .window_min_size = (lyte_Size){ .width=0, .height=0 },
    });

    lyte_core_filesystem_init();
    lyte_core_image_init();
    lyte_core_audio_init();
    lyte_core_font_init();
    // lyte_core_window_init();
    // lyte_core_input_innit();


    _lib->vsync = config->vsync;

    _lib->defaultblendmode = config->defaultblendmode;
    _lib->blendmode = _lib->defaultblendmode;

    _lib->defaultfiltermode = config->defaultfiltermode;
    _lib->filtermode = _lib->filtermode;


    // init: physfs. this is to use zip files as folders!
    // handled in lyte_core_filesystem_init
    // int success = PHYSFS_init("");
    // if (!success) {
    //     int errcode = PHYSFS_getLastErrorCode();
    //     fprintf(stderr, "Failed to init PHYSFS: %d %d, %s\n", success, errcode, PHYSFS_getErrorByCode(errcode));
    //     return 5555;
    // }


    // init audio
    audio_init();

    // init font system
    font_init();


    // init: sokol-fetch. this is to asynchronously retrieve files from filesystem (win/linux) or web (wasm)
    // handled in lyte_core_filesystem_init
    // sfetch_setup(&(sfetch_desc_t){0});

    sargs_setup(&(sargs_desc){
        .argc = config->argc,
        .argv = config->argv
    });



#ifndef __EMSCRIPTEN__
    bool first_arg_update = false;
    char first_arg_new[1000] = {0};

    if (config->argc>1) {
        first_arg_update = true;
        for (int i=0; i<strlen(config->argv[1]); i++) {
            if (config->argv[1][i] == '=') {
                first_arg_update = false;
                break;
            }
        }

        if (first_arg_update) {
            if (strlen(config->argv[1]) > 900) {
                fprintf(stderr, "argument too long.\n");
                exit(1);
            } else {

                sprintf(first_arg_new, "dir=%s", config->argv[1]);
                config->argv[1] = first_arg_new;
            }
        }
    } else {
        sprintf(first_arg_new, "dir=.");
        config->argc += 1;
        config->argv[1] = first_arg_new;
    }
#endif
    return 0;
}


int M_app_init_graphics(M_Config *config) {

    lyte_core_window_init();

// #if defined(__EMSCRIPTEN__)
//     emsc_init("#canvas", EMSC_TRY_WEBGL2);
//     // emsc_init("#canvas", 0);
// #endif

//     // init: glfw & opengl/gles
//     if (!glfwInit()) {
//         fprintf(stderr, "Failed to initialize glfw\n");
//         return 1111;
//     }

//     // MSAA... to change this, window needs to be reopened...
//     // glfwWindowHint(GLFW_SAMPLES, 4);

//     glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3);
//     glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 3);
//     glfwWindowHint(GLFW_OPENGL_FORWARD_COMPAT, GLFW_TRUE);
//     glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);
//     // glfwWindowHint(GLFW_DOUBLEBUFFER, GL_FALSE);
//     glfwWindowHint(GLFW_DOUBLEBUFFER, 1);
//     // glfwWindowHint(GLFW_DOUBLEBUFFER, GL_TRUE);
// #if defined(__EMSCRIPTEN__)
//     _lib->window = glfwCreateWindow(emsc_width(), emsc_height(), config->title, NULL, NULL);
//     emscripten_set_window_title(config->title);

// #else
//     _lib->window = glfwCreateWindow(config->width, config->height, config->title, NULL, NULL);
// #endif

    // // make the window current for opengl
    // glfwMakeContextCurrent(_lib->window);

    _lib->window = lyte_state.window;

    // assign a monitor to the window (primary by default)
    // todo: do we need an api to select a monitor in multi-mon settings?

    // MG: removed for now
    // _lib->monitor = glfwGetWindowMonitor(_lib->window);
    // if (!_lib->monitor) {
    //     // this is expected
    //     GLFWmonitor* primary = glfwGetPrimaryMonitor();
    //     _lib->monitor = primary;
    // } else {
    //     // _lib->fullscreen = true;
    // }

    _lib->monitor = lyte_state.monitor;

    // get the mode (for fullscreen changes)
    // _lib->mode = (GLFWvidmode *)glfwGetVideoMode(_lib->monitor);


    // removed for now

    // glfwSetWindowPos(
    //     _lib->window,
    //     _lib->mode->width/2 - config->width/2,
    //     _lib->mode->height/2 - config->height/2);

    // glfwGetWindowPos(_lib->window, &_lib->last_xpos, &_lib->last_ypos);



    // we always start windowed so that we can setup a default location for the window. here we update the whatever the user config says
    // if (config->fullscreen) {
    //     M_app_setfullscreen(true);
    // } else {
    //     M_app_setfullscreen(false);
    // }
    // // todo: there's an issue with vsync in fullscreen mode. it doesn't seeem to be in effec there. investigate.
    // if (_lib->vsync) {
    //     glfwSwapInterval(1);
    // } else {
    //     glfwSwapInterval(0);
    // }
    // // hopefully all's good!
    // if (_lib->window == NULL) {
    //     fprintf(stderr, "Failed to create glfw window\n");
    //     return 2222;
    // }

    // shader definitions
    _lib->last_shaderid = 100;
    memset(_lib->shaderdefs, 0, sizeof(M_ShaderDef)*M_MAX_SHADERDEFS);

    // // init: sokol
    // sg_desc sgdesc = {0};
    // sg_setup(&sgdesc);
    // if(!sg_isvalid()) {
    //     fprintf(stderr, "Failed to create Sokol GFX context\n");
    //     return 3333;
    // }

    // // init: sogol gp (2d abstractions for sokol)
    // // adjust the size of command buffers for your own use.
    // // TODO: make this configurable (M_MAX_VERTICES)
    // sgp_desc sgpdesc = {0};
    // sgpdesc.max_vertices = 250000;
    // sgp_setup(&sgpdesc);
    // if(!sgp_is_valid()) {
    //     fprintf(stderr, "Failed to create Sokol GP context: %s\n", sgp_get_error_message(sgp_get_last_error()));
    //     return 4444;
    // }



    // setup input callbacks for mouse cursor loc, mouse buttons, keyboard state, joystic (gamepad) connetions
    // other input state (such as gamepad buttons, axes, etc) is polled each tick.


    lyte_core_input_init();
    // takes over below:
    // glfwSetCursorPosCallback(lyte_state.window, cursor_position_callback);
    // glfwSetMouseButtonCallback(lyte_state.window, mouse_button_callback);
    // glfwSetKeyCallback(lyte_state.window, key_callback);
    // glfwSetJoystickCallback(joystick_callback);


    return 0;
}

void M_app_startloop(M_TickFunc tick_fn, void *app_data) {
    _lib->tick_fn = tick_fn;
    _lib->app_data = app_data;
    // LOOP BEGINS HERE---------------------------------------------
    #ifdef EMSCRIPTEN
    emscripten_set_main_loop(tick, 0, 1);
    #else
    while(!(glfwWindowShouldClose(_lib->window) || _lib->quit)) { tick(); }
    #endif
    // LOOP ENDS HERE------------------------------------------------
}

void M_app_cleanup() {
    // internal cleanups
    // handled in lyte_core_filesystem_cleanup
    // sfetch_shutdown();
    // PHYSFS_deinit();

    font_cleanup();
    audio_cleanup();

    lyte_core_image_cleanup();
    lyte_core_audio_cleanup();
    lyte_core_font_cleanup();
    lyte_core_window_cleanup();
    lyte_core_input_cleanup();
    lyte_core_filesystem_cleanup();

}
