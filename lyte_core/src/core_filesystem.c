//

#include <stdio.h>
#include <assert.h>
#include <stdlib.h>
#include <string.h>

#include "lyte_core.h"
#include "map.h"

#include "physfs.h"
#include "sokol_fetch.h"

int lyte_core_filesystem_init(void) {
    int success = PHYSFS_init("");

    if (!success) {
        int errcode = PHYSFS_getLastErrorCode();
        fprintf(stderr, "Failed to init PHYSFS: %d %d, %s\n", success, errcode, PHYSFS_getErrorByCode(errcode));
        return 5555;
    }

    sfetch_setup(&(sfetch_desc_t){0});

    return 0;
}

int lyte_core_filesystem_cleanup(void) {

    sfetch_shutdown();
    PHYSFS_deinit();

    return 0;
}

int lyte_core_filesystem_update_tasks(void) {
    sfetch_dowork();
    return 0;
}

