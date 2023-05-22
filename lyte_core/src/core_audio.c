//

#include <stdio.h>
#include <assert.h>
#include <stdlib.h>
#include <string.h>

#include "lyte_core.h"
#include "map.h"

#include "physfs.h"

#include "raudio.h"

#ifndef INIT_NUM_MUSICITEMS
#define INIT_NUM_MUSICITEMS 10
#endif

#ifndef INIT_NUM_SOUNDDATAITEMS
#define INIT_NUM_SOUNDDATAITEMS 40
#endif

#ifndef INIT_NUM_SOUNDITEMS
#define INIT_NUM_SOUNDITEMS 80
#endif


typedef struct MusicItem {
    uint32_t handle;
    Music music;
    double volume;
    double pan;
    double pitch;
    size_t data_size;
    void *data;
} MusicItem;

typedef struct SoundDataItem {
    uint32_t handle;
    Wave wave;
    size_t data_size;
    size_t ref_count;
    void *data;
} SoundDataItem;

typedef struct SoundItem {
    uint32_t handle;
    uint32_t sounddata_handle;
    Sound sound;
    double volume;
    double pan;
    double pitch;
} SoundItem;

static uint32_t musicitem_last_handle = 1500;
static mg_Map musicitems;

static uint32_t sounddataitem_last_handle = 1500;
static mg_Map sounddataitems;

static uint32_t sounditem_last_handle = 1500;
static mg_Map sounditems;

static double mastervolume;

int lyte_core_audio_init(void) {
    InitAudioDevice();
    if (!IsAudioDeviceReady()) {
        fprintf(stderr, "Audio device init failed\n");
        return -1;
    }

    mg_map_init(&musicitems, sizeof(MusicItem), INIT_NUM_MUSICITEMS);
    mg_map_init(&sounddataitems, sizeof(SoundDataItem), INIT_NUM_SOUNDDATAITEMS);
    mg_map_init(&sounditems, sizeof(SoundItem), INIT_NUM_SOUNDITEMS);

    mastervolume = 0.7;

    return 0;
}

int lyte_core_audio_cleanup(void) {
    mg_map_cleanup(&musicitems);
    mg_map_cleanup(&sounddataitems);
    mg_map_cleanup(&sounditems);

    CloseAudioDevice();

    return 0;
}


int lyte_core_audio_update_music_streams() {
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
    return 0;
}

int lyte_get_mastervolume(double *vol) {
    *vol = mastervolume;
    return 0;
}

int lyte_set_mastervolume(double vol) {
    mastervolume = vol;
    SetMasterVolume(vol);
    return 0;
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
    const char *file_extension = &path[strlen(path)-4]; // detect file format (like "mp3\0")
    MusicItem musicitem = {0};
    musicitem.handle = musicitem_last_handle++;
    musicitem.data = buf; // don't free! raudio does not copy the data. free at cleanup_music.
    musicitem.data_size = read_len;
    musicitem.volume = 1.0;
    musicitem.pan = 0.5;
    musicitem.pitch = 1.0;
    musicitem.music = LoadMusicStreamFromMemory(file_extension, musicitem.data, musicitem.data_size);
    musicitem.music.looping = true;
    mg_map_set(&musicitems, musicitem.handle, &musicitem);
    mus->handle = musicitem.handle;
    PHYSFS_close(file);
    return 0;
}

int lyte_cleanup_music(lyte_Music mus) {
    MusicItem *musicitem = mg_map_get(&musicitems, mus.handle);
    if (musicitem == NULL) {
        return 0;
    }
    StopMusicStream(musicitem->music);
    UnloadMusicStream(musicitem->music);
    free(musicitem->data);
    mg_map_del(&musicitems, mus.handle);
    return 0;
}

int lyte_play_music(lyte_Music mus) {
    MusicItem *musicitem = mg_map_get(&musicitems, mus.handle);
    if (!musicitem) {
        fprintf(stderr, "Music with handle %d not present\n", mus.handle);
        return -1;
    }
    PlayMusicStream(musicitem->music);
    return 0;
}

int lyte_pause_music(lyte_Music mus) {
    MusicItem *musicitem = mg_map_get(&musicitems, mus.handle);
    if (!musicitem) {
        fprintf(stderr, "Music with handle %d not present\n", mus.handle);
        return -1;
    }
    PauseMusicStream(musicitem->music);
    return 0;
}

int lyte_resume_music(lyte_Music mus) {
    MusicItem *musicitem = mg_map_get(&musicitems, mus.handle);
    if (!musicitem) {
        fprintf(stderr, "Music with handle %d not present\n", mus.handle);
        return -1;
    }
    ResumeMusicStream(musicitem->music);
    return 0;
}

int lyte_stop_music(lyte_Music mus) {
    MusicItem *musicitem = mg_map_get(&musicitems, mus.handle);
    if (!musicitem) {
        fprintf(stderr, "Music with handle %d not present\n", mus.handle);
        return -1;
    }
    StopMusicStream(musicitem->music);
    return 0;
}

int lyte_is_music_playing(lyte_Music mus, bool *val) {
    MusicItem *musicitem = mg_map_get(&musicitems, mus.handle);
    if (!musicitem) {
        fprintf(stderr, "Music with handle %d not present\n", mus.handle);
        return -1;
    }
    *val = IsMusicStreamPlaying(musicitem->music);
    return 0;
}

int lyte_get_music_volume(lyte_Music mus, double *val) {
    MusicItem *musicitem = mg_map_get(&musicitems, mus.handle);
    if (!musicitem) {
        fprintf(stderr, "Music with handle %d not present\n", mus.handle);
        return -1;
    }
    *val = musicitem->volume;
    return 0;
}

int lyte_get_music_pan(lyte_Music mus, double *val) {
    MusicItem *musicitem = mg_map_get(&musicitems, mus.handle);
    if (!musicitem) {
        fprintf(stderr, "Music with handle %d not present\n", mus.handle);
        return -1;
    }
    *val = musicitem->pan;
    return 0;
}

int lyte_get_music_pitch(lyte_Music mus, double *val) {
    MusicItem *musicitem = mg_map_get(&musicitems, mus.handle);
    if (!musicitem) {
        fprintf(stderr, "Music with handle %d not present\n", mus.handle);
        return -1;
    }
    *val = musicitem->pitch;
    return 0;
}

int lyte_get_music_length(lyte_Music mus, double *secs) {
    MusicItem *musicitem = mg_map_get(&musicitems, mus.handle);
    if (!musicitem) {
        fprintf(stderr, "Music with handle %d not present\n", mus.handle);
        return -1;
    }
    *secs = GetMusicTimeLength(musicitem->music);
    return 0;
}

int lyte_get_music_length_played(lyte_Music mus, double *secs) {
    MusicItem *musicitem = mg_map_get(&musicitems, mus.handle);
    if (!musicitem) {
        fprintf(stderr, "Music with handle %d not present\n", mus.handle);
        return -1;
    }
    *secs = GetMusicTimePlayed(musicitem->music);
    return 0;
}

int lyte_set_music_volume(lyte_Music mus, double vol) {
    MusicItem *musicitem = mg_map_get(&musicitems, mus.handle);
    if (!musicitem) {
        fprintf(stderr, "Music with handle %d not present\n", mus.handle);
        return -1;
    }
    musicitem->volume = vol;
    SetMusicVolume(musicitem->music, vol);
    return 0;
}

int lyte_set_music_pan(lyte_Music mus, double pan) {
    MusicItem *musicitem = mg_map_get(&musicitems, mus.handle);
    if (!musicitem) {
        fprintf(stderr, "Music with handle %d not present\n", mus.handle);
        return -1;
    }
    musicitem->pan = pan;
    SetMusicPan(musicitem->music, pan);
    return 0;
}

int lyte_set_music_pitch(lyte_Music mus, double pitch) {
    MusicItem *musicitem = mg_map_get(&musicitems, mus.handle);
    if (!musicitem) {
        fprintf(stderr, "Music with handle %d not present\n", mus.handle);
        return -1;
    }
    musicitem->pitch= pitch;
    SetMusicPitch(musicitem->music, pitch);
    return 0;
}

int lyte_seek_music(lyte_Music mus, double secs) {
    MusicItem *musicitem = mg_map_get(&musicitems, mus.handle);
    if (!musicitem) {
        fprintf(stderr, "Music with handle %d not present\n", mus.handle);
        return -1;
    }
    SeekMusicStream(musicitem->music, secs);
    return 0;
}

int lyte_load_sound(const char * path, lyte_Sound *val) {
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
    const char *file_extension = &path[strlen(path)-4]; // detect file format (like "mp3\0")
    SoundDataItem sdi = {0};
    sdi.handle = sounddataitem_last_handle++;
    sdi.data_size = read_len;
    sdi.data = buf;
    sdi.wave = LoadWaveFromMemory(file_extension, sdi.data, sdi.data_size);
    mg_map_set(&sounddataitems, sdi.handle, &sdi);

    SoundItem si = {0};
    si.handle = sounditem_last_handle++;
    si.sounddata_handle = sdi.handle;
    si.volume = 1.0;
    si.pan = 0.5;
    si.pitch = 1.0;
    si.sound = LoadSoundFromWave(sdi.wave);

    sdi.ref_count = 1;
    SetSoundVolume(si.sound, si.volume);
    SetSoundPan(si.sound, si.pan);
    SetSoundPitch(si.sound, si.pitch);
    mg_map_set(&sounditems, si.handle, &si);

    val->handle = si.handle;
    PHYSFS_close(file);
    return 0;
}

int lyte_clone_sound(lyte_Sound orig, lyte_Sound *val) {
    SoundItem *si = mg_map_get(&sounditems, orig.handle);
    if (si == NULL) {
        fprintf(stderr, "Sound not found\n");
        return -1;
    }
    SoundDataItem *sdi = mg_map_get(&sounddataitems, si->sounddata_handle);
    if (sdi == NULL) {
        fprintf(stderr, "Sound data not found\n");
        return -2;
    }
    SoundItem nsi = {0};
    nsi.handle = sounditem_last_handle++;
    nsi.sounddata_handle = si->sounddata_handle;
    nsi.volume = si->volume;
    nsi.pan = si->pan;
    nsi.pitch = si->pitch;
    nsi.sound = LoadSoundFromWave(sdi->wave);

    sdi->ref_count++;
    SetSoundVolume(nsi.sound, nsi.volume);
    SetSoundPan(nsi.sound, nsi.pan);
    SetSoundPitch(nsi.sound, nsi.pitch);
    mg_map_set(&sounditems, nsi.handle, &nsi);

    val->handle = nsi.handle;
    return 0;
}

int lyte_cleanup_sound(lyte_Sound sound) {
    SoundItem *si = mg_map_get(&sounditems, sound.handle);
    if (si == NULL) {
        return 0;
    }
    SoundDataItem *sdi = mg_map_get(&sounditems, si->sounddata_handle);
    if (sdi == NULL) {
        fprintf(stderr, "Sound data not found\n");
        return -2;
    }
    UnloadSound(si->sound);
    mg_map_del(&sounditems, sound.handle);
    sdi->ref_count--;
    if (sdi->ref_count == 0) {
        UnloadWave(sdi->wave);
        mg_map_del(&sounddataitems, sdi->handle);
        free(sdi->data);
    }
    return 0;
}

int lyte_play_sound(lyte_Sound snd) {
    SoundItem *si = mg_map_get(&sounditems, snd.handle);
    if (si == NULL) {
        fprintf(stderr, "Sound not found\n");
        return -1;
    }
    PlaySound(si->sound);
    return 0;
}

int lyte_pause_sound(lyte_Sound snd) {
    SoundItem *si = mg_map_get(&sounditems, snd.handle);
    if (si == NULL) {
        fprintf(stderr, "Sound not found\n");
        return -1;
    }
    PauseSound(si->sound);
    return 0;
}

int lyte_resume_sound(lyte_Sound snd) {
    SoundItem *si = mg_map_get(&sounditems, snd.handle);
    if (si == NULL) {
        fprintf(stderr, "Sound not found\n");
        return -1;
    }
    ResumeSound(si->sound);
    return 0;
}

int lyte_stop_sound(lyte_Sound snd) {
    SoundItem *si = mg_map_get(&sounditems, snd.handle);
    if (si == NULL) {
        fprintf(stderr, "Sound not found\n");
        return -1;
    }
    StopSound(si->sound);
    return 0;
}

int lyte_is_sound_playing(lyte_Sound snd, bool *val) {
    SoundItem *si = mg_map_get(&sounditems, snd.handle);
    if (si == NULL) {
        fprintf(stderr, "Sound not found\n");
        return -1;
    }
    *val = IsSoundPlaying(si->sound);
    return 0;
}

int lyte_get_sound_volume(lyte_Sound snd, double *val) {
    SoundItem *si = mg_map_get(&sounditems, snd.handle);
    if (si == NULL) {
        fprintf(stderr, "Sound not found\n");
        return -1;
    }
    *val = si->volume;
    return 0;
}

int lyte_get_sound_pan(lyte_Sound snd, double *val) {
    SoundItem *si = mg_map_get(&sounditems, snd.handle);
    if (si == NULL) {
        fprintf(stderr, "Sound not found\n");
        return -1;
    }
    *val = si->pan;
    return 0;
}

int lyte_get_sound_pitch(lyte_Sound snd, double *val) {
    SoundItem *si = mg_map_get(&sounditems, snd.handle);
    if (si == NULL) {
        fprintf(stderr, "Sound not found\n");
        return -1;
    }
    *val = si->pitch;
    return 0;
}

int lyte_set_sound_volume(lyte_Sound snd, double volume) {
    SoundItem *si = mg_map_get(&sounditems, snd.handle);
    if (si == NULL) {
        fprintf(stderr, "Sound not found\n");
        return -1;
    }
    si->volume = volume;
    SetSoundVolume(si->sound, si->volume);
    return 0;
}

int lyte_set_sound_pan(lyte_Sound snd, double pan) {
    SoundItem *si = mg_map_get(&sounditems, snd.handle);
    if (si == NULL) {
        fprintf(stderr, "Sound not found\n");
        return -1;
    }
    si->pan = pan;
    SetSoundPan(si->sound, si->pan);
    return 0;
}

int lyte_set_sound_pitch(lyte_Sound snd, double pitch) {
    SoundItem *si = mg_map_get(&sounditems, snd.handle);
    if (si == NULL) {
        fprintf(stderr, "Sound not found\n");
        return -1;
    }
    si->pitch = pitch;
    SetSoundPitch(si->sound, si->pitch);
    return 0;
}


