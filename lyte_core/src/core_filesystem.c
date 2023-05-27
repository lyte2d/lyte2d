//

#include <stdio.h>
#include <assert.h>
#include <stdlib.h>
#include <string.h>

#include "lyte_core.h"
#include "map.h"

#include "physfs.h"
#include "sokol_fetch.h"


#ifndef INIT_NUM_FETCHITEMS
#define INIT_NUM_FETCHITEMS 10
#endif

typedef struct FetchItem {
    uint32_t handle;
    const char *name;    // path on http or local disk
    const char *path;    // path on http or local disk
    const char *mount_path;
    size_t est_max_size;
    bool done;
    bool failed;
    int error_code;
    void *buf;
    size_t buf_size;
} FetchItem;

static mg_Map fetchitems;

int lyte_core_filesystem_init(void) {
    int success = PHYSFS_init("");
    if (!success) {
        int errcode = PHYSFS_getLastErrorCode();
        fprintf(stderr, "Failed to init PHYSFS: %d %d, %s\n", success, errcode, PHYSFS_getErrorByCode(errcode));
        return errcode;
    }
    sfetch_setup(&(sfetch_desc_t){0});
    mg_map_init(&fetchitems, sizeof(FetchItem), INIT_NUM_FETCHITEMS);

    return 0;
}

int lyte_core_filesystem_cleanup(void) {
    mg_map_cleanup(&fetchitems);

    sfetch_shutdown();
    PHYSFS_deinit();
    return 0;
}

int lyte_core_filesystem_update_tasks(void) {
    sfetch_dowork();
    return 0;
}

bool lyte_core_filesystem_check_fetch_file_in_progress(uint32_t handle) {
    FetchItem *fi = mg_map_get(&fetchitems, handle);
    if (!fi) {
        fprintf(stderr, "Unknown fetch id: %d\n", handle);
        return false;
    }
    return !fi->done;
}

bool lyte_core_filesystem_check_fetch_file_failed(uint32_t handle) {
    FetchItem *fi = mg_map_get(&fetchitems, handle);
    if (!fi) {
        fprintf(stderr, "Unknown fetch id: %d\n", handle);
        return true;
    }
    return fi->failed;
}


bool lyte_core_filesystem_check_fetch_file_succeeded(uint32_t handle) {
    FetchItem *fi = mg_map_get(&fetchitems, handle);
    if (!fi) {
        fprintf(stderr, "Unknown fetch id: %d\n", handle);
        return false;
    }
    return fi->done && !fi->failed;
}

static void fetch_file_callback(const sfetch_response_t* response) {
    uint32_t handle = response->handle.id; // same handle as the request. so we can find the fetch item
    FetchItem *fi = mg_map_get(&fetchitems, handle);
    if (!fi) {
        fprintf(stderr, "Callback: shouldn't happen: Unknown fetch id: %d\n", handle);
        return;
    }
    if (response->fetched) {
        fi->done = true;
        fi->buf_size = response->data.size;
        fi->buf = realloc(fi->buf, fi->buf_size);
        // memcpy(fi->buf, response->buffer.ptr, fi->buf_size);
        // printf("Try: ptr %p  name %s path %s mntpath %s bufsize %zu resbufsize %zu\n", fi->buf, fi->name, fi->path, fi->mount_path, fi->buf_size, response->buffer.size);
        int success = PHYSFS_mountMemory(fi->buf, fi->buf_size, NULL, fi->name, fi->mount_path, 1);

        if (!success) {
            int errcode = PHYSFS_getLastErrorCode();
            fprintf(stderr, "Failed to mount zip '%s' %s %s (fetched async): PHYSFS: %d %d, %s\n", fi->path, fi->name, fi->mount_path, success, errcode, PHYSFS_getErrorByCode(errcode));
            fi->failed = true;
            fi->error_code = errcode;
            return;
        } else {
            fi->failed = false;
            fi->error_code = 0;
        }
    } else {
        if (response->failed) {
            fi->error_code = response->error_code;
            switch (response->error_code) {
                case SFETCH_ERROR_FILE_NOT_FOUND: {
                    // TODO: fi->error_string field, and populate accordingly
                    // fprintf(stderr,"Fetch: failed: file not found: '%s'\n", fi->path);
                } break;
                case SFETCH_ERROR_BUFFER_TOO_SMALL: {
                    fprintf(stderr,"Fetch: failed. file: '%s'. Buffer size '%zu' too small. Should be '%zu'\n", fi->path, fi->buf_size, response->buffer.size);
                } break;
                default: {
                    fprintf(stderr,"Fetch: '%s' failed with: %d\n", fi->path, response->error_code);
                } break;
            }
        } else if (response->cancelled) {
            fprintf(stderr,"Fetch: '%s' cancelled\n", fi->path);
            fi->error_code = -1001;
        } else {
            fprintf(stderr,"Fetch: '%s' unknown status\n", fi->path);
            fi->error_code = -1002;
        }
        fi->done = true;
        fi->failed = true;
        fi->buf_size = 0;
        free(fi->buf);
    }
}

uint32_t lyte_core_filesystem_fetch_file_async(const char *name, const char *path, size_t est_max_size, const char *mount_path) {
    void *buf = malloc(est_max_size);
    sfetch_handle_t sfh = sfetch_send(&(sfetch_request_t){
        .path = path,
        .callback = fetch_file_callback,
        .buffer.ptr = buf,
        .buffer.size = est_max_size,
    });
    FetchItem _fetchitem = {0};
    _fetchitem.handle = sfh.id;
    mg_map_add(&fetchitems, _fetchitem.handle, &_fetchitem);
    FetchItem *fi = mg_map_get(&fetchitems, _fetchitem.handle);

    fi->name = name;
    fi->path = path;
    fi->mount_path = mount_path;
    fi->failed = false;
    fi->done = false;
    fi->buf = buf;
    fi->buf_size  = est_max_size;

    return _fetchitem.handle;
}

int lyte_core_filesystem_set_writeable_path(const char* path) {
// #if defined(__EMSCRIPTEN__)
//     path=".";
// #endif
    int success = PHYSFS_setWriteDir(path);
    if (!success) {
        int errcode = PHYSFS_getLastErrorCode();
        fprintf(stderr, "Failed to set PHYSFS write dir: %d %d, %s\n", success, errcode, PHYSFS_getErrorByCode(errcode));
        return errcode;
    }
    return 0;
}

int lyte_core_filesystem_add_readable_path(const char* path, const char *mount_path) {
// #if defined(__EMSCRIPTEN__)
//     path=".";
// #endif
    int success = PHYSFS_mount(path, mount_path, 1);
    if (!success) {
        int errcode = PHYSFS_getLastErrorCode();
        fprintf(stderr, "Failed to mount memory zip: PHYSFS: %d %d, %s\n", success, errcode, PHYSFS_getErrorByCode(errcode));
        return errcode;
    }
    return 0;
}

int lyte_core_filesystem_add_path_memory(const char *path, void *buf, size_t size, const char *mount_path) {
    int success = PHYSFS_mountMemory(buf, size, NULL, path, mount_path, 1);
    if (!success) {
        int errcode = PHYSFS_getLastErrorCode();
        fprintf(stderr, "Failed to mount memory zip: PHYSFS: %d %d, %s\n", success, errcode, PHYSFS_getErrorByCode(errcode));
        return errcode;
    }
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

    // TODO: small leak!
    // free(buf);   // TODO: test if this is a problem, or if we need to do this in another frame
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
