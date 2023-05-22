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



int lyte_load_textfile(const char * path, const char * *val) {
    PHYSFS_File *file = PHYSFS_openRead(path);
    if (file == NULL) {
        int errcode = PHYSFS_getLastErrorCode();
        const char *errstr = PHYSFS_getErrorByCode(errcode);
        fprintf(stderr, "File '%s' error %s\n", path, errstr);
        return errcode;
    }
    size_t len = PHYSFS_fileLength(file);
    uint8_t *buf = malloc(len+1);
    size_t read_len = PHYSFS_readBytes(file, buf, len);
    if (len != read_len) {
        fprintf(stderr, "File not fully read. Path: %s. File size is %zu bytes, but read %zu bytes.\n", path, len, read_len);
        return 1;
    }
    buf[len] = 0; // ensure '\0' at the end of the string
    *(char **)val = (char *)buf;

    free(buf);   // TODO: test if this is a problem, or if we need to do this in another frame
    PHYSFS_close(file);
    return 0;
}

int lyte_save_textfile(const char * path, const char * data) {
    size_t sz = strlen(data);
    PHYSFS_File *file = PHYSFS_openWrite(path);
    if (file == NULL) {
        int errcode = PHYSFS_getLastErrorCode();
        const char *errstr = PHYSFS_getErrorByCode(errcode);
        fprintf(stderr, "File '%s' error %s\n", path, errstr);
        return errcode;
    }
    PHYSFS_writeBytes(file, data, sz);
    PHYSFS_close(file);
    return 0;
}

int lyte_save_textfile_append(const char * path, const char * data) {
    size_t sz = strlen(data);
    PHYSFS_File *file = PHYSFS_openAppend(path);
    if (file == NULL) {
        int errcode = PHYSFS_getLastErrorCode();
        const char *errstr = PHYSFS_getErrorByCode(errcode);
        fprintf(stderr, "File '%s' error %s\n", path, errstr);
        return errcode;
    }
    PHYSFS_writeBytes(file, data, sz);

    PHYSFS_close(file);
    return 0;
}
