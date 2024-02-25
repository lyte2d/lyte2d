// mg

#include <stdlib.h>
#include <string.h>
#include "map.h"

int mg_map_init(mg_Map *m, size_t value_size, size_t initial_count) {
    if (m == NULL) { return -1; }
    if (value_size <= 0) { return -10; }
    if (initial_count <=0) { return -11; }
    if (m->data != NULL) { return -20; }

    m->node_size = value_size + sizeof(uint32_t);
    m->count = initial_count;
    size_t total = m->node_size * m->count;
    m->data = malloc(total);
    memset(m->data, 0, total);

    return 0;
}

int mg_map_cleanup(mg_Map *m) {
    if (m == NULL) { return -1; }
    if (m->data == NULL) { return -2; }

    free(m->data);
    m->node_size = 0;
    m->count = 0;

    return 0;
}

void *mg_map_get(mg_Map *m, uint32_t key) {
    if (m == NULL || m->data == NULL || key <= 0) { return NULL; }

    void *value = NULL;
    size_t ns = m->node_size;
    uint8_t *data = m->data;

    for (size_t i=0; i<m->count; i++) {
        uint32_t k = *(uint32_t *)(data + i*ns);
        if (k == key) {
            value = data + i*ns + sizeof(uint32_t);
            break;
        }
    }

    return value;
}

void *mg_map_getindex(mg_Map *m, size_t idx, uint32_t *key) {
    if (m == NULL || m->data == NULL) { return NULL; }
    if (idx < 0 || idx >= m->count) { return NULL; }

    uint8_t *place = NULL;
    if (idx < m->count) {
        uint8_t *loc;
        loc = m->data + idx * m->node_size;
        if (key != NULL) {
            *key = *(uint32_t *)loc;
        }
        place = loc + sizeof(uint32_t);
    }

    return place;
}

int mg_map_add(mg_Map *m, uint32_t key, void *object) {
    if (m == NULL) { return -1; }
    if (m->data == NULL) { return -2; }
    if (key == 0) { return -3; }
    if (object == NULL) { return -4; }

    uint8_t *place = NULL;
    size_t ns = m->node_size;
    uint8_t *data = m->data;

    for (size_t i=0; i<m->count; i++) {
        uint32_t k = *(uint32_t *)(data + i*ns);
        if (k == 0) {
            place = data + i*ns + sizeof(uint32_t);
            break;
        }
    }

    if (place == NULL) {
        // resize
        size_t total = m->node_size * m->count * 2;
        m->data = realloc(m->data, total);
        memset(m->data + total/2, 0, total/2);
        m->count = m->count * 2;
        place = m->data + total/2 + sizeof(uint32_t);
    }

    *(uint32_t *)(place - sizeof(uint32_t)) =  key;
    memcpy(place, object, m->node_size - sizeof(uint32_t));

    return 0;
}

int mg_map_set(mg_Map *m, uint32_t key, void *object) {
    if (m == NULL) { return -1; }
    if (m->data == NULL) { return -2; }
    if (key == 0) { return -3; }
    if (object == NULL) { return -4; }

    uint8_t *place = mg_map_get(m, key);
    if (place == NULL) {
        mg_map_add(m, key, object);
    } else {
        *(uint32_t *)(place - sizeof(uint32_t)) = key;
        memcpy(place, object, m->node_size - sizeof(uint32_t));
    }

    return 0;
}

int mg_map_del(mg_Map *m, uint32_t key) {
    if (m == NULL) { return -1; }
    if (m->data == NULL) { return -2; }
    if (key == 0) { return -3; }

    uint8_t *place = mg_map_get(m, key);
    if (place != NULL) {
        *(uint32_t *)(place - sizeof(uint32_t)) = (uint32_t)0;
        memset(place, 0, m->node_size - sizeof(uint32_t));
    }

    return 0;
}
