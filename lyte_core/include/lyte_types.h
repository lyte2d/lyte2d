// BEGIN: This file is generated
// -- do not edit directly use code gen --
//---------------------------------------------------------------------------------------


// TODO REMOVE



#ifndef API_GENERATED_H_INCLUDED
#define API_GENERATED_H_INCLUDED

#include <stddef.h>
#include <stdint.h>
#include <stdbool.h>

typedef void *lyte_Image;
typedef void *lyte_ImageBatch;
typedef void *lyte_Font;
typedef void *lyte_Music;
typedef void *lyte_Sound;
typedef void *lyte_ShaderBuilder;
typedef void *lyte_Shader;


typedef void *lyte_World;
typedef void *lyte_Body;
typedef void *lyte_Space;
typedef void *lyte_JointGroup;
typedef void *lyte_Geom;
typedef void *lyte_Joint;

// TODO: remove
struct M{ int x, y; };

typedef struct lyte_FloatVec4 { float data[4]; size_t count; } lyte_FloatVec4;
typedef struct lyte_ShaderUniformValue {
    int which;
    union {
        float float_val;
        lyte_FloatVec4 vec_val;
        lyte_Image sampler2D_val;
    } options;
} lyte_ShaderUniformValue;

#endif  // API_GENERATED_H_INCLUDED

//---------------------------------------------------------------------------------------
// EOF: This file is generated
