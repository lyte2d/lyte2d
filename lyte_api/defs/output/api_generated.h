// GENERATED
// (c) 2023 MG

#ifndef API_GENERATED_H_INCLUDED
#define API_GENERATED_H_INCLUDED

#include <stddef.h>
#include <stdint.h>
#include <stdbool.h>

// header file: do not edit directly
// (use codegen to update this file)

typedef struct lyte_Image { void *ptr; } lyte_Image;
typedef struct lyte_Font { void *ptr; } lyte_Font;
typedef struct lyte_Music { void *ptr; } lyte_Music;
typedef struct lyte_Sound { void *ptr; } lyte_Sound;
typedef struct lyte_Shader { void *ptr; } lyte_Shader;
typedef struct lyte_ShaderBuilder { void *ptr; } lyte_ShaderBuilder;
typedef union lyte_ShaderUniformValue {
    float float_val;
    struct { float *values; size_t count; } float_list;
    lyte_Image image_val;
 } lyte_ShaderUniformValue;

#include "api.enums.h" // all the enums (possibly platform/implementation specific)

#endif  // API_GENERATED_H_INCLUDED
