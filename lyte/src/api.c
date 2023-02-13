/* (c) mg */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>
#include <assert.h>
#include <lua.h>
#include <lauxlib.h>

#include "lyte.h"


// #define LYTE_DIRECT_API "_lyte_direct_api"
#define LYTE_DIRECT_API "lyte"

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


// AUIDO

// [ number -- ]
static int api_set_mastervolume(lua_State *L) {
    float vol = luaL_checknumber(L, -1);
    if (vol < 0 || vol > 1) {
        luaL_error(L, "volume needs to be in [0, 1] range. got: %d", vol);
    }
    M_app_setmastervolume(vol);
    return 0;
}

// [ -- number ]
static int api_get_mastervolume(lua_State *L) {
    float vol = M_app_getmastervolume();
    lua_pushnumber(L, vol);
    return 1;
}

// MUSIC

// [ Music -- ]
static int api_music_start(lua_State *L) {
    M_Music *mus = luaL_checkudata(L, 1, "lyte.Music");
    M_music_play(*mus);
    return 0;
}

// [ Music -- ]
static int api_music_stop(lua_State *L) {
    M_Music *mus = luaL_checkudata(L, 1, "lyte.Music");
    M_music_stop(*mus);
    return 0;
}

// [ Music -- ]
static int api_music_pause(lua_State *L) {
    M_Music *mus = luaL_checkudata(L, 1, "lyte.Music");
    M_music_pause(*mus);
    return 0;
}

// [ Music -- ]
static int api_music_resume(lua_State *L) {
    M_Music *mus = luaL_checkudata(L, 1, "lyte.Music");
    M_music_resume(*mus);
    return 0;
}

// [ Music number -- ]
static int api_music_seek(lua_State *L) {
    M_Music *mus = luaL_checkudata(L, 1, "lyte.Music");
    float secs = luaL_checknumber(L, 2);
    // if (vol < 0 || vol > 1) {
    //     luaL_error(L, "volume needs to be in [0, 1] range. got: %d", vol);
    // }
    M_music_seek(*mus, secs);
    return 0;
}

// [ Music -- number ]
static int api_music_getlength(lua_State *L) {
    M_Music *mus = luaL_checkudata(L, 1, "lyte.Music");
    float vol = M_music_get_length(*mus);
    lua_pushnumber(L, vol);
    return 1;
}

// [ Music -- number ]
static int api_music_getlength_played(lua_State *L) {
    M_Music *mus = luaL_checkudata(L, 1, "lyte.Music");
    float vol = M_music_get_length_played(*mus);
    lua_pushnumber(L, vol);
    return 1;
}

// [ Music number -- ]
static int api_music_setvolume(lua_State *L) {
    M_Music *mus = luaL_checkudata(L, 1, "lyte.Music");
    float vol = luaL_checknumber(L, 2);
    if (vol < 0 || vol > 1) {
        luaL_error(L, "volume needs to be in [0, 1] range. got: %d", vol);
    }
    M_music_set_volume(*mus, vol);
    return 0;
}

// [ Music -- number ]
static int api_music_getvolume(lua_State *L) {
    M_Music *mus = luaL_checkudata(L, 1, "lyte.Music");
    float vol = M_music_get_volume(*mus);
    lua_pushnumber(L, vol);
    return 1;
}


// [ Music number -- ]
static int api_music_setpitch(lua_State *L) {
    M_Music *mus = luaL_checkudata(L, 1, "lyte.Music");
    float vol = luaL_checknumber(L, -1);
    // if (vol < 0 || vol > 1) {
    //     luaL_error(L, "volume needs to be in [0, 1] range. got: %d", vol);
    // }
    M_music_set_pitch(*mus,vol);
    return 0;
}

// [ Music -- number ]
static int api_music_getpitch(lua_State *L) {
    M_Music *mus = luaL_checkudata(L, 1, "lyte.Music");
    float vol = M_music_get_pitch(*mus);
    lua_pushnumber(L, vol);
    return 1;
}

// [ Music number -- ]
static int api_music_setpan(lua_State *L) {
    M_Music *mus = luaL_checkudata(L, 1, "lyte.Music");
    float vol = luaL_checknumber(L, 2);
    if (vol < 0 || vol > 1) {
        luaL_error(L, "pan needs to be in [0, 1] range. got: %d", vol);
    }
    M_music_set_pan(*mus,vol);
    return 0;
}

// [ Music -- number ]
static int api_music_getpan(lua_State *L) {
    M_Music *mus = luaL_checkudata(L, 1, "lyte.Music");
    float vol = M_music_get_pan(*mus);
    lua_pushnumber(L, vol);
    return 1;
}


// [ Music -- boolean ]
static int api_music_isplaying(lua_State *L) {
    M_Music *mus = luaL_checkudata(L, 1, "lyte.Music");
    bool b = M_music_isplaying(*mus);
    lua_pushboolean(L, b);
    return 1;
}


// MUSIC

// [ string -- Music ]
static int api_new_music_load(lua_State *L) {
    const char *path = luaL_checkstring(L, -1);
    M_Music music = M_newmusic_load(path);
    void *udata = lua_newuserdata(L, sizeof(M_Music));
    M_Music *dest = (M_Music *)udata;
    dest->id = music.id;
    // userdata already on top

    luaL_getmetatable(L, "lyte.Music");
    lua_setmetatable(L, -2);

    return 1;
}


// metadata index... (width/height as properties)
enum music_keys_idx {
    IDX_music_volume,
    IDX_music_pitch,
    IDX_music_pan,
    IDX_music_length,
    IDX_music_length_played,
    IDX_music_playing,
    //
    IDX_music_play,
    IDX_music_pause,
    IDX_music_stop,
    IDX_music_resume,
    IDX_music_seek,
    NUM_MUSIC_KEYS,
};
static const char *music_keys[] = {
    "volume",
    "pitch",
    "pan",
    "length",
    "length_played",
    "playing",
    //
    "play",
    "pause",
    "stop",
    "resume",
    "seek",

    NULL, // sentinel
};

//  [ music key -- value ]
static int music_md_index(lua_State *L) {
    // M_Music *music = luaL_checkudata(L, -2, "lyte.Music");
    int key_id = luaL_checkoption(L, -1, NULL, music_keys);
    //lua_pop(L, 2); // remove the music object and key (str)
    lua_pop(L, 1); // remove the key (str)
    switch (key_id) {
        case IDX_music_volume: { api_music_getvolume(L); } break;
        case IDX_music_pan: { api_music_getpan(L); } break;
        case IDX_music_pitch: { api_music_getpitch(L); } break;
        case IDX_music_length: { api_music_getlength(L); } break;
        case IDX_music_length_played: { api_music_getlength_played(L); } break;
        case IDX_music_playing: { api_music_isplaying(L); } break;
        // methods
        case IDX_music_play: { lua_getglobal(L, LYTE_DIRECT_API); lua_getfield(L, -1, "play_music"); lua_remove(L, -2); } break;
        case IDX_music_pause: { lua_getglobal(L, LYTE_DIRECT_API); lua_getfield(L, -1, "pause_music"); lua_remove(L, -2); } break;
        case IDX_music_stop: { lua_getglobal(L, LYTE_DIRECT_API); lua_getfield(L, -1, "stop_music"); lua_remove(L, -2); } break;
        case IDX_music_resume: { lua_getglobal(L, LYTE_DIRECT_API); lua_getfield(L, -1, "resume_music"); lua_remove(L, -2); } break;
        case IDX_music_seek: { lua_getglobal(L, LYTE_DIRECT_API); lua_getfield(L, -1, "seek_music"); lua_remove(L, -2); } break;
    }
    return 1;
}

//  [ music key newval -- ]
static int music_md_newindex(lua_State *L) {
    int key_id = luaL_checkoption(L, 2, NULL, music_keys);
    lua_remove(L, 2); // remove the key (str)
    CHK_STACK(2);
    switch (key_id) {
        case IDX_music_volume: { api_music_setvolume(L); } break;
        case IDX_music_pan: { api_music_setpan(L); } break;
        case IDX_music_pitch: { api_music_setpitch(L); } break;
        default: {
            printf("Field is not settable.\n");
            lua_error(L);
        } break;

    }
    CHK_STACK(2);
    lua_settop(L, 0);
    return 0;
}

static int music_md_tostring(lua_State *L) {
    M_Music *mus = luaL_checkudata(L, 1, "lyte.Music");
    (void)mus;
    lua_pushstring(L, "[lyte.Music]");
    return 1;
}
static int music_md_gc(lua_State *L) {
    M_Music *mus = luaL_checkudata(L, 1, "lyte.Music");
    LOG(" ~~ gc ~~ Music: %d\n", mus->id);
    M_music_cleanup(*mus);
    return 1;
}
static const struct luaL_Reg music_metadata[] = {
    {"__index", music_md_index},
    {"__newindex", music_md_newindex},
    {"__tostring", music_md_tostring},
    {"__gc", music_md_gc},
    {NULL, NULL} /* sentinel */
};

static int luaopen_music_metadata(lua_State *L) {
    luaL_newmetatable(L, "lyte.Music");
    lua_pushvalue(L, -1); /* duplicates the metatable */
    lua_setfield(L, -2, "__index");
    luaL_register(L, NULL, music_metadata);
    lua_pop(L, 1); // regitered table
    return 1;
}


// SOUNDDATA


// [ SoundData number -- ]
static int api_sounddata_setvolume(lua_State *L) {
    M_SoundData *snddata = luaL_checkudata(L, 1, "lyte.SoundData");
    float vol = luaL_checknumber(L, -1);
    if (vol < 0 || vol > 1) {
        luaL_error(L, "volume needs to be in [0, 1] range. got: %d", vol);
    }
    M_sounddata_set_volume(*snddata, vol);
    return 0;
}

// [ SoundData -- number ]
static int api_sounddata_getvolume(lua_State *L) {
    M_SoundData *snddata = luaL_checkudata(L, 1, "lyte.SoundData");
    float vol = M_sounddata_get_volume(*snddata);
    lua_pushnumber(L, vol);
    return 1;
}


// [ SoundData number -- ]
static int api_sounddata_setpitch(lua_State *L) {
    M_SoundData *snddata = luaL_checkudata(L, 1, "lyte.SoundData");
    float vol = luaL_checknumber(L, -1);
    // if (vol < 0 || vol > 1) {
    //     luaL_error(L, "volume needs to be in [0, 1] range. got: %d", vol);
    // }
    M_sounddata_set_pitch(*snddata, vol);
    return 0;
}

// [ SoundData -- number ]
static int api_sounddata_getpitch(lua_State *L) {
    M_SoundData *snddata = luaL_checkudata(L, 1, "lyte.SoundData");
    float vol = M_sounddata_get_pitch(*snddata);
    lua_pushnumber(L, vol);
    return 1;
}

// [ SoundData number -- ]
static int api_sounddata_setpan(lua_State *L) {
    M_SoundData *snddata = luaL_checkudata(L, 1, "lyte.SoundData");
    float vol = luaL_checknumber(L, -1);
    if (vol < 0 || vol > 1) {
        luaL_error(L, "pan needs to be in [0, 1] range. got: %d", vol);
    }
    M_sounddata_set_pan(*snddata, vol);
    return 0;
}

// [ SoundData -- number ]
static int api_sounddata_getpan(lua_State *L) {
    M_SoundData *snddata = luaL_checkudata(L, 1, "lyte.SoundData");
    float vol = M_sounddata_get_pan(*snddata);
    lua_pushnumber(L, vol);
    return 1;
}

// [ string -- SoundData ]
static int api_new_sounddata_load(lua_State *L) {
    const char *path = luaL_checkstring(L, -1);
    M_SoundData sounddata = M_newsounddata_load(path);
    void *udata = lua_newuserdata(L, sizeof(M_SoundData));
    M_SoundData *dest = (M_SoundData *)udata;
    dest->id = sounddata.id;
    // userdata already on top

    luaL_getmetatable(L, "lyte.SoundData");
    lua_setmetatable(L, -2);

    return 1;
}


// metadata index... (width/height as properties)
enum sounddata_keys_idx {
    IDX_sounddata_volume,
    IDX_sounddata_pitch,
    IDX_sounddata_pan,
    NUM_SOUNDDATA_KEYS,
};
static const char *sounddata_keys[] = {
    "volume",
    "pitch",
    "pan",

    NULL, // sentinel
};

//  [ sounddata key -- value ]
static int sounddata_md_index(lua_State *L) {
    // M_SoundData *sounddata = luaL_checkudata(L, -2, "lyte.SoundData");
    int key_id = luaL_checkoption(L, -1, NULL, sounddata_keys);
    //lua_pop(L, 2); // remove the sounddata object and key (str)
    lua_pop(L, 1); // remove the key (str)
    switch (key_id) {
        case IDX_sounddata_volume: { api_sounddata_getvolume(L); } break;
        case IDX_sounddata_pan: { api_sounddata_getpan(L); } break;
        case IDX_sounddata_pitch: { api_sounddata_getpitch(L); } break;
    }
    return 1;
}

//  [ sounddata key newval -- ]
static int sounddata_md_newindex(lua_State *L) {
    int key_id = luaL_checkoption(L, 2, NULL, sounddata_keys);
    lua_remove(L, 2); // remove the key (str)
    CHK_STACK(2);
    switch (key_id) {
        case IDX_sounddata_volume: { api_sounddata_setvolume(L); } break;
        case IDX_sounddata_pan: { api_sounddata_setpan(L); } break;
        case IDX_sounddata_pitch: { api_sounddata_setpitch(L); } break;
        default: {
            printf("Field is not settable.\n");
            lua_error(L);
        } break;

    }
    CHK_STACK(2);
    lua_settop(L, 0);
    return 0;
}

static int sounddata_md_tostring(lua_State *L) {
    M_SoundData *sd = luaL_checkudata(L, 1, "lyte.SoundData");
    (void)sd;
    lua_pushstring(L, "[lyte.SoundData]");
    return 1;
}
static int sounddata_md_gc(lua_State *L) {
    M_SoundData *sd = luaL_checkudata(L, 1, "lyte.SoundData");
    LOG(" ~~ gc ~~ SoundData: %d\n", sd->id);
    M_sounddata_cleanup(*sd);
    return 1;
}
static const struct luaL_Reg sounddata_metadata[] = {
    {"__index", sounddata_md_index},
    {"__newindex", sounddata_md_newindex},
    {"__tostring", sounddata_md_tostring},
    {"__gc", sounddata_md_gc},
    {NULL, NULL} /* sentinel */
};

static int luaopen_sounddata_metadata(lua_State *L) {
    luaL_newmetatable(L, "lyte.SoundData");
    lua_pushvalue(L, -1); /* duplicates the metatable */
    lua_setfield(L, -2, "__index");
    luaL_register(L, NULL, sounddata_metadata);
    lua_pop(L, 1); // regitered table
    return 1;
}

// SOUND CHANNEL


// [ Sound number -- ]
static int api_sound_setvolume(lua_State *L) {
    M_Sound *sndchannel = luaL_checkudata(L, 1, "lyte.Sound");
    float vol = luaL_checknumber(L, -1);
    if (vol < 0 || vol > 1) {
        luaL_error(L, "volume needs to be in [0, 1] range. got: %d", vol);
    }
    M_sound_set_volume(*sndchannel, vol);
    return 0;
}

// [ Sound -- number ]
static int api_sound_getvolume(lua_State *L) {
    M_Sound *sndchannel = luaL_checkudata(L, 1, "lyte.Sound");
    float vol = M_sound_get_volume(*sndchannel);
    lua_pushnumber(L, vol);
    return 1;
}


// [ Sound number -- ]
static int api_sound_setpitch(lua_State *L) {
    M_Sound *sndchannel = luaL_checkudata(L, 1, "lyte.Sound");
    float vol = luaL_checknumber(L, -1);
    // if (vol < 0 || vol > 1) {
    //     luaL_error(L, "volume needs to be in [0, 1] range. got: %d", vol);
    // }
    M_sound_set_pitch(*sndchannel, vol);
    return 0;
}

// [ Sound -- number ]
static int api_sound_getpitch(lua_State *L) {
    M_Sound *sndchannel = luaL_checkudata(L, 1, "lyte.Sound");
    float vol = M_sound_get_pitch(*sndchannel);
    lua_pushnumber(L, vol);
    return 1;
}

// [ Sound number -- ]
static int api_sound_setpan(lua_State *L) {
    M_Sound *sndchannel = luaL_checkudata(L, 1, "lyte.Sound");
    float vol = luaL_checknumber(L, -1);
    if (vol < 0 || vol > 1) {
        luaL_error(L, "pan needs to be in [0, 1] range. got: %d", vol);
    }
    M_sound_set_pan(*sndchannel, vol);
    return 0;
}

// [ Sound -- number ]
static int api_sound_getpan(lua_State *L) {
    M_Sound *sndchannel = luaL_checkudata(L, 1, "lyte.Sound");
    float vol = M_sound_get_pan(*sndchannel);
    lua_pushnumber(L, vol);
    return 1;
}

// [ Sound --  ]
static int api_sound_play(lua_State *L) {
    M_Sound *sndchannel = luaL_checkudata(L, 1, "lyte.Sound");
    M_sound_play(*sndchannel);
    return 0;
}

// [ Sound --  ]
static int api_sound_pause(lua_State *L) {
    M_Sound *sndchannel = luaL_checkudata(L, 1, "lyte.Sound");
    M_sound_pause(*sndchannel);
    return 0;
}

// [ Sound --  ]
static int api_sound_resume(lua_State *L) {
    M_Sound *sndchannel = luaL_checkudata(L, 1, "lyte.Sound");
    M_sound_resume(*sndchannel);
    return 0;
}

// [ Sound --  ]
static int api_sound_stop(lua_State *L) {
    M_Sound *sndchannel = luaL_checkudata(L, 1, "lyte.Sound");
    M_sound_stop(*sndchannel);
    return 0;
}


// [ Sound -- boolean ]
static int api_sound_isplaying(lua_State *L) {
    M_Sound *sndchannel = luaL_checkudata(L, 1, "lyte.Sound");
    bool ispl = M_sound_isplaying(*sndchannel);
    lua_pushboolean(L, ispl);
    return 1;
}


// [ SoundData -- Sound ]
static int api_new_sound(lua_State *L) {
    M_SoundData *sd = luaL_checkudata(L, 1, "lyte.SoundData");
    M_Sound sound = M_newsound(*sd);
    void *udata = lua_newuserdata(L, sizeof(M_Sound));
    M_Sound *dest = (M_Sound *)udata;
    dest->data_id = sound.data_id;
    dest->channel_idx = sound.channel_idx;
    // userdata already on top

    luaL_getmetatable(L, "lyte.Sound");
    lua_setmetatable(L, -2);

    return 1;
}




// meta index... (width/height as properties)
enum sound_keys_idx {
    IDX_sound_volume,
    IDX_sound_pitch,
    IDX_sound_pan,
    IDX_sound_playing,
    //
    IDX_sound_play,
    IDX_sound_pause,
    IDX_sound_stop,
    IDX_sound_resume,
    NUM_SOUND_KEYS,
};
static const char *sound_keys[] = {
    "volume",
    "pitch",
    "pan",
    "playing",
    //
    "play",
    "pause",
    "stop",
    "resume",

    NULL, // sentinel
};

//  [ sound key -- value ]
static int sound_md_index(lua_State *L) {
    // M_Sound *sound = luaL_checku(L, -2, "lyte.Sound");
    int key_id = luaL_checkoption(L, -1, NULL, sound_keys);
    //lua_pop(L, 2); // remove the sound object and key (str)
    lua_pop(L, 1); // remove the key (str)
    switch (key_id) {
        case IDX_sound_volume: { api_sound_getvolume(L); } break;
        case IDX_sound_pan: { api_sound_getpan(L); } break;
        case IDX_sound_pitch: { api_sound_getpitch(L); } break;
        case IDX_sound_playing: { api_sound_isplaying(L); } break;
        // methods
        case IDX_sound_play: { lua_getglobal(L, LYTE_DIRECT_API); lua_getfield(L, -1, "play_sound"); lua_remove(L, -2); } break;
        case IDX_sound_pause: { lua_getglobal(L, LYTE_DIRECT_API); lua_getfield(L, -1, "pause_sound"); lua_remove(L, -2); } break;
        case IDX_sound_stop: { lua_getglobal(L, LYTE_DIRECT_API); lua_getfield(L, -1, "stop_sound"); lua_remove(L, -2); } break;
        case IDX_sound_resume: { lua_getglobal(L, LYTE_DIRECT_API); lua_getfield(L, -1, "resume_sound"); lua_remove(L, -2); } break;
    }
    return 1;
}



//  [ sound key newval -- ]
static int sound_md_newindex(lua_State *L) {
    int key_id = luaL_checkoption(L, 2, NULL, sound_keys);
    lua_remove(L, 2); // remove the key (str)
    CHK_STACK(2);
    switch (key_id) {
        case IDX_sound_volume: { api_sound_setvolume(L); } break;
        case IDX_sound_pan: { api_sound_setpan(L); } break;
        case IDX_sound_pitch: { api_sound_setpitch(L); } break;
        default: {
            printf("Field is not settable.\n");
            lua_error(L);
        } break;

    }
    CHK_STACK(2);
    lua_settop(L, 0);
    return 0;
}


static int sound_md_tostring(lua_State *L) {
    M_Sound *sc = luaL_checkudata(L, 1, "lyte.Sound");
    (void)sc;
    lua_pushstring(L, "[lyte.Sound]");
    return 1;
}
static int sound_md_gc(lua_State *L) {
    M_Sound *sc = luaL_checkudata(L, 1, "lyte.Sound");
    LOG(" ~~ gc ~~ Sound: %d/%d\n", sc->data_id, sc->channel_idx);
    M_sound_cleanup(*sc);
    return 1;
}
static const struct luaL_Reg sound_metadata[] = {
    {"__index", sound_md_index},
    {"__newindex", sound_md_newindex},
    {"__tostring", sound_md_tostring},
    {"__gc", sound_md_gc},
    {NULL, NULL} /* sentinel */
};

static int luaopen_sound_metadata(lua_State *L) {
    luaL_newmetatable(L, "lyte.Sound");
    lua_pushvalue(L, -1); /* duplicates the metatable */
    lua_setfield(L, -2, "__index");
    luaL_register(L, NULL, sound_metadata);
    lua_pop(L, 1); // regitered table
    return 1;
}



// AUDIO LIB

// static const struct luaL_Reg lyte_audio_api_lib[] = {

//     // music
//     {"load_music", api_new_music_load},
//     {"play_music", api_music_start},
//     {"pause_music", api_music_pause},
//     {"resume_music", api_music_resume},
//     {"stop_music", api_music_stop},
//     {"seek_music", api_music_seek},
//     {"get_musiclength", api_music_getlength},
//     {"get_musiclength_played", api_music_getlength_played},
//     {"set_musicvolume", api_music_setvolume},
//     {"get_musicvolume", api_music_getvolume},
//     {"set_musicpitch", api_music_setpitch},
//     {"get_musicpitch", api_music_getpitch},
//     {"set_musicpan", api_music_setpan},
//     {"get_musicpan", api_music_getpan},
//     {"is_musicplaying", api_music_isplaying},

//     // sounddata
//     {"load_sounddata", api_new_sounddata_load},
//     {"set_sounddatavolume", api_sounddata_setvolume},
//     {"get_sounddatavolume", api_sounddata_getvolume},
//     {"set_sounddatapitch", api_sounddata_setpitch},
//     {"get_sounddatapitch", api_sounddata_getpitch},
//     {"set_sounddatapan", api_sounddata_setpan},
//     {"get_sounddatapan", api_sounddata_getpan},

//     // sound
//     {"new_sound", api_new_sound},
//     {"set_soundvolume", api_sound_setvolume},
//     {"get_soundvolume", api_sound_getvolume},
//     {"set_soundpitch", api_sound_setpitch},
//     {"get_soundpitch", api_sound_getpitch},
//     {"set_soundpan", api_sound_setpan},
//     {"get_soundpan", api_sound_getpan},
//     {"play_sound", api_sound_play},
//     {"pause_sound", api_sound_pause},
//     {"resume_sound", api_sound_resume},
//     {"stop_sound", api_sound_stop},
//     {"is_soundplaying", api_sound_isplaying},


//     {NULL, NULL} /* sentinel */
// };

// -- open
int luaopen_lyte_audio(lua_State *L) {
    luaopen_music_metadata(L);
    luaopen_sounddata_metadata(L);
    luaopen_sound_metadata(L);
    // luaL_register(L, LYTE_DIRECT_API, lyte_audio_api_lib);
    lua_pop(L, 1); // regitered table
    return 0;
}



///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


// GRAPHICS

static int api_push_matrix(lua_State *L) {
    (void)L;
    M_gfx_pushmatrix();
    return 0;
}

static int api_pop_matrix(lua_State *L) {
    (void)L;
    M_gfx_popmatrix();
    return 0;
}

static int api_identity_matrix(lua_State *L) {
    (void)L;
    M_gfx_identitymatrix();
    return 0;
}


static int api_translate(lua_State *L) {
    float dx = luaL_checknumber(L, 1);
    float dy = luaL_checknumber(L, 2);
    M_gfx_translate(dx, dy);
    return 0;
}

static int api_rotate(lua_State *L) {
    float r = luaL_checknumber(L, 1);
    M_gfx_rotate(r);
    return 0;
}


static int api_rotate_at(lua_State *L) {
    float r = luaL_checknumber(L, 1);
    float x = luaL_checknumber(L, 2);
    float y = luaL_checknumber(L, 3);
    M_gfx_rotate_at(r, x, y);
    return 0;
}


static int api_scale(lua_State *L) {
    float sx = luaL_checknumber(L, 1);
    float sy = luaL_checknumber(L, 2);
    M_gfx_scale(sx, sy);
    return 0;
}


static int api_scale_at(lua_State *L) {
    float sx = luaL_checknumber(L, 1);
    float sy = luaL_checknumber(L, 2);
    float x = luaL_checknumber(L, 3);
    float y = luaL_checknumber(L, 4);
    M_gfx_scale_at(sx, sy, x, y);
    return 0;
}




// [  r g b a --  ]
static int api_clear(lua_State *L) {
    float r = luaL_checknumber(L, 1);
    float g = luaL_checknumber(L, 2);
    float b = luaL_checknumber(L, 3);
    float a = luaL_checknumber(L, 4);
    M_gfx_clear(r, g, b, a);
    return 0;
}


static int api_set_color(lua_State *L) {
    float r = luaL_checknumber(L, 1);
    float g = luaL_checknumber(L, 2);
    float b = luaL_checknumber(L, 3);
    float a = luaL_checknumber(L, 4);
    M_gfx_setcolor(r, g, b, a);
    return 0;
}

static int api_reset_color(lua_State *L) {
    (void)L;
    M_gfx_resetcolor();
    return 0;
}


// order important -- must match M_BlendMode values
static const char *_blendmode_str_values[] = {
    "none", // M_BLENDMODE_NONE
    "blend", // M_BLENDMODE_BLEND
    "add",  // M_BLENDMODE_ADD
    "mod", // M_BLENDMODE_MOD
    "mul" // M_BLENDMODE_MUL
};

static int api_set_defaultblendmode(lua_State *L) {
    const char *str = luaL_checkstring(L, 1);
    int intval = 1;
    for (int i=0; i<M_NUM_BLENDMODES; i++) {
        if (strcmp(str, _blendmode_str_values[i]) == 0) {
            intval = i;
            break;
        }
    }
    M_BlendMode blendmode = intval;
    M_gfx_setdefaultblendmode(blendmode);
    return 0;
}


static int api_set_blendmode(lua_State *L) {
    const char *str = luaL_checkstring(L, 1);
    int intval = 1;
    for (int i=0; i<M_NUM_BLENDMODES; i++) {
        if (strcmp(str, _blendmode_str_values[i]) == 0) {
            intval = i;
            break;
        }
    }
    M_BlendMode blendmode = intval;
    M_gfx_setblendmode(blendmode);
    return 0;
}

static int api_reset_blendmode(lua_State *L) {
    (void)L;
    M_gfx_resetblendmode();
    return 0;
}


// order important -- must match M_FilterMode values
// note: there are more, including ones with mipmap support in sokol_gp
// todo: consider adding other variants later
static const char *_filtermode_str_values[] = {
    "___UNUSED___", // 0 -- unused
    "nearest",
    "linear",
};


static int api_set_defaultfiltermode(lua_State *L) {
    const char *str = luaL_checkstring(L, 1);
    int intval = 1;
    for (int i=0; i<M_NUM_FILTERMODES; i++) {
        if (strcmp(str, _filtermode_str_values[i]) == 0) {
            intval = i;
            break;
        }
    }
    M_FilterMode filtermode = intval;
    M_gfx_setdefaultfiltermode(filtermode);
    return 0;
}


static int api_set_filtermode(lua_State *L) {
    const char *str = luaL_checkstring(L, 1);
    int intval = 1;
    for (int i=0; i<M_NUM_FILTERMODES; i++) {
        if (strcmp(str, _filtermode_str_values[i]) == 0) {
            intval = i;
            break;
        }
    }
    M_FilterMode filtermode = intval;
    M_gfx_setfiltermode(filtermode);
    return 0;
}


static int api_reset_filtermode(lua_State *L) {
    (void)L;
    M_gfx_resetfiltermode();
    return 0;
}

// static int api_draw_circle(lua_State *L) {
//     int x = luaL_checkint(L, 1);
//     int y = luaL_checkint(L, 2);
//     int r = luaL_checkint(L, 3);
//     M_draw_circle(x, y, r);
//     return 0;
// }


// static int api_draw_circle_filled(lua_State *L) {
//     int x = luaL_checkint(L, 1);
//     int y = luaL_checkint(L, 2);
//     int r = luaL_checkint(L, 3);
//     M_draw_circle_filled(x, y, r);
//     return 0;
// }

static int api_draw_point(lua_State *L) {
    float x = luaL_checknumber(L, 1);
    float y = luaL_checknumber(L, 2);
    M_gfx_drawpoint(x, y);
    return 0;
}

static int api_draw_line(lua_State *L) {
    float x1 = luaL_checknumber(L, 1);
    float y1 = luaL_checknumber(L, 2);
    float x2 = luaL_checknumber(L, 3);
    float y2 = luaL_checknumber(L, 4);
    M_gfx_drawline(x1, y1, x2, y2);
    return 0;
}

static int api_draw_rect(lua_State *L) {
    float x = luaL_checknumber(L, 1);
    float y = luaL_checknumber(L, 2);
    float w = luaL_checknumber(L, 3);
    float h = luaL_checknumber(L, 4);
    M_gfx_drawrect(x, y, w, h);
    return 0;
}

static int api_draw_rect_filled(lua_State *L) {
    float x = luaL_checknumber(L, 1);
    float y = luaL_checknumber(L, 2);
    float w = luaL_checknumber(L, 3);
    float h = luaL_checknumber(L, 4);
    M_gfx_drawrect_filled(x, y, w, h);
    return 0;
}

/////////////////////////
/////////////////////////
/////////////////////////


// BUFFERS FOR ARRAY BASED DRAWING FUNCTIONS
// TODO move these

#define MAX_NUM_POINTS 1000
#define MAX_NUM_LINES 1000
#define MAX_NUM_RECTS 1000
#define MAX_NUM_TRIANGLES 1000

M_Point _buf_points[MAX_NUM_POINTS] = {0};
M_Line _buf_lines[MAX_NUM_LINES] = {0};
M_Rect _buf_rects[MAX_NUM_RECTS] = {0};
M_Triangle _buf_triangles[MAX_NUM_TRIANGLES] = {0};

static inline void _set_buf_points(lua_State *L, int i) {
    lua_rawgeti(L, -1, i);
    if (lua_istable(L, -2) != 1) {
        lua_error(L);
    }

    lua_pushstring(L, "x");
    lua_rawget(L, -2);
    float x = luaL_checknumber(L, -1);
    lua_pop(L, 1);

    lua_pushstring(L, "y");
    lua_rawget(L, -2);
    float y = luaL_checknumber(L, -1);
    lua_pop(L, 1);

    lua_pop(L, 1); // remove the Point
    _buf_points[i-1].x = x;
    _buf_points[i-1].y = y;
}

static inline void _set_buf_lines(lua_State *L, int i) {
    lua_rawgeti(L, -1, i);
    if (lua_istable(L, -2) != 1) {
        lua_error(L);
    }

    lua_pushstring(L, "x1");
    lua_rawget(L, -2);
    float x1 = luaL_checknumber(L, -1);
    lua_pop(L, 1);

    lua_pushstring(L, "y1");
    lua_rawget(L, -2);
    float y1 = luaL_checknumber(L, -1);
    lua_pop(L, 1);

    lua_pushstring(L, "x2");
    lua_rawget(L, -2);
    float x2 = luaL_checknumber(L, -1);
    lua_pop(L, 1);

    lua_pushstring(L, "y2");
    lua_rawget(L, -2);
    float y2 = luaL_checknumber(L, -1);
    lua_pop(L, 1);

    lua_pop(L, 1); // remove the Line
    _buf_lines[i-1].x1 = x1;
    _buf_lines[i-1].y1 = y1;
    _buf_lines[i-1].x2 = x2;
    _buf_lines[i-1].y2 = y2;
}

static inline void  _set_buf_rects(lua_State *L, int i) {
    lua_rawgeti(L, -1, i);
    if (lua_istable(L, -2) != 1) {
        lua_error(L);
    }

    lua_pushstring(L, "x");
    lua_rawget(L, -2);
    float x = luaL_checknumber(L, -1);
    lua_pop(L, 1);

    lua_pushstring(L, "y");
    lua_rawget(L, -2);
    float y = luaL_checknumber(L, -1);
    lua_pop(L, 1);

    lua_pushstring(L, "w");
    lua_rawget(L, -2);
    float w = luaL_checknumber(L, -1);
    lua_pop(L, 1);

    lua_pushstring(L, "h");
    lua_rawget(L, -2);
    float h = luaL_checknumber(L, -1);
    lua_pop(L, 1);

    lua_pop(L, 1); // remove the Point
    _buf_rects[i-1].x = x;
    _buf_rects[i-1].y = y;
    _buf_rects[i-1].w = w;
    _buf_rects[i-1].h = h;
}


static inline void _set_buf_triangles(lua_State *L, int i) {
    lua_rawgeti(L, -1, i);
    if (lua_istable(L, -2) != 1) {
        lua_error(L);
    }

    lua_pushstring(L, "x1");
    lua_rawget(L, -2);
    float x1 = luaL_checknumber(L, -1);
    lua_pop(L, 1);

    lua_pushstring(L, "y1");
    lua_rawget(L, -2);
    float y1 = luaL_checknumber(L, -1);
    lua_pop(L, 1);

    lua_pushstring(L, "x2");
    lua_rawget(L, -2);
    float x2 = luaL_checknumber(L, -1);
    lua_pop(L, 1);

    lua_pushstring(L, "y2");
    lua_rawget(L, -2);
    float y2 = luaL_checknumber(L, -1);
    lua_pop(L, 1);

    lua_pushstring(L, "x3");
    lua_rawget(L, -2);
    float x3 = luaL_checknumber(L, -1);
    lua_pop(L, 1);

    lua_pushstring(L, "y3");
    lua_rawget(L, -2);
    float y3 = luaL_checknumber(L, -1);
    lua_pop(L, 1);

    lua_pop(L, 1); // remove the Line
    _buf_triangles[i].x1 = x1;
    _buf_triangles[i].y1 = y1;
    _buf_triangles[i].x2 = x2;
    _buf_triangles[i].y2 = y2;
    _buf_triangles[i].x3 = x3;
    _buf_triangles[i].y3 = y3;
}

// [ {Point} --  ]
static int api_draw_points(lua_State *L) {
    if (lua_istable(L, -1) != 1) {
        lua_error(L);
    }
    int cnt = lua_objlen(L, -1);
    for (int i=1; i<=cnt; i++){
        _set_buf_points(L, i);
    }
    M_gfx_drawpoints(_buf_points, cnt);
    return 0;
}

// [ {Line} --  ]
static int api_draw_lines(lua_State *L) {
    if (lua_istable(L, -1) != 1) {
        lua_error(L);
    }
    int cnt = lua_objlen(L, -1);
    for (int i=1; i<=cnt; i++){
        _set_buf_lines(L, i);
    }
    M_gfx_drawlines(_buf_lines, cnt);
    return 0;
}

// [ {Rect} --  ]
static int api_draw_rects_filled(lua_State *L) {
    if (lua_istable(L, -1) != 1) {
        lua_error(L);
    }
    int cnt = lua_objlen(L, -1);
    for (int i=1; i<=cnt; i++){
        _set_buf_rects(L, i);
    }
    M_gfx_drawrects_filled(_buf_rects, cnt);
    return 0;
}

// [ {Triangle} --  ]
static int api_draw_triangles_filled(lua_State *L) {
    if (lua_istable(L, -1) != 1) {
        lua_error(L);
    }
    int cnt = lua_objlen(L, -1);
    for (int i=1; i<=cnt; i++){
        _set_buf_triangles(L, i);
    }
    M_gfx_drawtriangles_filled(_buf_triangles, cnt);
    return 0;
}

// [ {Point} --  ]
static int api_draw_striplines(lua_State *L) {
    if (lua_istable(L, -1) != 1) {
        lua_error(L);
    }
    int cnt = lua_objlen(L, -1);
    for (int i=1; i<=cnt; i++){
        _set_buf_points(L, i);
    }
    M_gfx_drawstriplines(_buf_points, cnt);
    return 0;
}

// [ {Point} --  ]
static int api_draw_striptriangles_filled(lua_State *L) {
    if (lua_istable(L, -1) != 1) {
        lua_error(L);
    }
    int cnt = lua_objlen(L, -1);
    for (int i=1; i<=cnt; i++){
        _set_buf_points(L, i);
    }
    M_gfx_drawstriptriangles_filled(_buf_points, cnt);
    return 0;
}


////////////////////
////////////////////


//canvas

// [ -- ]
static int api_reset_canvas(lua_State *L) {
    M_canvas_unset();
    lua_pushnil(L);
    // lua_setfield(L, LUA_REGISTRYINDEX, "lyte.current_canvas");
    return 0;
}


// [ Canvas -- ]
// // [ Canvas | nil -- ]
static int api_set_canvas(lua_State *L) {
    // if (lua_gettop(L) == 0) { // unset
    //     api_set_canvas_default(L);
    // } else { // set
        M_Canvas *cvs = luaL_checkudata(L, 1, "lyte.Canvas");
        M_canvas_set(*cvs);
        lua_setfield(L, LUA_REGISTRYINDEX, "lyte.current_canvas"); // keep a ref so that this is not GC'd unless unset or changed by another set
    // }

    return 0;
}



// [ number number -- Canvas ]
static int api_new_canvas(lua_State *L) {
    int w = luaL_checkinteger(L, 1);
    int h = luaL_checkinteger(L, 2);
    // instead of the below, we can also just have an "init" function on morelib side.
    // not needed for this case though, it's a very small structure
    M_Canvas canvas = M_newcanvas(w, h);

    void *udata = lua_newuserdata(L, sizeof(M_Canvas));
    M_Canvas *dest_cvs = (M_Canvas *)udata;
    dest_cvs->id_image = canvas.id_image;
    dest_cvs->id_depth_image = canvas.id_depth_image;
    dest_cvs->id_pass = canvas.id_pass;
    dest_cvs->width = canvas.width;
    dest_cvs->height = canvas.height;
    // userdata already on top

    luaL_getmetatable(L, "lyte.Canvas");
    lua_setmetatable(L, -2);

    // image of the canvas..
    M_Image image = M_canvas_get_image(*dest_cvs);
    M_Image *dest_img  = lua_newuserdata(L, sizeof(M_Image));
    dest_img->id = image.id;
    dest_img->width = image.width;
    dest_img->height = image.height;
    luaL_getmetatable(L, "lyte.Image");
    lua_setmetatable(L, -2);

    int ref = luaL_ref(L, LUA_REGISTRYINDEX);

    dest_cvs->_ref = ref;

    return 1;
}


// metadata index... (width/height as properties)
enum canvas_keys_idx {
    IDX_canvas_image,
    IDX_canvas_width,
    IDX_canvas_height,
    NUM_CANVAS_KEYS,
};
static const char *canvas_keys[] = {
    "image",
    "width",
    "height",
    NULL, // sentinel
};

// .width, .height etc.
static int canvas_md_index(lua_State *L) {
    M_Canvas *cvs = luaL_checkudata(L, -2, "lyte.Canvas");
    int key_id = luaL_checkoption(L, -1, NULL, canvas_keys);
    lua_pop(L, 2); // remove the canvas object and key (str)
    switch (key_id) {
        case IDX_canvas_width: { lua_pushinteger(L, cvs->height); } break;
        case IDX_canvas_height: { lua_pushinteger(L, cvs->height); } break;
        case IDX_canvas_image: {
            lua_rawgeti(L, LUA_REGISTRYINDEX, cvs->_ref);
        } break;
    }
    return 1;
}


static int canvas_md_tostring(lua_State *L) {
    M_Canvas *cvs = luaL_checkudata(L, 1, "lyte.Canvas");
    lua_pushfstring(L, "[lyte.Canvas width: %d height: %d]", cvs->width, cvs->height);
    return 1;
}
static int canvas_md_gc(lua_State *L) {
    LOG("canvas_md\n");
    M_Canvas *cvs = luaL_checkudata(L, 1, "lyte.Canvas");
    LOG(" ~~ gc ~~ Canvas: %d\n", cvs->id_image);
    luaL_unref(L, LUA_REGISTRYINDEX, cvs->_ref);
    M_canvas_cleanup(*cvs);
    return 1;
}
static const struct luaL_Reg canvas_metadata[] = {
    // {"get_width", canvas_md_get_width},
    // {"get_height", canvas_md_get_height},
    {"__index", canvas_md_index},
    {"__tostring", canvas_md_tostring},
    {"__gc", canvas_md_gc},
    {NULL, NULL} /* sentinel */
};

static int luaopen_canvas_metadata(lua_State *L) {
    luaL_newmetatable(L, "lyte.Canvas");
    lua_pushvalue(L, -1); /* duplicates the metatable */
    lua_setfield(L, -2, "__index");
    luaL_register(L, NULL, canvas_metadata);
    lua_pop(L, 1); // table
    return 0;
}





//image

// [ Image number number -- ]
static int api_draw_image(lua_State *L) {
    M_Image *img = luaL_checkudata(L, 1, "lyte.Image");
    int x = luaL_checkinteger(L, 2);
    int y = luaL_checkinteger(L, 3);

    M_image_draw(*img, x, y);

    return 0;
}


// [ Image number number number number number number-- ]
static int api_draw_imagerect(lua_State *L) {
    M_Image *img = luaL_checkudata(L, 1, "lyte.Image");
    int x = luaL_checkinteger(L, 2);
    int y = luaL_checkinteger(L, 3);
    int im_x = luaL_checkinteger(L, 4);
    int im_y = luaL_checkinteger(L, 5);
    int im_w = luaL_checkinteger(L, 6);
    int im_h = luaL_checkinteger(L, 7);

    M_image_draw_rect(*img, x, y, im_x, im_y, im_w, im_h);
    return 0;
}


// [ -- Image ]
static int api_new_image_load(lua_State *L) {
    const char *path = luaL_checkstring(L, -1);
    M_Image image = M_newimage_load(path);
    void *udata = lua_newuserdata(L, sizeof(M_Image));
    // instead of the below, we can also just have an "init" function on morelib side.
    // not needed for this case though, it's a very small structure
    M_Image *dest = (M_Image *)udata;
    dest->id = image.id;
    dest->width = image.width;
    dest->height = image.height;
    // userdata already on top

    luaL_getmetatable(L, "lyte.Image");
    lua_setmetatable(L, -2);
    return 1;
}


// metadata index... (width/height as properties)
enum image_keys_idx {
    IDX_image_width,
    IDX_image_height,
    NUM_IMAGE_KEYS,
};
static const char *image_keys[] = {
    "width",
    "height",
    NULL, // sentinel
};

// .widdth, .height etc.
static int image_md_index(lua_State *L) {
    M_Image *img = luaL_checkudata(L, -2, "lyte.Image");
    int key_id = luaL_checkoption(L, -1, NULL, image_keys);
    lua_pop(L, 2); // remove the Config and key (str)
    switch (key_id) {
        case IDX_image_width: { lua_pushinteger(L, img->width); } break;
        case IDX_image_height: { lua_pushinteger(L, img->height); } break;
    }
    return 1;
}


static int image_md_tostring(lua_State *L) {
    M_Image *img = luaL_checkudata(L, 1, "lyte.Image");
    lua_pushfstring(L, "[lyte.Image 'width' %d 'height': %d]", img->width, img->height);
    return 1;
}
static int image_md_gc(lua_State *L) {
    M_Image *img = luaL_checkudata(L, 1, "lyte.Image");
    LOG("~~ gc ~~ Image:  %d -- %dx%d\n" ,img->id, img->width, img->height);
    M_image_cleanup(*img);
    return 1;
}
static const struct luaL_Reg image_metadata[] = {
    // {"get_width", image_md_get_width},
    // {"get_height", image_md_get_height},
    {"__index", image_md_index},
    {"__tostring", image_md_tostring},
    {"__gc", image_md_gc},
    {NULL, NULL} /* sentinel */
};

static int luaopen_image_metadata(lua_State *L) {
    luaL_newmetatable(L, "lyte.Image");
    lua_pushvalue(L, -1); /* duplicates the metatable */
    lua_setfield(L, -2, "__index");
    luaL_register(L, NULL, image_metadata);
    lua_pop(L, 1); // table
    return 0;
}



// font

// // -- Font
// static int api_get_font(lua_State *L) {
//     lua_getfield(L, LUA_REGISTRYINDEX, "lyte.current_font");
//     return 1;
// }

// Font --
static int api_set_font(lua_State *L) {
    M_Font *fnt = luaL_checkudata(L, 1, "lyte.Font");
    M_font_setfont(*fnt);
    lua_setfield(L, LUA_REGISTRYINDEX, "lyte.current_font");
    return 0;
}



// string x y  -- w h
static int api_draw_text(lua_State *L) {
    const char *str = luaL_checkstring(L, 1);
    int x = luaL_checkinteger(L, 2);
    int y = luaL_checkinteger(L, 3);
    M_SizeI sz = M_font_drawtext(str, x, y);
    lua_pushinteger(L, sz.w);
    lua_pushinteger(L, sz.h);
    return 2;
}

// string -- w h
static int api_measure_text(lua_State *L) {
    const char *str = luaL_checkstring(L, 1);
    M_SizeI sz = M_font_measuretext(str);
    lua_pushinteger(L, sz.w);
    lua_pushinteger(L, sz.h);
    return 2;
}

//==================================================================================================================


// SHADER

// // [ Shader -- string ]
// static int api_shader_getcode(lua_State *L) {
//     M_Shader *shader = luaL_checkudata(L, 1, "lyte.Shader");
//     printf("shader.getcode... \n");
//     const char *code = shader->code;
//     printf("shader -> code %s\n", code);
//     lua_pushstring(L, code);
//     return 1;
// }


// [ Shader --  ]
static int api_set_shader(lua_State *L) {
    M_Shader *shader = luaL_checkudata(L, 1, "lyte.Shader");
    M_shader_set(*shader);
    return 0;
}

// [  --  ]
static int api_reset_shader(lua_State *L) {
    (void)L;
    M_shader_unset();
    return 0;
}

// order and values important. should match: M_UniformType enum exactly
static const char * _uniformtype_names[] = {"_invalid", "float", "vec2" , "vec3" , "vec4", "int" , "ivec2" , "ivec3" , "ivec4", "mat4", "sampler2D", NULL};
// static const size_t _uniformtype_counts[] = {-1,         1,       2,       3,       4,      1,      2,        3,        4,       16,     0 /* samples2D is special */};
// helper
// type string, i.e. vec4, mat4, sampler2D to M_UniformType (integer enum)
static inline M_UniformType _to_uniformtype(lua_State *L, const char* str) {
    lua_pushstring(L, str);
    int idx = luaL_checkoption(L, -1, NULL, _uniformtype_names);
    lua_pop(L, 1); // remove str;
    return (M_UniformType) idx;
}



// [ Shader ShaderData -- ]
static int api_shader_send(lua_State *L) {
    M_Shader *shader = luaL_checkudata(L, 1, "lyte.Shader");
    luaL_checktype(L, 2, LUA_TTABLE);
    M_ShaderUniform *uniforms = NULL;
    size_t num_uniforms = 0;
    float _uniform_send_buf[1024];

    // memset(_uniform_send_buf, 0, 1024*4);

    // identify the count of uniforms to send
    lua_pushnil(L);  /* first key */
    while (lua_next(L, 2) != 0) {
        num_uniforms++;
        lua_pop(L, 1);
    }

    if (num_uniforms > 0) {
        uniforms = malloc(sizeof(M_ShaderUniform) * num_uniforms);
        memset(uniforms, 0, sizeof(M_ShaderUniform) * num_uniforms);
        // identify the count of uniforms to send
        int i = 0;
        int us_i = 0;
        lua_pushnil(L);  /* first key */
        while (lua_next(L, 2) != 0) {
            /* uses 'key' (at index -2) and 'value' (at index -1) */
            const char *name = luaL_checkstring(L, -2);
            uniforms[i].name = name;
            int val_lua_type = lua_type(L, -1);
            if (val_lua_type == LUA_TNUMBER) {
                float number = luaL_checknumber(L, -1);
                _uniform_send_buf[us_i] = number;
                uniforms[i].count = 1;
                uniforms[i].data = _uniform_send_buf + us_i;
                us_i++;
            } else if (val_lua_type == LUA_TTABLE) {
                int cnt = lua_objlen(L, -1);
                if (cnt < 1) {
                    printf("Shader send arrays should not be empty\n");
                    lua_error(L);
                };
                //------------------------------------------- traverse
                // int j = 0;
                lua_pushnil(L);
                int last_us_i = us_i;
                while (lua_next(L, -2) != 0) {
                    /* uses 'key' (at index -2) and 'value' (at index -1) */
                    int _idx = luaL_checknumber(L, -2); // key
                    (void)_idx;
                    float val = luaL_checknumber(L, -1); // value
                    _uniform_send_buf[us_i] = val;
                    us_i++;
                    // following traverse pattern
                    lua_pop(L,1);
                    // j++;
                }
                //------------------------------------------- done traversing
                uniforms[i].count = cnt;
                uniforms[i].data = _uniform_send_buf + last_us_i;
            } else if (val_lua_type == LUA_TUSERDATA) {
                // printf("~~~ ~~~ SHADER SEND USERDATA (image): tbd\n");
                M_Image *img = luaL_checkudata(L, -1, "lyte.Image");
                uniforms[i].count = 0;
                uniforms[i].data = img;
            } else {
                printf("Shader send expects a number or a number array.");
                lua_error(L);
            }
            //const char *value = .... ;


            //uniforms[i].size =
            //uniforms[i].data =
            lua_pop(L, 1);
            i++;
        }

        // TODO errors!
        M_shader_send(*shader, uniforms, num_uniforms);
        free(uniforms);
    }


    return 0;
}


// [ ShaderDef -- Shader ]
static int api_new_shader(lua_State *L) {
    luaL_checktype(L, 1, LUA_TTABLE);
    M_ShaderDef shaderdef = {0};

    // vertex shader code
    lua_getfield(L, 1, "vert");
    const char *vert = luaL_checkstring(L, -1);
    lua_pop(L, 1);
    shaderdef.vert = vert;

    // fragment shader code
    lua_getfield(L, 1, "frag");
    const char *frag = luaL_checkstring(L, -1);
    lua_pop(L, 1);
    shaderdef.frag = frag;

    // uniforms (TODO)
    lua_getfield(L, 1, "uniforms");
    lua_remove(L, -2); // remove shaderdefinition. top: uniforms;
    luaL_checktype(L, -1, LUA_TTABLE);

    shaderdef.uniforms = NULL;
    shaderdef.num_uniforms = 0;

    size_t num_uniforms = 0;
    lua_pushnil(L);  /* first key */
    while (lua_next(L, 1) != 0) {
        num_uniforms++;
        lua_pop(L, 1);
    }

    if (num_uniforms > 0) {
       shaderdef.num_uniforms = num_uniforms;
       // TODO: free on cleanup
       shaderdef.uniforms = (void *)malloc(num_uniforms * sizeof(struct M_UniformDef));
       int i = 0;
       lua_pushnil(L); /* first key */
       while (lua_next(L, 1) != 0) {
            /* uses 'key' (at index -2) and 'value' (at index -1) */
            const char *name = luaL_checkstring(L, -2);
            const char *uniform_type_str = luaL_checkstring(L, -1);
            M_UniformType uniform_type = _to_uniformtype(L, uniform_type_str);

            shaderdef.uniforms[i].name = name;
            shaderdef.uniforms[i].type = uniform_type;
            /* removes 'value'; keeps 'key' for next iteration */
            lua_pop(L, 1);
            i++;
       }
    }

    // TODO: shader IDs
    M_Shader shader = M_newshader(shaderdef);
    void *udata = lua_newuserdata(L, sizeof(M_Shader));
    (void)shader;
    (void)udata;
    M_Shader *dest = (M_Shader *)udata;
    dest->id = shader.id;
    dest->pip_id = shader.pip_id;
    // userdata already on top
    luaL_getmetatable(L, "lyte.Shader");
    lua_setmetatable(L, -2);

    return 1;
}


// // [ pathstring -- Shader ]
// static int api_new_shader_load(lua_State *L) {
//     const char *path = luaL_checkstring(L, 1);
//     M_Shader shader = M_newshader_load(path);
//     void *udata = lua_newuserdata(L, sizeof(M_Shader));
//     (void)shader;
//     (void)udata;
//     M_Shader *dest = (M_Shader *)udata;
//     dest->code = shader.code;

//     // userdata already on top
//     luaL_getmetatable(L, "lyte.Shader");
//     lua_setmetatable(L, -2);

//     return 1;
// }


// meta index... (width/height as properties)
enum shader_keys_idx {
    // IDX_shader_code,
    //
    IDX_shader_send,
    NUM_SHADER_KEYS,
};
static const char *shader_keys[] = {
    // "code",
    //
    "send",
    NULL, // sentinel
};

//  [ shader key -- value ]
static int shader_md_index(lua_State *L) {
    // M_Shader *shader = luaL_checkudata(L, -2, "lyte.Shader");
    int key_id = luaL_checkoption(L, -1, NULL, shader_keys);
    //lua_pop(L, 2); // remove the shader object and key (str)
    lua_pop(L, 1); // remove the key (str)
    switch (key_id) {
        // case IDX_shader_code: { api_shader_getcode(L); } break;
        // methods
        case IDX_shader_send: { lua_getglobal(L, LYTE_DIRECT_API); lua_getfield(L, -1, "send_shader"); lua_remove(L, -2); } break;
 break;
    }
    return 1;
}



//  [ shader key newval -- ]
static int shader_md_newindex(lua_State *L) {
    int key_id = luaL_checkoption(L, 2, NULL, shader_keys);
    lua_remove(L, 2); // remove the key (str)
    CHK_STACK(2);
    switch (key_id) {
        // case IDX_shader_code: { printf("Shader code is not directly settable. Create new Shader instead."); lua_error(L); } break;
        default: {
            printf("Field is not settable.\n");
            lua_error(L);
        } break;

    }
    CHK_STACK(2);
    lua_settop(L, 0);
    return 0;
}


static int shader_md_tostring(lua_State *L) {
    M_Shader *shader = luaL_checkudata(L, 1, "lyte.Shader");
    (void)shader;
    lua_pushstring(L, "[lyte.Shader]");
    return 1;
}
static int shader_md_gc(lua_State *L) {
    M_Shader *shader = luaL_checkudata(L, 1, "lyte.Shader");
    LOG(" ~~ gc ~~ Shader: %s/\n", shader->code);
    M_shader_cleanup(*shader);
    return 1;
}
static const struct luaL_Reg shader_metadata[] = {
    {"__index", shader_md_index},
    {"__newindex", shader_md_newindex},
    {"__tostring", shader_md_tostring},
    {"__gc", shader_md_gc},
    {NULL, NULL} /* sentinel */
};

static int luaopen_shader_metadata(lua_State *L) {
    luaL_newmetatable(L, "lyte.Shader");
    lua_pushvalue(L, -1); /* duplicates the metatable */
    lua_setfield(L, -2, "__index");
    luaL_register(L, NULL, shader_metadata);
    lua_pop(L, 1); // regitered table
    return 1;
}

//==================================================================================================================


// FONT

// [ string -- Font ]
static int api_new_font_load(lua_State *L) {
    const char *path = luaL_checkstring(L, 1);
    int size = luaL_checkinteger(L, 2);
    M_Font font = M_newfont_load(path, size);
    void *udata = lua_newuserdata(L, sizeof(M_Font));
    M_Font *dest = (M_Font *)udata;
    dest->id = font.id;
    // userdata already on top


    luaL_getmetatable(L, "lyte.Font");
    lua_setmetatable(L, -2);

    return 1;
}

static int font_md_tostring(lua_State *L) {
    M_Font *fnt = luaL_checkudata(L, 1, "lyte.Font");
    (void)fnt;
    lua_pushstring(L, "[lyte.Font]");
    return 1;
}
static int font_md_gc(lua_State *L) {
    M_Font *fnt = luaL_checkudata(L, 1, "lyte.Font");
    M_font_cleanup(*fnt);
    return 1;
}
static const struct luaL_Reg font_metadata[] = {
    {"__tostring", font_md_tostring},
    {"__gc", font_md_gc},
    {NULL, NULL} /* sentinel */
};

static int luaopen_font_metadata(lua_State *L) {
    luaL_newmetatable(L, "lyte.Font");
    lua_pushvalue(L, -1); /* duplicates the metatable */
    lua_setfield(L, -2, "__index");
    luaL_register(L, NULL, font_metadata);
    lua_pop(L, 1); // regitered table
    return 1;
}


//==================================================================================================================


static const struct luaL_Reg lyte_graphics_lib[] = {
    {"push_matrix", api_push_matrix},
    {"pop_matrix", api_pop_matrix},
    {"identity_matrix", api_identity_matrix},
    {"translate", api_translate},
    {"rotate", api_rotate},
    {"rotate_at", api_rotate_at},
    {"scale", api_scale},
    {"scale_at", api_scale_at},
    {"clear", api_clear},
    {"set_color", api_set_color},
    {"reset_color", api_reset_color},
    {"set_defaultblendmode", api_set_defaultblendmode},
    {"set_blendmode", api_set_blendmode},
    {"reset_blendmode", api_reset_blendmode},
    {"set_defaultfiltermode", api_set_defaultfiltermode},
    {"set_filtermode", api_set_filtermode},
    {"reset_filtermode", api_reset_filtermode},

    // in direct api, and Image/Canvas ctors now
    // {"new_canvas", api_new_canvas},
    // {"load_image", api_new_image_load},


    // {"get_canvas_image", api_set_canvas_image}, // canvas has .image property
    {"set_canvas", api_set_canvas},
    {"reset_canvas", api_reset_canvas},

    {"draw_image", api_draw_image},
    {"draw_imagerect", api_draw_imagerect},

    {"new_shader", api_new_shader},
    // {"load_shader", api_new_shader_load},
    {"send_shader", api_shader_send},
    {"set_shader", api_set_shader},
    {"reset_shader", api_reset_shader},
    // {"get_shadercode", api_shader_getcode},

    {"load_font", api_new_font_load},
    {"set_font", api_set_font},
    // {"get_font", api_get_font},
    {"draw_text", api_draw_text},
    {"measure_text", api_measure_text},

    // {"draw_circle", api_draw_circle},
    // {"draw_circle_filled", api_draw_circle_filled},

    {"draw_point", api_draw_point},
    {"draw_line", api_draw_line},
    {"draw_rect", api_draw_rect},
    {"draw_rect_filled", api_draw_rect_filled},

    {"draw_points", api_draw_points},
    {"draw_lines", api_draw_lines},
    {"draw_rects_filled", api_draw_rects_filled},
    {"draw_triangles_filled", api_draw_triangles_filled},
    {"draw_striplines", api_draw_striplines},
    {"draw_striptriangles_filled", api_draw_striptriangles_filled},


    {NULL, NULL} /* sentinel */
};

// -- open
int luaopen_lyte_graphics(lua_State *L) {
    luaopen_canvas_metadata(L);
    luaopen_image_metadata(L);
    luaopen_font_metadata(L);
    luaopen_shader_metadata(L);
    luaL_register(L, "lyte", lyte_graphics_lib);
    lua_pop(L, 1);
    return 0;
}


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// INPUT

// mappings with value (since there are many untypeable keys)
// so order there is not important

#include "_keys.inl"

// order important
static const char *_mouse_key_str_values[] = {
    "m_1",
    "m_2",
    "m_3",
    "m_4",
    "m_5",
    "m_6",
    "m_7",
    "m_8",
    // "m_wh_up",
    // "m_wh_down",
    // "m_wh_left",
    // "m_wh_right",
};

// order important
static const char *_gamepad_key_str_values[] = {
#if defined(__EMSCRIPTEN__)
    "but_a",
    "but_b",
    "but_x",
    "but_y",
    "but_leftbumper",
    "but_rightbumper",
    "but_internal_left_trigger", // Emscripten only. will be mapped to axis
    "but_internal_right_trigger", // Emscripten only. will be mapped to axis
    "but_back",
    "but_start",
    "but_leftthumb",
    "but_rightthumb",
    "but_dpad_up",
    "but_dpad_down",
    "but_dpad_left",
    "but_dpad_right",
    "but_guide",
#else
    "but_a",
    "but_b",
    "but_x",
    "but_y",
    "but_leftbumper",
    "but_rightbumper",
    "but_back",
    "but_start",
    "but_guide",
    "but_leftthumb",
    "but_rightthumb",
    "but_dpad_up",
    "but_dpad_right",
    "but_dpad_down",
    "but_dpad_left",
#endif
};

// order important
static const char *_gamepad_axis_str_values[] = {
    "axis_left_x",
    "axis_left_y",
    "axis_right_x",
    "axis_right_y",
    "axis_trigger_left",
    "axis_trigger_right",
};


// UTILS

static inline M_MouseButton _mousekey_str_to_mousekey(lua_State *L, const char *mousekey) {
    int ret = -1;
    for (int i=0; i<M_NUM_MOUSEBUTTONS; i++) {
        if (strcmp(mousekey, _mouse_key_str_values[i]) == 0) {
            ret = i;
            break;
        }
    }
    if (ret == -1) {
        luaL_error(L, "Unknown mouse key: '%s'", mousekey);
    }
    return (M_MouseButton)ret;
}

static inline M_GamepadButton _gamepadkey_str_to_gamepadkey(lua_State *L, const char *gamepadkey) {
    int ret = -1;
    for (int i=0; i<M_NUM_GAMEPADBUTTONS; i++) {
        if (strcmp(gamepadkey, _gamepad_key_str_values[i]) == 0) {
            ret = i;
            break;
        }
    }
    if (ret == -1) {
        luaL_error(L, "Unknown gamepad button: '%s'", gamepadkey);
    }
    return (M_GamepadButton)ret;
}


static inline M_GamepadAxis _gamepadaxis_str_to_gamepadaxis(lua_State *L, const char *gamepadaxis) {
    int ret = -1;
    for (int i=0; i<M_NUM_GAMEPADAXISES; i++) {
        if (strcmp(gamepadaxis, _gamepad_axis_str_values[i]) == 0) {
            ret = i;
            break;
        }
    }
    if (ret == -1) {
        luaL_error(L, "Unknown gamepad axis: '%s'", gamepadaxis);
    }
    return (M_GamepadAxis)ret;
}

static inline M_KeyboardKey _keycode_str_to_keycode(lua_State *L, const char *keycode) {
    int ret = -1;
    for (int i=0; i<_num_keymappings; i++) {
        if (strcmp(keycode, _keymappings[i].key) == 0) {
            ret = _keymappings[i].val;
            break;
        }
    }
    if (ret == -1) {
        luaL_error(L, "Unknown key: '%s'", keycode);
    }
    return (M_KeyboardKey)ret;
}


// INPUT


// [ keycode -- bool ]]
static int api_is_keydown(lua_State *L) {
    const char *keycode_str = luaL_checkstring(L, 1);
    lua_pop(L,1);
    M_KeyboardKey keycode = _keycode_str_to_keycode(L, keycode_str);
    bool result = M_input_keydown(keycode);
    lua_pushboolean(L, result);
    return 1;
}

// [ keycode -- bool ]]
static int api_is_keypresssed(lua_State *L) {
    const char *keycode_str = luaL_checkstring(L, 1);
    lua_pop(L,1);
    M_KeyboardKey keycode = _keycode_str_to_keycode(L, keycode_str);
    bool result = M_input_keypressed(keycode);
    lua_pushboolean(L, result);
    return 1;
}

// [ keycode -- bool ]]
static int api_is_keyrepeat(lua_State *L) {
    const char *keycode_str = luaL_checkstring(L, 1);
    lua_pop(L,1);
    M_KeyboardKey keycode = _keycode_str_to_keycode(L, keycode_str);
    bool result = M_input_keyrepeat(keycode);
    lua_pushboolean(L, result);
    return 1;
}

// [ keycode -- bool ]]
static int api_is_keyreleased(lua_State *L) {
    const char *keycode_str = luaL_checkstring(L, 1);
    lua_pop(L,1);
    M_KeyboardKey keycode = _keycode_str_to_keycode(L, keycode_str);
    bool result = M_input_keyreleased(keycode);
    lua_pushboolean(L, result);
    return 1;
}


// [ mousekey -- bool ]]
static int api_is_mousedown(lua_State *L) {
    const char *mousekey_str = luaL_checkstring(L, 1);
    lua_pop(L,1);
    M_MouseButton mousekey = _mousekey_str_to_mousekey(L, mousekey_str);
    bool result = M_input_mousedown(mousekey);
    lua_pushboolean(L, result);
    return 1;
}

// [ mousekey -- bool ]]
static int api_is_mousepresssed(lua_State *L) {
    const char *mousekey_str = luaL_checkstring(L, 1);
    lua_pop(L,1);
    M_MouseButton mousekey = _mousekey_str_to_mousekey(L, mousekey_str);
    bool result = M_input_mousepressed(mousekey);
    lua_pushboolean(L, result);
    return 1;
}

// [ mousekey -- bool ]]
static int api_is_mousereleased(lua_State *L) {
    const char *mousekey_str = luaL_checkstring(L, 1);
    lua_pop(L,1);
    M_MouseButton mousekey = _mousekey_str_to_mousekey(L, mousekey_str);
    bool result = M_input_mousereleased(mousekey);
    lua_pushboolean(L, result);
    return 1;
}

// [  -- number number  ]]
static int api_get_mouse(lua_State *L) {
    // M_Vec2i res = M_input_mouse();
    int x = M_input_mouse_x();
    int y = M_input_mouse_y();
    lua_pushinteger(L, x);
    lua_pushinteger(L, y);
    return 2;
}

// [  -- number ]
static int api_num_gamepads(lua_State *L) {
    lua_pushinteger(L, M_input_numgamepads());
    return 1;
}

// [  number -- string ]
static int api_get_gamepadname(lua_State *L) {
    int idx = luaL_checkinteger(L, 1);
    lua_pushstring(L,M_input_gamepadname(idx));
    return 1;
}

// [  number GamepadAxis -- integer ]
static int api_gamepad_axis(lua_State *L) {
    int idx = luaL_checkinteger(L, 1);
    const char *gamepadaxis_str = luaL_checkstring(L, 2);
    lua_pop(L,2);
    M_GamepadAxis gamepadaxis = _gamepadaxis_str_to_gamepadaxis(L, gamepadaxis_str);
    int result = M_input_gamepadaxis(idx, gamepadaxis);
    lua_pushinteger(L, result);
    return 1;
}


// [  number GamepadKey -- boolean ]
static int api_gamepad_down(lua_State *L) {
    int idx = luaL_checkinteger(L, 1);
    const char *gamepadkey_str = luaL_checkstring(L, 2);
    lua_pop(L,2);
    M_GamepadButton gamepadkey = _gamepadkey_str_to_gamepadkey(L, gamepadkey_str);
    bool result = M_input_gamepaddown(idx, gamepadkey);
    lua_pushboolean(L, result);
    return 1;
}


// [  number GamepadKey -- boolean ]
static int api_gamepad_pressed(lua_State *L) {
    int idx = luaL_checkinteger(L, 1);
    const char *gamepadkey_str = luaL_checkstring(L, 2);
    lua_pop(L,2);
    M_GamepadButton gamepadkey = _gamepadkey_str_to_gamepadkey(L, gamepadkey_str);
    bool result = M_input_gamepadpressed(idx, gamepadkey);
    lua_pushboolean(L, result);
    return 1;
}

// [  number GamepadKey -- boolean ]
static int api_gamepad_released(lua_State *L) {
    int idx = luaL_checkinteger(L, 1);
    const char *gamepadkey_str = luaL_checkstring(L, 2);
    lua_pop(L,2);
    M_GamepadButton gamepadkey = _gamepadkey_str_to_gamepadkey(L, gamepadkey_str);
    bool result = M_input_gamepadreleased(idx, gamepadkey);
    lua_pushboolean(L, result);
    return 1;
}



static const struct luaL_Reg lyte_input_lib[] = {
    {"is_keydown", api_is_keydown},
    {"is_keyrepeat", api_is_keyrepeat},
    {"is_keypressed", api_is_keypresssed},
    {"is_keyreleased", api_is_keyreleased},
    {"is_mousedown", api_is_mousedown},
    {"is_mousepressed", api_is_mousepresssed},
    {"is_mousereleased", api_is_mousereleased},
    {"get_mouse", api_get_mouse},
    {"num_gamepads", api_num_gamepads},
    {"get_gamepadname", api_get_gamepadname},
    {"get_gamepadaxis", api_gamepad_axis},
    {"is_gamepaddown", api_gamepad_down},
    {"is_gamepadpressed", api_gamepad_pressed},
    {"is_gamepadreleased", api_gamepad_released},
    {NULL, NULL} /* sentinel */
};

// -- open
int luaopen_lyte_input(lua_State *L) {
    luaL_register(L, "lyte", lyte_input_lib);
    lua_pop(L, 1);
    return 0;
}


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// RUNTIME


// [ string -- string|nil ]
static int api_loadtext(lua_State *L) {
    const char *path = lua_tostring(L, 1);
    char *data = NULL;
    size_t data_size = 0;
    if (M_path_exists(path)) {
        data_size = M_path_filesize(path);
        data = malloc(data_size);
        size_t read_bytes = M_path_readbytes(path, (void *)data, data_size);
        ASSERT_(data_size == read_bytes, "load text size issue");
        lua_pushlstring(L, data, data_size);
        LOG("DATA (%d): %s)\n",data_size, data);
        free(data);
    } else {
        // noop?
        // TODO:
        LOG("Could not find file: %s\n", path);
        lua_pushnil(L);
    }
    return 1;
}

// [ string string --  ]
static int api_savetext(lua_State *L) {
    const char *path = lua_tostring(L, 1);
    const char *data = lua_tostring(L, 2);
    size_t data_size = lua_strlen(L, 2);
    M_path_writebytes(path, (void *)data, data_size);
    return 0;
}

// [ string string --  ]
static int api_savetextappend(lua_State *L) {
    const char *path = lua_tostring(L, 1);
    const char *data = lua_tostring(L, 2);
    size_t data_size = lua_strlen(L, 2);
    M_path_appendbytes(path, (void *)data, data_size);
    return 0;
}

// [  --  ]
static int api_quit(lua_State *L) {
    (void)L;
    M_app_quit();
    return 0;
}


// [  -- number ]
static int api_getwindowwidth(lua_State *L) {
    (void)L;
    int w = M_app_getwindowwidth();
    lua_pushinteger(L, w);
    return 1;
}

// [  -- number ]
static int api_getwindowheight(lua_State *L) {
    (void)L;
    int h = M_app_getwindowheight();
    lua_pushinteger(L, h);
    return 1;
}

// [ boolean --  ]
static int api_setfullscreen(lua_State *L) {
    bool fs = lua_toboolean(L, 1);
    M_app_setfullscreen(fs);
    return 0;
}

// [  -- boolean  ]
static int api_getfullscreen(lua_State *L) {
    bool fs = M_app_getfullscreen();
    lua_pushboolean(L, fs);
    return 1;
}

// [ number number --  ]
static int api_setwindowsize(lua_State *L) {
    int w = lua_tointeger(L, 1);
    int h = lua_tointeger(L, 2);
    M_app_setwindowsize(w, h);
    return 0;
}

// [ number number --  ]
static int api_setwindowminsize(lua_State *L) {
    int w = lua_tointeger(L, 1);
    int h = lua_tointeger(L, 2);
    M_app_setwindowminsize(w, h);
    return 0;
}


// [ string --  ]
static int api_setwindowtitle(lua_State *L) {
    const char * str = lua_tostring(L, 1);
    M_app_settitle(str);
    return 0;
}

// [ string --  ]
static int api_setwindowicon(lua_State *L) {
    const char * str = lua_tostring(L, 1);
    M_app_seticon(str);
    return 0;
}

// [ boolean --  ]
static int api_setvsync(lua_State *L) {
    bool fs = lua_toboolean(L, 1);
    M_app_setvsync(fs);
    return 0;
}

// [  -- boolean  ]
static int api_getvsync(lua_State *L) {
    bool fs = M_app_getvsync();
    lua_pushboolean(L, fs);
    return 1;
}

// [ number number number number --  ]
static int api_set_margins(lua_State *L) {
    int l = luaL_checkinteger(L, 1);
    int r = luaL_checkinteger(L, 2);
    int t = luaL_checkinteger(L, 3);
    int b = luaL_checkinteger(L, 4);
    M_app_setmargins(l, r, t, b);
    return 0;
}

// [ number number number number --  ]
static int api_set_paddings(lua_State *L) {
    int l = luaL_checkinteger(L, 1);
    int r = luaL_checkinteger(L, 2);
    int t = luaL_checkinteger(L, 3);
    int b = luaL_checkinteger(L, 4);
    M_app_setpaddings(l, r, t, b);
    return 0;
}

static const struct luaL_Reg lyte_filesystem_lib[] = {
    {"read", api_loadtext},
    {"write", api_savetext},
    {"append", api_savetextappend},
};
int luaopen_lyte_filesystem(lua_State *L) {
    LOG("luaopen: filesystem\n");
    // luaL_register(L, "lyte.filesystem", lyte_filesystem_lib);
    luaL_register(L, "lyte", lyte_filesystem_lib);
    lua_pop(L, 1);
    return 0;
}


static const struct luaL_Reg lyte_runtime_lib[] = {
    // constructors
    {"Music", api_new_music_load},
    {"SoundData", api_new_sounddata_load},
    {"Sound", api_new_sound},

    {"Canvas", api_new_canvas},
    {"Image", api_new_image_load},
    {"quit", api_quit},

    {NULL, NULL} /* sentinel */
};

// -- open
int luaopen_lyte_runtime(lua_State *L) {
    LOG("luaopen: lyte_runtime\n");
    luaL_register(L, "lyte", lyte_runtime_lib);
    lua_pop(L, 1);
    return 0;
}



static const struct luaL_Reg lyte_direct_api_lib[] = {

    // music
    {"load_music", api_new_music_load},
    {"play_music", api_music_start},
    {"pause_music", api_music_pause},
    {"resume_music", api_music_resume},
    {"stop_music", api_music_stop},
    {"seek_music", api_music_seek},
    {"get_musiclength", api_music_getlength},
    {"get_musiclength_played", api_music_getlength_played},
    {"set_musicvolume", api_music_setvolume},
    {"get_musicvolume", api_music_getvolume},
    {"set_musicpitch", api_music_setpitch},
    {"get_musicpitch", api_music_getpitch},
    {"set_musicpan", api_music_setpan},
    {"get_musicpan", api_music_getpan},
    {"is_musicplaying", api_music_isplaying},

    // sounddata
    {"load_sounddata", api_new_sounddata_load},
    {"set_sounddatavolume", api_sounddata_setvolume},
    {"get_sounddatavolume", api_sounddata_getvolume},
    {"set_sounddatapitch", api_sounddata_setpitch},
    {"get_sounddatapitch", api_sounddata_getpitch},
    {"set_sounddatapan", api_sounddata_setpan},
    {"get_sounddatapan", api_sounddata_getpan},

    // sound
    {"new_sound", api_new_sound},
    {"set_soundvolume", api_sound_setvolume},
    {"get_soundvolume", api_sound_getvolume},
    {"set_soundpitch", api_sound_setpitch},
    {"get_soundpitch", api_sound_getpitch},
    {"set_soundpan", api_sound_setpan},
    {"get_soundpan", api_sound_getpan},
    {"play_sound", api_sound_play},
    {"pause_sound", api_sound_pause},
    {"resume_sound", api_sound_resume},
    {"stop_sound", api_sound_stop},
    {"is_soundplaying", api_sound_isplaying},

    // filesystem
    {"file_read", api_loadtext},
    {"file_write", api_savetext},
    {"file_append", api_savetextappend},

    // graphics
    {"new_canvas", api_new_canvas},
    {"load_image", api_new_image_load},

    // audio
    {"set_mastervolume", api_set_mastervolume},
    {"get_mastervolume", api_get_mastervolume},

    // window
    {"set_windowtitle",api_setwindowtitle},
    {"get_windowwidth",api_getwindowwidth},
    {"get_windowheight",api_getwindowheight},
    {"set_windowsize",api_setwindowsize},
    {"set_windowminsize",api_setwindowminsize},
    {"set_fullscreen", api_setfullscreen},
    {"get_fullscreen", api_getfullscreen},
    {"set_vsync", api_setvsync},
    {"get_vsync", api_getvsync},
    {"set_margins", api_set_margins},
    {"set_paddings", api_set_paddings},
    {"set_windowicon",api_setwindowicon},


    {NULL, NULL} /* sentinel */
};


int luaopen_lyte_direct_api(lua_State *L) {
    LOG("luaopen: direct_api\n");
    luaL_register(L, LYTE_DIRECT_API, lyte_direct_api_lib);
    // lua_pop(L, 1);
    return 0;
}


// static const struct luaL_Reg lyte_runtime_direct_api_lib[] = {
//     {"file_read", api_loadtext},
//     {"file_write", api_savetext},
//     {"file_append", api_savetextappend},
//     {"new_canvas", api_new_canvas},
//     {"load_image", api_new_image_load},


// };

// int luaopen_lyte_runtime_direct_api(lua_State *L) {
//     LOG("luaopen: runtime direct api\n");
//     luaL_register(L, LYTE_DIRECT_API, lyte_runtime_direct_api_lib);
//     lua_pop(L, 1);
//     return 0;
// }



///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


int lyteapi_open(lua_State *L) {
    (void)L;
    luaopen_lyte_runtime(L);
    luaopen_lyte_input(L);
    luaopen_lyte_graphics(L);
    luaopen_lyte_audio(L);
    luaopen_lyte_filesystem(L);
    // direct API
    luaopen_lyte_direct_api(L);
    return 0;
}
