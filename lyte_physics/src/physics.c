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
    lytephysics_state.world = dWorldCreate();
    lyte_set_physics_engine(LYTE_PHYSICSENGINESTATE_OFF);
    return 0;
}

int lyte_physics_cleanup(void) {
    printf("Phys cleanup\n");
    if (lytephysics_state.world) {
        dWorldDestroy(lytephysics_state.world);
        lytephysics_state.world = NULL;
    }
    return 0;
}

int lyte_set_physics_engine(lyte_PhysicsEngineState state) {
    lytephysics_state.enginestate = state;
    switch (state) {
        case LYTE_PHYSICSENGINESTATE_2D: {
            printf("SET PHYSICS ENGINE (2D)\n");

        } break;
        case LYTE_PHYSICSENGINESTATE_3D: {
            printf("SET PHYSICS ENGINE (3D)\n");

        } break;
        case LYTE_PHYSICSENGINESTATE_OFF: {
            printf("SET PHYSICS ENGINE (OFF)\n");

        } break;
    }
    return 0;
}