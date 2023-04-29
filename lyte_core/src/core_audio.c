//

#include <stdio.h>
#include <assert.h>
#include <stdlib.h>
#include <string.h>

#include "core.h"
#include "map.h"

#include "physfs.h"

#include "raudio.h"

#ifndef INIT_NUM_MUSICITEMS
#define INIT_NUM_MUSICITEMS 10
#endif

typedef struct MusicItem {
    uint32_t handle;
    Music music;
    float volume;
    float pan;
    float pitch;
    size_t data_size;
    void *data;
} MusicItem;

static uint32_t musicitem_last_handle = 1500;
static mg_Map musicitems;
static float mastervolume;

void lyte_core_audio_init(void) {
    mg_map_init(&musicitems, sizeof(MusicItem), INIT_NUM_MUSICITEMS);

    // InitAudioDevice
}

void lyte_core_audio_cleanup(void) {
    mg_map_cleanup(&musicitems);

    // CloseAudioDevice
}


void lyte_audio_update_music_streams() {
    for (size_t i=0; i<musicitems.count; i++) {
        uint32_t key = 0;
        MusicItem *m = mg_map_getindex(&musicitems, i, &key);
        if (key != 0) {
            Music music = m->music;
            if (IsMusicStreamPlaying(music)) {
                UpdateMusicStream(music);
                UpdateMusicStream(music);
                UpdateMusicStream(music);
                UpdateMusicStream(music);
            }
        }
    }
}


int lyte_load_music(const char *path, lyte_Music *mus) {
    PHYSFS_File *file = PHYSFS_openRead(path);
    if (file == NULL) {
        int errcode = PHYSFS_getLastErrorCode();
        const char *errstr = PHYSFS_getErrorByCode(errcode);
        fprintf(stderr, "File '%s' error %s\n", path, errstr);
        return errcode;
    }
    size_t len = PHYSFS_fileLength(file);
    uint8_t *buf = malloc(len);
    size_t read_len = PHYSFS_readBytes(file, buf, len);
    if (len != read_len) {
        fprintf(stderr, "File not fully read. Path: %s. File size is %zu bytes, but read %zu bytes.\n", path, len, read_len);
        return 1;
    }
    MusicItem musicitem = {0};
    musicitem.handle = musicitem_last_handle++;
    musicitem.data = buf; // don't free! raudio does not copy the data. free at cleanup_music.
    musicitem.data_size = read_len;
    musicitem.volume = 1.0;
    musicitem.pitch = 1.0;
    musicitem.pan = 0.5;
    const char *file_extension = &path[strlen(path)-4]; // detect file format (like "mp3\0")
    musicitem.music = LoadMusicStreamFromMemory(file_extension, musicitem.data, musicitem.data_size);
    musicitem.music.looping = true;
    mg_map_set(&musicitems, musicitem.handle, &musicitem);
    mus->handle = musicitem.handle;
    PHYSFS_close(file);
    return 0;
}

void lyte_cleanup_music(lyte_Music mus) {

}

void lyte_play_music(lyte_Music mus) {
    MusicItem *musicitem = mg_map_get(&musicitems, mus.handle);
    if (!musicitem) {
        fprintf(stderr, "Music with handle %d not present\n", mus.handle);
        return;
    }
    PlayMusicStream(musicitem->music);
}

void lyte_pause_music(lyte_Music mus) {
    MusicItem *musicitem = mg_map_get(&musicitems, mus.handle);
    if (!musicitem) {
        fprintf(stderr, "Music with handle %d not present\n", mus.handle);
        return;
    }
    PauseMusicStream(musicitem->music);
}

void lyte_resume_music(lyte_Music mus) {
    MusicItem *musicitem = mg_map_get(&musicitems, mus.handle);
    if (!musicitem) {
        fprintf(stderr, "Music with handle %d not present\n", mus.handle);
        return;
    }
    ResumeMusicStream(musicitem->music);
}

void lyte_stop_music(lyte_Music mus) {
    MusicItem *musicitem = mg_map_get(&musicitems, mus.handle);
    if (!musicitem) {
        fprintf(stderr, "Music with handle %d not present\n", mus.handle);
        return;
    }
    StopMusicStream(musicitem->music);
}

bool lyte_is_music_playing(lyte_Music mus) {
    MusicItem *musicitem = mg_map_get(&musicitems, mus.handle);
    if (!musicitem) {
        fprintf(stderr, "Music with handle %d not present\n", mus.handle);
        return false;
    }
    return IsMusicStreamPlaying(musicitem->music);
}

float lyte_get_music_volume(lyte_Music mus) {
    return 0;
}

float lyte_get_music_pan(lyte_Music mus) {
    return 0;
}

float lyte_get_music_pitch(lyte_Music mus) {
    return 0;
}

float lyte_get_music_length(lyte_Music mus) {
    return 0;
}

float lyte_get_music_length_played(lyte_Music mus) {
    return 0;
}

void lyte_set_music_volume(lyte_Music mus, float vol) {
}

void lyte_set_music_pan(lyte_Music mus, float pan) {

}

void lyte_set_music_pitch(lyte_Music mus, float pitch) {

}

void lyte_seek_music(lyte_Music mus, float secs) {

}
