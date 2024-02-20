//

// #include <stdio.h>
// #include <assert.h>
// #include <stdlib.h>
// #include <string.h>

#include "lyte_core.h"

// http://ode.org/wiki/index.php/Manual
#include <ode/ode.h>

#define LYTE_PHYSICS_MAX_CONTACTS 8
#define LYTE_PHYSICS_INIT_COLL_COUNT 8 // will double as needed


typedef struct _lyte_NearCallbackData {
    lyte_JointGroup jointgroup;
} _lyte_NearCallbackData ;

typedef struct _lyte_Collision {
    lyte_Body b1;
    lyte_Body b2;
    double pos_x;
    double pos_y;
    double depth;
} _lyte_Collision;

static _lyte_Collision *_collisions;
static int _coll_last_index;
static int _coll_curr_count;


static int _extend_collision_array(void) {
    // printf("!!! extending collision array doubling from: %d  (TODO REMOVE THIS LINE)\n", _coll_curr_count);
    _coll_curr_count *= 2; // double the size
    _collisions = realloc(_collisions, sizeof(_lyte_Collision)*_coll_curr_count);
    return 0;
}

static int _lyte_add_collision(lyte_Body b1, lyte_Body b2, double pos_x, double pos_y, double depth) {
    if(_coll_last_index > _coll_curr_count - 3) {
        _extend_collision_array();
    }
    // we'll need to add two entries for simpler indexing. possibly faster too.
    _collisions[_coll_last_index] = (_lyte_Collision){
        .b1 = b1,
        .b2 = b2,
        .pos_x = pos_x,
        .pos_x = pos_y,
        .depth = depth,
    };
    _coll_last_index++;
    _collisions[_coll_last_index] = (_lyte_Collision){
        .b1 = b2,
        .b2 = b1,
        .pos_x = pos_x,
        .pos_x = pos_y,
        .depth = depth,
    };
    _coll_last_index++;
    return 0;
}


static int _lyte_init_collisions(void) {
    _collisions = malloc(sizeof(_lyte_Collision)*LYTE_PHYSICS_INIT_COLL_COUNT);
    _coll_curr_count = LYTE_PHYSICS_INIT_COLL_COUNT;
    _coll_last_index = 0;
    return  0;
}

static int _lyte_cleanup_collisions(void) {
    free(_collisions);
    _coll_curr_count = 0;
    _coll_last_index = 0;
    return 0;
}

static int _lyte_clear_collisions(void) {
    _coll_last_index = 0;
    return 0;
}


int lyte_core_physics_init(void) {
    dInitODE2(0);
    _lyte_init_collisions();
    return 0;
}

int lyte_core_physics_cleanup(void) {
    dCloseODE();
    _lyte_cleanup_collisions();
    return 0;
}

int lyte_World_cleanup(lyte_World world) {
    dWorldDestroy(world);
    return 0;
}

int lyte_new_world(lyte_World *world) {
    *world = dWorldCreate();
    return 0;
}

int lyte_world_set_gravity(lyte_World world, double x, double y) {
    dWorldSetGravity(world, x, y, 0);
    return 0;
}

int lyte_world_set_ERP(lyte_World world, double erp) {
    dWorldSetERP(world, erp);
    return 0;
}

int lyte_world_set_CFM(lyte_World world, double cfm) {
    dWorldSetCFM(world, cfm);
    return 0;
}

int lyte_Body_cleanup(lyte_Body body) {
    dBodyDestroy(body);
    return 0;
}

int _lyte_body_2D_constraint(lyte_World world, lyte_Body body) { // do on object creation. creates a planejoint
    lyte_Joint plane2d_joint = dJointCreatePlane2D(world, 0);
    dJointAttach(plane2d_joint, body, 0);
    return 0;
}

// creates a 2D body (constrained with a Plane2D joint)
int lyte_new_body(lyte_World world, lyte_Body *body) {
    *body = dBodyCreate(world);
    _lyte_body_2D_constraint(world, *body);
    return 0;
}

int lyte_body_set_position(lyte_Body body, double x, double y) {
    dBodySetPosition(body, x, y, 0);
    return 0;
}

int lyte_body_get_position(lyte_Body body, double *x, double *y) {
    const double *pos = dBodyGetPosition(body);
    *x = pos[0];
    *y = pos[1];
    return 0;
}

int lyte_body_set_rotation(lyte_Body body, double angle) {
    dMatrix3 rot;
    dRFromAxisAndAngle(rot, 0, 0, 1, angle);
    dBodySetRotation(body, rot);
    return 0;
}

int lyte_body_get_rotation(lyte_Body body, double *angle) {
    const double *rot = dBodyGetRotation(body);
    *angle = atan2f(rot[4], rot[0]);
    return 0;
}

int lyte_body_set_linear_velocity(lyte_Body body, double x, double y) {
    dBodySetLinearVel(body, x, y, 0);
    return 0;
}

int lyte_body_get_linear_velocity(lyte_Body body, double *x, double *y) {
    const double *linvel = dBodyGetLinearVel(body);
    *x = linvel[0];
    *y = linvel[1];
    return 0;
}

int lyte_body_set_angular_velocity(lyte_Body body, double z) {
    dBodySetAngularVel(body, 0, 0, z);
    return 0;
}

int lyte_body_get_angular_velocity(lyte_Body body, double *z) {
    const double *angvel = dBodyGetAngularVel(body);
    *z = angvel[2];
    return 0;
}

int lyte_body_set_mass_circle(lyte_Body body, double mass, double radius) {
    dMass _m = {0};
    dMassSetSphereTotal(&_m, mass, radius);
    dBodySetMass(body, &_m);
    return 0;
}

int lyte_body_set_mass_rect(lyte_Body body, double mass, double width, double height) {
    dMass _m = {0};
    dMassSetBoxTotal(&_m, mass, width, height, 1);
    dBodySetMass(body, &_m);
    return 0;
}

int lyte_body_add_force(lyte_Body body, double fx, double fy) {
    dBodyAddForce(body, fx, fy, 0);
    return 0;
}

int lyte_body_add_torque(lyte_Body body, double fz) {
    dBodyAddTorque(body, 0, 0, fz);
    return 0;
}

int lyte_body_add_rel_force(lyte_Body body, double fx, double fy) {
    dBodyAddRelForce(body, fx, fy, 0);
    return 0;
}

int lyte_body_add_rel_torque(lyte_Body body, double fz) {
    dBodyAddRelTorque(body, 0, 0, fz);
    return 0;
}

int lyte_body_add_force_at(lyte_Body body, double fx, double fy, double px, double py) {
    dBodyAddForceAtPos(body, fx, fy, 0, px, py, 0);
    return 0;
}

int lyte_body_add_force_at_rel(lyte_Body body, double fx, double fy, double px, double py) {
    dBodyAddForceAtRelPos(body, fx, fy, 0, px, py, 0);
    return 0;
}

int lyte_body_add_rel_force_at(lyte_Body body, double fx, double fy, double px, double py) {
    dBodyAddRelForceAtPos(body, fx, fy, 0, px, py, 0);
    return 0;
}

int lyte_body_add_rel_force_at_rel(lyte_Body body, double fx, double fy, double px, double py) {
    dBodyAddRelForceAtRelPos(body, fx, fy, 0, px, py, 0);
    return 0;
}

int lyte_body_get_force(lyte_Body body, double *x, double *y) {
    const double *force = dBodyGetForce(body);
    *x = force[0];
    *y = force[1];
    return 0;
}

int lyte_body_get_torque(lyte_Body body, double *z) {
    const double *force = dBodyGetTorque(body);
    *z= force[2];
    return 0;
}

int lyte_body_set_kinematic(lyte_Body body, bool val) {
    // kinematic: doesn't react to forces. false by default
    if (val) { dBodySetKinematic(body); }
    else { dBodySetDynamic(body); }
    return 0;
}

int lyte_body_is_kinematic(lyte_Body body, bool *is_kinematic) {
    *is_kinematic = dBodyIsKinematic(body);
    return 0;
}


int lyte_Joint_cleanup(lyte_Joint joint) {
    dJointDestroy(joint);
    return 0;
}

int lyte_joint_get_body(lyte_Joint joint, int index, lyte_Body *body) {
    *body = dJointGetBody(joint, index);
    return 0;
}

int lyte_joint_get_class(lyte_Joint joint, lyte_JointClass *cls) {
    *cls = dJointGetType(joint);
    return 0;
}

int lyte_joint_attach(lyte_Joint joint, lyte_Body body1, lyte_Body body2) {
    dJointAttach(joint, body1, body2);
    return 0;
}

// Joint TODO: enable/disable joints. get/set custom data. are connected...
// Joint feedback TODO: set/get feedback (force/torque application to either body!) (TBD)

// int lyte_joint_set_hinge_axis(lyte_Joint joint, double z); // auto?
int lyte_joint_new_hinge(lyte_World world, lyte_JointGroup jointgroup, lyte_Joint *joint) {
    *joint = dJointCreateHinge(world, jointgroup);
    dJointSetHingeAxis(*joint, 0,0,1);
    return 0;
}

int lyte_joint_new_slider(lyte_World world, lyte_JointGroup jointgroup, lyte_Joint *joint) {
    *joint = dJointCreateSlider(world, jointgroup);
    return 0;
}

int lyte_joint_new_fixed(lyte_World world, lyte_JointGroup jointgroup, lyte_Joint *joint) {
    *joint = dJointCreateFixed(world, jointgroup);
    return 0;
}

int lyte_joint_set_hinge_anchor(lyte_Joint joint, double x, double y) {
    dJointSetHingeAnchor(joint, x, y, 0);
    return 0;
}
int lyte_joint_get_hinge_angle(lyte_Joint joint, double *angle) {
    *angle = dJointGetHingeAngle(joint);
    return 0;
}

int lyte_joint_get_hinge_angle_rate(lyte_Joint joint, double *anglerate) {
    *anglerate = dJointGetHingeAngleRate(joint);
    return 0;
}

int lyte_joint_get_hinge_anchor1(lyte_Joint joint, double *x, double *y) {
    dVector3 res = {0};
    dJointGetHingeAnchor(joint, res);
    *x = res[0];
    *y = res[1];
    return 0;
}

int lyte_joint_get_hinge_anchor2(lyte_Joint joint, double *x, double *y) {
    dVector3 res = {0};
    dJointGetHingeAnchor2(joint, res);
    *x = res[0];
    *y = res[1];
    return 0;
}

int lyte_joint_set_slider_axis(lyte_Joint joint, double x, double y) {
    dJointSetSliderAxis(joint, x, y, 0);
    return 0;
}

int lyte_joint_get_slider_axis(lyte_Joint joint, double *x, double *y) {
    dVector3 res = {0};
    dJointGetSliderAxis(joint, res);
    *x = res[0];
    *y = res[1];
    return 0;
}

int lyte_joint_get_slider_position(lyte_Joint joint, double *pos) {
    *pos = dJointGetSliderPosition(joint);
    return 0;
}

int lyte_joint_get_slider_position_rate(lyte_Joint joint, double *posrate) {
    *posrate = dJointGetSliderPositionRate(joint);
    return 0;
}

int lyte_joint_set_fixed(lyte_Joint joint) {
    dJointSetFixed(joint);
    return 0;
}


int lyte_Geom_cleanup(lyte_Geom geom) {
    dGeomDestroy(geom);
    return 0;
}

int lyte_geom_set_body(lyte_Geom geom, lyte_Body body) {
    dGeomSetBody(geom, body);
    return 0;
}

int lyte_geom_get_body(lyte_Geom geom, lyte_Body *body) {
    *body = dGeomGetBody(geom);
    return 0;
}


int lyte_geom_set_offset_position(lyte_Geom geom, double x, double y) {
    dGeomSetOffsetPosition(geom, x, y, 0);
    return 0;
}

int lyte_geom_get_offset_position(lyte_Geom geom, double *x, double *y) {
    const double *pos = dGeomGetOffsetPosition(geom);
    *x = pos[0];
    *y = pos[1];
    return 0;
}

int lyte_geom_set_offset_rotation(lyte_Geom geom, double angle) {
    dMatrix3 rot;
    dRFromAxisAndAngle(rot, 0, 0, 1, angle);
    dGeomSetOffsetRotation(geom, rot);
    return 0;
}

int lyte_geom_get_offset_rotation(lyte_Geom geom, double *angle) {
    const double *rot = dGeomGetOffsetRotation(geom);
    *angle = atan2f(rot[4], rot[0]);
    return 0;
}

int lyte_geom_clear_offset(lyte_Geom geom) {
    dGeomClearOffset(geom);
    return 0;
}

int lyte_geom_get_AABB(lyte_Geom geom, double *minx, double *miny, double *maxx, double *maxy) {
    double AABB[6];
    dGeomGetAABB(geom, AABB);
    *minx = AABB[0];
    *maxx = AABB[1];
    *miny = AABB[2];
    *maxy = AABB[3];
    return 0;
}

int lyte_geom_get_class(lyte_Geom geom, lyte_GeomClass *cls) {
    *cls = dGeomGetClass(geom);
    return 0;
}

int lyte_geom_set_category_bit(lyte_Geom geom, int category_bit) { // can have multiple. value between 0 and 63
    uint64_t bits = dGeomGetCategoryBits(geom);
    bits |= (1 << category_bit);
    dGeomSetCategoryBits(geom, bits);
    return 0;
}

int lyte_geom_is_category_bit_set(lyte_Geom geom, int category_bit, bool *is_set) {
    uint64_t bits = dGeomGetCategoryBits(geom);
    *is_set = bits & (1 << category_bit);
    return 0;
}

int lyte_geom_set_collide_bit(lyte_Geom geom, int collide_bit) { // can have multiple. value between 0 and 63
    uint64_t bits = dGeomGetCollideBits(geom);
    bits |= (1 << collide_bit);
    dGeomSetCollideBits(geom, bits);
    return 0;
}

int lyte_geom_is_collide_bit_set(lyte_Geom geom, int collide_bit, bool *is_set) {
    uint64_t bits = dGeomGetCollideBits(geom);
    *is_set = bits & (1 << collide_bit);
    return 0;
}

int lyte_new_geom_circle(lyte_Space space, double radius, lyte_Geom *geom) {
    *geom = dCreateSphere(space, radius);
    return 0;
}

int lyte_geom_circle_set_radius(lyte_Geom geom, double radius) {
    dGeomSphereSetRadius(geom, radius);
    return 0;
}

int lyte_geom_circle_get_radius(lyte_Geom geom, double *radius) {
    *radius = dGeomSphereGetRadius(geom);
    return 0;
}

int lyte_geom_circle_get_point_depth(lyte_Geom geom, double x, double y, double *depth) { // depth: inside positive, outside negative, surface zero
    *depth = dGeomSpherePointDepth(geom, x, y, 0);
    return 0;
}

#define _RECT_GEOM_DEPTH_ 1 // TODO: is 1 a good value for depth here?

int lyte_new_geom_rect(lyte_Space space, double width, double height, lyte_Geom *geom) {
    *geom = dCreateBox(space, width, height, _RECT_GEOM_DEPTH_);
    return 0;
}

int lyte_geom_rect_set_size(lyte_Space geom, double width, double height) {
    dGeomBoxSetLengths(geom, width, height, _RECT_GEOM_DEPTH_);
    return 0;
}

int lyte_geom_rect_get_size(lyte_Space geom, double *width, double *height) {
    dVector3 lengths;
    dGeomBoxGetLengths(geom, lengths);
    *width = lengths[0];
    *height = lengths[1];
    return 0;
}

int lyte_geom_rect_get_point_depth(lyte_Geom geom, double x, double y, double *depth) { // depth: inside positive, outside negative, surface zero
    *depth = dGeomBoxPointDepth(geom, x, y, 0);
    return 0;
}

int lyte_Space_cleanup(lyte_Space space) {
    dSpaceDestroy(space);
    return 0;
}

int lyte_new_space_simple(lyte_Space *space) {
    *space = dSimpleSpaceCreate(0);
    return 0;
}


int lyte_JointGroup_cleanup(lyte_JointGroup jointgroup) {
    dJointGroupDestroy(jointgroup);
    return 0;
}

int lyte_new_jointgroup(lyte_JointGroup *jointgroup) {
    *jointgroup = dJointGroupCreate(0);
    return 0;
}

int _lyte_jointgroup_empty(lyte_JointGroup jointgroup) {
    dJointGroupEmpty(jointgroup);
    return 0;
}


// WORLD UPDATE

int _lyte_body_2D_fix_angular_drift(lyte_Body body, bool z_rotate_enabled) { // do on each update.
    const double *rot = dBodyGetAngularVel(body);
    const double *quat_ptr;
    double quat[4], quat_len;
    quat_ptr = dBodyGetQuaternion(body);
    quat[0] = quat_ptr[0];
    quat[1] = 0;
    quat[2] = 0;
    quat[3] = !z_rotate_enabled ? 0 : quat_ptr[3];
    quat_len = sqrt(quat[0] * quat[0] + quat[3] * quat[3]);
    quat[0] /= quat_len;
    quat[3] /= quat_len;
    dBodySetQuaternion(body, quat);
    dBodySetAngularVel(body, 0, 0, !z_rotate_enabled ? 0 : rot[2]);
    return 0;
}

int lyte_world_update_accurate(lyte_World world, double step_size) {
    dWorldStep(world, step_size);
    return 0;
}

int lyte_world_update_fast(lyte_World world, double step_size) {
    dWorldQuickStep(world, step_size);
    return 0;
}


// COLLISIONS


int lyte_body_get_coll_count(lyte_Body body, int *count) {
    int cnt = 0;
    for (int i = 0; i < _coll_last_index; i++) {
        if (body == _collisions[i].b1) {
            cnt ++;
        }
    }
    *count = cnt;
    return 0;
}

int lyte_body_get_coll_data_at(lyte_Body body, int index, lyte_Body *body2, double *pos_x, double *pos_y, double *depth) {
    int cnt = 0;
    for (int i = 0; i < _coll_last_index; i++) {
        if (body == _collisions[i].b1) {
            cnt ++;
            if (cnt == index) {
                _lyte_Collision *c = &_collisions[i];
                *body2 = c->b2;
                *pos_x = c->pos_x;
                *pos_y = c->pos_y;
                *depth = c->depth;
                break;
            }
        }
    }
    return 0;
}

void _lyte_nearcallback(void *data, lyte_Geom o1, lyte_Geom o2) {
    dContact contacts[LYTE_PHYSICS_MAX_CONTACTS] = {0};
    // TODO: should these be parameters? (add to lyte_NearCallbackData?)
    for (int i = 0; i < LYTE_PHYSICS_MAX_CONTACTS; i++) {
        contacts[i].surface.mode = dContactBounce | dContactSoftCFM;
        contacts[i].surface.mu = dInfinity;
        contacts[i].surface.mu2 = 0;
        contacts[i].surface.bounce = 0.01;
        contacts[i].surface.bounce_vel = 0.1;
        contacts[i].surface.soft_cfm = 0.01;
    }
    int numc = dCollide(o1, o2, LYTE_PHYSICS_MAX_CONTACTS, &contacts[0].geom, sizeof(dContact));
    if (numc > 0) {
        lyte_Body b1 = dGeomGetBody(o1);
        lyte_Body b2 = dGeomGetBody(o2);
        lyte_World world = dBodyGetWorld(b1);
        for (int i=0; i<numc; i++) {
            _lyte_NearCallbackData *cbdata = data;
            lyte_JointGroup jointgroup = cbdata->jointgroup;
            lyte_Joint c = dJointCreateContact(world, jointgroup, contacts+i);
            dJointAttach(c, b1, b2);
            // also save the contact information here.. we need some structure for it, but querying etc will need this
            // since we don't want lyte to have many events, collision information will be "polled"
            dContactGeom g = contacts[i].geom;
            _lyte_add_collision(b1, b2, g.pos[0], g.pos[1], g.depth); // Consider extending _lyte_Collision with normal information. and perhaps which geoms are hitting too.
        }
    }
}

int lyte_coll_update_check_collisions(lyte_World world, lyte_Space space, lyte_JointGroup jointgroup) {
    // delete previous temporary collision joints. engine uses these
    _lyte_jointgroup_empty(jointgroup);
    // delete lyte tracking of collision information between bodies.
    _lyte_clear_collisions();
    // TODO: consider adding contact parameter configuration. right now they're hardcoded in nearcallback
    _lyte_NearCallbackData cbdata = {0};
    cbdata.jointgroup = jointgroup;
    dSpaceCollide(space, &cbdata, (dNearCallback*)&_lyte_nearcallback);

    return 0;
}


int lyte_coll_update_correct_drifts(lyte_Space space) {
    int num = dSpaceGetNumGeoms(space);
    for (int i=0; i<num; i++) {
        lyte_Geom geom = dSpaceGetGeom(space, i);
        lyte_Body body = dGeomGetBody(geom);
        _lyte_body_2D_fix_angular_drift(body, true);
    }

    return 0;
}