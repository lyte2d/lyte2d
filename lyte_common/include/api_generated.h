// GENERATED
// (c) 2023 MG

#ifndef API_GENERATED_H_INCLUDED
#define API_GENERATED_H_INCLUDED

#include <stddef.h>
#include <stdint.h>
#include <stdbool.h>

// header file: do not edit directly
// (use codegen to update this file)

typedef struct lyte_ShaderBuilder { unsigned handle; } lyte_ShaderBuilder;
typedef struct lyte_Shader { unsigned handle; } lyte_Shader;
typedef struct lyte_Image { unsigned handle; } lyte_Image;
typedef struct lyte_Font { unsigned handle; } lyte_Font;
typedef struct lyte_Music { unsigned handle; } lyte_Music;
typedef struct lyte_Sound { unsigned handle; } lyte_Sound;
typedef struct lyte_SoundData { unsigned handle; } lyte_SoundData;
typedef union lyte_ShaderUniformValue {
    float float_val;
    struct { float *values; size_t count; } float_list;
    lyte_Image image_val;
 } lyte_ShaderUniformValue;

#include "api.enums.h" // all the enums (possibly platform/implementation specific)

#endif  // API_GENERATED_H_INCLUDED
