#include <stdio.h>
#include <stdbool.h>
#include "map.h"

typedef struct TestX {
    bool a;
    int x;
    uint64_t y;
    double z;
} TestX;

mg_Map tests;

int main(void) {
    printf("hello\n");
    mg_map_init(&tests, sizeof(TestX), 2);

    TestX A = {.a=true, .x=11, .z=21.0, .y=30 };
    TestX B = {.a=true, .x=12, .z=22.0, .y=30 };
    TestX C = {.a=true, .x=13, .z=23.0, .y=30 };

    // test resize
    printf("C: %zu\n", tests.count);
    mg_map_add(&tests, 123, &A);
    printf("C: %zu\n", tests.count);
    mg_map_add(&tests, 222, &B);
    printf("C: %zu\n", tests.count);
    mg_map_add(&tests, 444, &C);
    printf("C: %zu\n", tests.count);

    // test get
    TestX *L = mg_map_get(&tests, 123);
    if (L != NULL) {
        printf("get: %d %f\n", L->x, L->z);
    }

    // test set
    mg_map_set(&tests, 123, &B);
    L = mg_map_get(&tests, 123);
    if (L != NULL) {
        printf("get: %d %f\n", L->x, L->z);
    }

    // test del
    mg_map_del(&tests, 123);
    L = mg_map_get(&tests, 123);
    if (L != NULL) {
        printf("failed del. get: %d %f\n", L->x, L->z);
    } else {
        printf("del successful\n");
    }

    // add more (overwrite deleted parts)
    printf("C: %zu\n", tests.count);
    mg_map_add(&tests, 555, &C);
    mg_map_add(&tests, 666, &B);
    printf("C: %zu\n", tests.count);
    mg_map_add(&tests, 777, &A);
    printf("C: %zu\n", tests.count);

    // test iter
    for (int i=0; i<tests.count;i++) {
        uint32_t k = 0;
        TestX *t = mg_map_getindex(&tests, i, &k);
        printf("item %d has key %d val--%d--%f\n", i, k, t->x, t->z);
    }

    // test (some) error cases
    TestX *t1 = mg_map_get(NULL, 10);
    if (t1 != NULL) { printf("err - get NULL\n"); } else { printf("pass - get NULL\n"); }
    t1 = mg_map_get(&tests, 0);
    if (t1 != NULL) { printf("err - get 0 key\n"); } else { printf("pass - get 0 key\n"); }
    printf("test add NULL map (should be non zero): %d\n", mg_map_add(NULL, 10, &A));
    printf("test add zero key (should be non zero): %d\n", mg_map_add(&tests, 0, &A));
    printf("test add NULL object (should be non zero): %d\n", mg_map_add(&tests, 10, NULL));

    printf("bye\n");
}
