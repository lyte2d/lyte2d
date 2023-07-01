// TODO: "internalize"

#include <stdio.h>
#include <assert.h>
#include <stdlib.h>
#include <string.h>

#include "lyte_core.h"

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
    SoundDataItem *sdi;
    Sound sound;
    double volume;
    double pan;
    double pitch;
} SoundItem;

static MusicItem *current_music = NULL;


static double mastervolume;

int lyte_core_audio_init(void) {
    InitAudioDevice();
    if (!IsAudioDeviceReady()) {
        fprintf(stderr, "Audio device init failed\n");
        return -1;
    }


    mastervolume = 0.7;

    return 0;
}

int lyte_core_audio_cleanup(void) {

    CloseAudioDevice();

    return 0;
}


int lyte_core_audio_update_music_streams() {
    if (current_music) {
        Music music = current_music->music;
        if (IsMusicStreamPlaying(music)) {
            UpdateMusicStream(music);
            UpdateMusicStream(music);
            UpdateMusicStream(music);
            UpdateMusicStream(music);
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
    MusicItem *mi = malloc(sizeof(MusicItem));
    mi->data = buf; // don't free! raudio does not copy the data. free at cleanup_music.
    mi->data_size = read_len;
    mi->volume = 1.0;
    mi->pan = 0.5;
    mi->pitch = 1.0;
    mi->music = LoadMusicStreamFromMemory(file_extension, mi->data, mi->data_size);
    mi->music.looping = true;


    mus->ptr = mi;
    PHYSFS_close(file);
    return 0;
}

int lyte_Music_cleanup(lyte_Music mus) {
    MusicItem *musicitem = mus.ptr;
    if (musicitem == NULL) {
        return 0;
    }
    StopMusicStream(musicitem->music);
    UnloadMusicStream(musicitem->music);
    free(musicitem->data);
    free(musicitem);
    return 0;
}

int lyte_play_music(lyte_Music mus) {
    MusicItem *musicitem = mus.ptr;
    if (!musicitem) {
        fprintf(stderr, "Music not found\n");
        return -1;
    }
    if (current_music) {
        StopMusicStream(current_music->music);
    }
    current_music = musicitem;
    PlayMusicStream(current_music->music);
    return 0;
}

int lyte_pause_music(lyte_Music mus) {
    MusicItem *musicitem = mus.ptr;
    if (!musicitem) {
        fprintf(stderr, "Music not found\n");
        return -1;
    }
    PauseMusicStream(musicitem->music);
    return 0;
}

int lyte_resume_music(lyte_Music mus) {
    MusicItem *musicitem = mus.ptr;
    if (!musicitem) {
        fprintf(stderr, "Music not found\n");
        return -1;
    }
    ResumeMusicStream(musicitem->music);
    return 0;
}

int lyte_stop_music(lyte_Music mus) {
    MusicItem *musicitem = mus.ptr;
    if (!musicitem) {
        fprintf(stderr, "Music not found\n");
        return -1;
    }
    StopMusicStream(current_music->music);
    current_music = NULL;
    return 0;
}

int lyte_is_music_playing(lyte_Music mus, bool *val) {
    MusicItem *musicitem = mus.ptr;
    if (!musicitem) {
        fprintf(stderr, "Music not found\n");
        return -1;
    }
    *val = IsMusicStreamPlaying(musicitem->music);
    return 0;
}

int lyte_get_music_volume(lyte_Music mus, double *val) {
    MusicItem *musicitem = mus.ptr;
    if (!musicitem) {
        fprintf(stderr, "Music not found\n");
        return -1;
    }
    *val = musicitem->volume;
    return 0;
}

int lyte_get_music_pan(lyte_Music mus, double *val) {
    MusicItem *musicitem = mus.ptr;
    if (!musicitem) {
        fprintf(stderr, "Music not found\n");
        return -1;
    }
    *val = musicitem->pan;
    return 0;
}

int lyte_get_music_pitch(lyte_Music mus, double *val) {
    MusicItem *musicitem = mus.ptr;
    if (!musicitem) {
        fprintf(stderr, "Music not found\n");
        return -1;
    }
    *val = musicitem->pitch;
    return 0;
}

int lyte_get_music_length(lyte_Music mus, double *secs) {
    MusicItem *musicitem = mus.ptr;
    if (!musicitem) {
        fprintf(stderr, "Music not found\n");
        return -1;
    }
    *secs = GetMusicTimeLength(musicitem->music);
    return 0;
}

int lyte_get_music_length_played(lyte_Music mus, double *secs) {
    MusicItem *musicitem = mus.ptr;
    if (!musicitem) {
        fprintf(stderr, "Music not found\n");
        return -1;
    }
    *secs = GetMusicTimePlayed(musicitem->music);
    return 0;
}

int lyte_set_music_volume(lyte_Music mus, double vol) {
    MusicItem *musicitem = mus.ptr;
    if (!musicitem) {
        fprintf(stderr, "Music not found\n");
        return -1;
    }
    musicitem->volume = vol;
    SetMusicVolume(musicitem->music, vol);
    return 0;
}

int lyte_set_music_pan(lyte_Music mus, double pan) {
    MusicItem *musicitem = mus.ptr;
    if (!musicitem) {
        fprintf(stderr, "Music not found\n");
        return -1;
    }
    musicitem->pan = pan;
    SetMusicPan(musicitem->music, pan);
    return 0;
}

int lyte_set_music_pitch(lyte_Music mus, double pitch) {
    MusicItem *musicitem = mus.ptr;
    if (!musicitem) {
        fprintf(stderr, "Music not found\n");
        return -1;
    }
    musicitem->pitch= pitch;
    SetMusicPitch(musicitem->music, pitch);
    return 0;
}

int lyte_seek_music(lyte_Music mus, double secs) {
    MusicItem *musicitem = mus.ptr;
    if (!musicitem) {
        fprintf(stderr, "Music not found\n");
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
    SoundDataItem *sdi = malloc(sizeof(SoundDataItem));
    sdi->data_size = read_len;
    sdi->data = buf;
    sdi->wave = LoadWaveFromMemory(file_extension, sdi->data, sdi->data_size);

    SoundItem *si = malloc(sizeof(SoundItem));
    si->volume = 1.0;
    si->pan = 0.5;
    si->pitch = 1.0;
    si->sound = LoadSoundFromWave(sdi->wave);
    si->sdi = sdi;
    sdi->ref_count = 1;
    SetSoundVolume(si->sound, si->volume);
    SetSoundPan(si->sound, si->pan);
    SetSoundPitch(si->sound, si->pitch);

    val->ptr = si;
    PHYSFS_close(file);
    return 0;
}

int lyte_clone_sound(lyte_Sound orig, lyte_Sound *val) {
    SoundItem *si = orig.ptr;
    if (si == NULL) {
        fprintf(stderr, "Sound not found\n");
        return -1;
    }
    SoundDataItem *sdi = si->sdi;
    if (sdi == NULL) {
        fprintf(stderr, "Sound data not found\n");
        return -2;
    }
    SoundItem *nsi = malloc(sizeof(SoundItem));
    nsi->volume = si->volume;
    nsi->pan = si->pan;
    nsi->pitch = si->pitch;
    nsi->sound = LoadSoundFromWave(sdi->wave);
    nsi->sdi = sdi;
    sdi->ref_count++;
    SetSoundVolume(nsi->sound, nsi->volume);
    SetSoundPan(nsi->sound, nsi->pan);
    SetSoundPitch(nsi->sound, nsi->pitch);
    val->ptr = nsi;
    return 0;
}

int lyte_Sound_cleanup(lyte_Sound sound) {
    SoundItem *si = sound.ptr;
    if (si == NULL) {
        return 0;
    }
    SoundDataItem *sdi = si->sdi;
    if (sdi == NULL) {
        fprintf(stderr, "Sound data not found\n");
        return -2;
    }
    UnloadSound(si->sound);
    sdi->ref_count--;
    if (sdi->ref_count == 0) {
        UnloadWave(sdi->wave);
        free(sdi->data);
        free(sdi);
    }
    free(si);
    return 0;
}

int lyte_play_sound(lyte_Sound snd) {
    SoundItem *si = snd.ptr;
    if (si == NULL) {
        fprintf(stderr, "Sound not found\n");
        return -1;
    }
    PlaySound(si->sound);
    return 0;
}

int lyte_pause_sound(lyte_Sound snd) {
    SoundItem *si = snd.ptr;
    if (si == NULL) {
        fprintf(stderr, "Sound not found\n");
        return -1;
    }
    PauseSound(si->sound);
    return 0;
}

int lyte_resume_sound(lyte_Sound snd) {
    SoundItem *si = snd.ptr;
    if (si == NULL) {
        fprintf(stderr, "Sound not found\n");
        return -1;
    }
    ResumeSound(si->sound);
    return 0;
}

int lyte_stop_sound(lyte_Sound snd) {
    SoundItem *si = snd.ptr;
    if (si == NULL) {
        fprintf(stderr, "Sound not found\n");
        return -1;
    }
    StopSound(si->sound);
    return 0;
}

int lyte_is_sound_playing(lyte_Sound snd, bool *val) {
    SoundItem *si = snd.ptr;
    if (si == NULL) {
        fprintf(stderr, "Sound not found\n");
        return -1;
    }
    *val = IsSoundPlaying(si->sound);
    return 0;
}

int lyte_get_sound_volume(lyte_Sound snd, double *val) {
    SoundItem *si = snd.ptr;
    if (si == NULL) {
        fprintf(stderr, "Sound not found\n");
        return -1;
    }
    *val = si->volume;
    return 0;
}

int lyte_get_sound_pan(lyte_Sound snd, double *val) {
    SoundItem *si = snd.ptr;
    if (si == NULL) {
        fprintf(stderr, "Sound not found\n");
        return -1;
    }
    *val = si->pan;
    return 0;
}

int lyte_get_sound_pitch(lyte_Sound snd, double *val) {
    SoundItem *si = snd.ptr;
    if (si == NULL) {
        fprintf(stderr, "Sound not found\n");
        return -1;
    }
    *val = si->pitch;
    return 0;
}

int lyte_set_sound_volume(lyte_Sound snd, double volume) {
    SoundItem *si = snd.ptr;
    if (si == NULL) {
        fprintf(stderr, "Sound not found\n");
        return -1;
    }
    si->volume = volume;
    SetSoundVolume(si->sound, si->volume);
    return 0;
}

int lyte_set_sound_pan(lyte_Sound snd, double pan) {
    SoundItem *si = snd.ptr;
    if (si == NULL) {
        fprintf(stderr, "Sound not found\n");
        return -1;
    }
    si->pan = pan;
    SetSoundPan(si->sound, si->pan);
    return 0;
}

int lyte_set_sound_pitch(lyte_Sound snd, double pitch) {
    SoundItem *si = snd.ptr;
    if (si == NULL) {
        fprintf(stderr, "Sound not found\n");
        return -1;
    }
    si->pitch = pitch;
    SetSoundPitch(si->sound, si->pitch);
    return 0;
}


