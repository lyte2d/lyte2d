//

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>

#include "lyte_physics.h"
#include "ode/ode.h"

lyte_PhysicsData lytephysics_data = {0};


int lyte_physics_init(void) {
    // printf("Phys init\n");
    lytephysics_data.world = dWorldCreate();
    lyte_set_physics_engine(LYTE_PHYSICSSTATE_OFF);
    return 0;
}

int lyte_physics_cleanup(void) {
    // printf("Phys cleanup\n");
    if (lytephysics_data.world) {
        dWorldDestroy(lytephysics_data.world);
        lytephysics_data.world = NULL;
    }
    return 0;
}

int lyte_set_physics_engine(lyte_PhysicsState state) {
    lytephysics_data.enginestate = state;
    switch (state) {
        case LYTE_PHYSICSSTATE_ON: {
            // printf("SET PHYSICS ENGINE ON\n");

        } break;
        case LYTE_PHYSICSSTATE_PAUSED: {
            // printf("SET PHYSICS ENGINE PAUSED\n");

        } break;
        case LYTE_PHYSICSSTATE_OFF: {
            // printf("SET PHYSICS ENGINE OFF\n");

        } break;
    }
    return 0;
}