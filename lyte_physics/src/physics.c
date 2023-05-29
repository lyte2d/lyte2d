//

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>

#include "lyte_physics.h"
#include "ode/ode.h"

lyte_PhysicsState lytephysics_state = {0};


int lyte_physics_init(void) {
    printf("Phys init\n");
    dWorldCreate();
    return 0;
}

int lyte_physics_cleanup(void) {
    printf("Phys cleanup\n");
    return 0;
}