//

#ifndef LYTE_PHYSICS_H_INCLUDED
#define LYTE_PHYSICS_H_INCLUDED


#include "api_generated.h" // types and enums



typedef struct lyte_PhysicsData {
    lyte_PhysicsState enginestate;
    void *world;

} lyte_PhysicsData;

extern lyte_PhysicsData lytephysics_data;


int lyte_physics_init(void);
int lyte_physics_cleanup(void);


int lyte_set_physics_engine(lyte_PhysicsState state);

#endif  // LYTE_PHYSICS_H_INCLUDED
