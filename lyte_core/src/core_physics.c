//

// #include <stdio.h>
// #include <assert.h>
// #include <stdlib.h>
// #include <string.h>

#include "lyte_core.h"

#include <ode/ode.h>

dWorldID world = {0};

int lyte_physics_init(void) {
    world = dWorldCreate();
    // printf("ODE initialized. world: %p\n", world);
    return 0;
}

int lyte_physics_cleanup(void) {
    dWorldDestroy(world);
    return 0;
}