//

#ifndef LYTE_PHYSICS_H_INCLUDED
#define LYTE_PHYSICS_H_INCLUDED


#include "api_generated.h" // types and enums


typedef struct lyte_PhysicsState {
    lyte_PhysicsEngineState enginestate;
} lyte_PhysicsState;

extern lyte_PhysicsState lytephysics_state;

int lyte_physics_init(void);
int lyte_physics_cleanup(void);

#endif  // LYTE_PHYSICS_H_INCLUDED
