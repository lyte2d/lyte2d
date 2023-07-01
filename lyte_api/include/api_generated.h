// BEGIN: This file is generated
// -- do not edit directly use code gen --
//---------------------------------------------------------------------------------------

// lyte api header

#ifndef API_GENERATED_H_INCLUDED
#define API_GENERATED_H_INCLUDED

#include <stddef.h>
#include <stdint.h>
#include <stdbool.h>

#include "api.enums.h"

typedef struct lyte_FloatVec4 { float data[4]; size_t count; } lyte_FloatVec4;
// Dict: skipped in C api for now: UniformNamesToTypes
typedef struct lyte_Image { void *ptr; } lyte_Image;
typedef struct lyte_Font { void *ptr; } lyte_Font;
typedef struct lyte_Music { void *ptr; } lyte_Music;
typedef struct lyte_Sound { void *ptr; } lyte_Sound;
typedef struct lyte_Shader { void *ptr; } lyte_Shader;
typedef struct lyte_ShaderBuilder { void *ptr; } lyte_ShaderBuilder;
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
