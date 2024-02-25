// mg

#ifndef MAP_H_INCLUDED
#define MAP_H_INCLUDED

#include <stddef.h>
#include <stdint.h>

typedef struct mg_Map {
    size_t count;
    size_t node_size;
    uint8_t *data;
} mg_Map;

int mg_map_init(mg_Map *m, size_t value_size, size_t initial_count);
int mg_map_cleanup(mg_Map *m);
void *mg_map_get(mg_Map *m, uint32_t key);
int mg_map_add(mg_Map *m, uint32_t key, void *object);
int mg_map_set(mg_Map *m, uint32_t key, void *object);
int mg_map_del(mg_Map *m, uint32_t key);
void *mg_map_getindex(mg_Map *m, size_t idx, uint32_t *key);

#endif  // MAP_H_INCLUDED