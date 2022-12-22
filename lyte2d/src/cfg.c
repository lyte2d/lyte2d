/* (c) mg */

#include "lyte.h"
#include <morebase.h>
#include <stdio.h>

int get_config(M_Config *cfg, int argc, char *argv[]) {
    (void)argc;
    (void)argv;
    // TODO: sokol_args + use exe name to set ziparchive loc
    int err = 0;
    for (int i=0; i<argc; i++) {
        LOG("arg: %d value: %s\n", i, argv[i]);
    }

    // TODO: read these from app.cfg (or sth) file
    cfg->title = "lyte2d";
    cfg->icon = "";
    cfg->width =  400; //800*2;
    cfg->height = 250; //500*2;
    cfg->fullscreen = false;
    cfg->resizable = true;
    cfg->defaultfiltermode = M_FILTER_NEAREST;
    cfg->defaultblendmode = M_BLENDMODE_BLEND;
    cfg->vsync = true;
    cfg->argc = argc;
    cfg->argv = argv;

    return err;
}



