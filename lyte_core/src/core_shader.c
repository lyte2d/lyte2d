//

#include <stdio.h>
#include <assert.h>
#include <stdlib.h>
#include <string.h>

#include "_internal.h"

#include "sokol_gfx.h"
#include "sokol_gp.h"


#ifndef INIT_NUM_SHADERBUILDERITEMS
#define INIT_NUM_SHADERBUILDERITEMS 10
#endif

#ifndef INIT_NUM_SHADERITEMS
#define INIT_NUM_SHADERITEMS 10
#endif

typedef struct ShaderUniformDefinition {
    const char *name;
    lyte_UniformType type;
    int float_count;
    int location;
} ShaderUniformDefinition;

typedef struct ShaderBuilderItem {
    ShaderUniformDefinition *uniform_definitions;
    size_t num_uniform_definitions;

    const char *vert_code;
    const char *frag_code;

} ShaderBuilderItem;

typedef struct ShaderItem {

    // definitions, including location of the uniforms
    ShaderUniformDefinition *uniform_definitions;
    size_t num_uniform_definitions;

    // actual float numbers
    float *uniform_floats;
    size_t num_uniform_floats;

    // actual images
    lyte_Image *images;
    size_t num_images;

    uint32_t pip_id;
    uint32_t shd_id;
} ShaderItem;



int lyte_core_shader_init(void) {
    return 0;
}

int lyte_core_shader_cleanup(void) {
    return 0;
}

// ShaderBuilder

int lyte_new_shaderbuilder(lyte_ShaderBuilder *val) {
    ShaderBuilderItem *sbi = malloc(sizeof(ShaderBuilderItem));
    sbi->uniform_definitions = NULL;
    sbi->num_uniform_definitions = 0;
    sbi->vert_code = NULL;
    sbi->frag_code = NULL;

    // val = (lyte_ShaderBuilder *)&sbi;
    *val = sbi;
    return 0;
}

int lyte_ShaderBuilder_cleanup(lyte_ShaderBuilder shaderbuilder) {
    ShaderBuilderItem *sbi = shaderbuilder;
    if (sbi) {
        free(sbi);
    }

    return 0;
}

static inline int get_uniform_count(lyte_UniformType t) {
    int ret = 0;
    switch (t) {
            case LYTE_UNIFORMTYPE_FLOAT:
            case LYTE_UNIFORMTYPE_INT:
            { ret = 1; } break;
            case LYTE_UNIFORMTYPE_VEC2:
            case LYTE_UNIFORMTYPE_IVEC2:
            { ret = 2; } break;
            case LYTE_UNIFORMTYPE_VEC3:
            case LYTE_UNIFORMTYPE_IVEC3:
            { ret = 3; } break;
            case LYTE_UNIFORMTYPE_VEC4:
            case LYTE_UNIFORMTYPE_IVEC4:
            { ret = 4; } break;
            case LYTE_UNIFORMTYPE_MAT4:
            { ret = 16; } break;
            case LYTE_UNIFORMTYPE_SAMPLER2D:
            { ret = 0; } break;
    }
    return ret;
}


int lyte_shaderbuilder_uniform(lyte_ShaderBuilder shaderbuilder, const char * uniform_name, lyte_UniformType uniform_type) {
    ShaderBuilderItem *sbi = shaderbuilder;
    if (!sbi) {
        fprintf(stderr, "ShaderBuilder not found.");
        return 1;
    }
    int idx = sbi->num_uniform_definitions;
    int cnt = get_uniform_count(uniform_type);
    sbi->num_uniform_definitions++;
    sbi->uniform_definitions = (void *)realloc(sbi->uniform_definitions, sbi->num_uniform_definitions * sizeof(ShaderBuilderItem));
    sbi->uniform_definitions[idx].name = uniform_name;
    sbi->uniform_definitions[idx].type = uniform_type;
    sbi->uniform_definitions[idx].float_count = cnt;
    sbi->uniform_definitions[idx].location = 0;

    return 0;
}

int lyte_shaderbuilder_vertex(lyte_ShaderBuilder shaderbuilder, const char * vertex_code) {
    ShaderBuilderItem *sbi = shaderbuilder;
    if (!sbi) {
        fprintf(stderr, "ShaderBuilder not found.");
        return 1;
    }
    sbi->vert_code = vertex_code;

    return 0;
}

int lyte_shaderbuilder_fragment(lyte_ShaderBuilder shaderbuilder, const char * fragment_code) {
    ShaderBuilderItem *sbi = shaderbuilder;
    if (!sbi) {
        fprintf(stderr, "ShaderBuilder not found.");
        return 1;
    }
    sbi->frag_code = fragment_code;

    return 0;
}


// Shader

#if !defined(__EMSCRIPTEN__)
static const char *shader_header = "\n\n#version 330\n// ---\n\n";
// static const char *shader_header = "#version 330 core\n// ---\n";
#else
static const char *shader_header = "#version 300 es\nprecision highp float;\n// ---\n";
// static const char *shader_header = "#version 300 es\nprecision mediump float;\n// ---\n";
// static const char *shader_header = "\n\n#version 300 es\n// ---\n\n";
#endif


static const char *vert_footer = "\n// ---\nvoid main() { vert_main(); }\n";
static const char *frag_footer = "\n// ---\nvoid main() { frag_main(); }\n";
static const char *frag_header_1 = "uniform sampler2D current_image;\n";
static const char *frag_header_2 = "uniform vec4 current_color;\n";
static const char *frag_sep = "// ---\n\n";


static inline char *get_full_uniforms_code(ShaderBuilderItem *sbi) {
    size_t num_uniforms = sbi->num_uniform_definitions;
    char *ret = malloc(256*(num_uniforms+1)); // TODO: free at lyte_shaderbuilder_build
    sprintf(ret, "// uniform declarations...\n");
    for (int i=0; i<num_uniforms;i++) {
        const char *type = NULL;
        lyte_UniformType utype = sbi->uniform_definitions[i].type;
        switch (utype) {
            case LYTE_UNIFORMTYPE_FLOAT: {type = "float";} break;
            case LYTE_UNIFORMTYPE_VEC2: {type = "vec2";} break;
            case LYTE_UNIFORMTYPE_VEC3: {type = "vec3";} break;
            case LYTE_UNIFORMTYPE_VEC4: {type = "vec4";} break;
            case LYTE_UNIFORMTYPE_INT: {type = "int";} break;
            case LYTE_UNIFORMTYPE_IVEC2: {type = "ivec3";} break;
            case LYTE_UNIFORMTYPE_IVEC3: {type = "ivec3";} break;
            case LYTE_UNIFORMTYPE_IVEC4: {type = "ivec4";} break;
            case LYTE_UNIFORMTYPE_MAT4: {type = "mat4";} break;
            case LYTE_UNIFORMTYPE_SAMPLER2D: {type = "sampler2D";} break;
            default: {
                printf("Unknown uniform type: %d", utype);
                exit(1);
            } break;
        }
        const char *name = sbi->uniform_definitions[i].name;
        sprintf(ret+strlen(ret), "uniform %s %s;\n", type, name);
    }
    return ret;
}

static inline char *get_full_vertex_code(ShaderBuilderItem *sbi, const char *uniforms_text) {
    char *str = (char *)sbi->vert_code;
    size_t orig_len = strlen(str);
    size_t new_len = orig_len + 1000;
    char *ret = malloc(new_len); // TODO: free at lyte_shaderbuilder_build
    memset(ret, 0, new_len);
    sprintf(ret, "%s%s%s%s%s%s", shader_header, uniforms_text, frag_sep, str, frag_sep, vert_footer);
    return ret;
}

static inline char *get_full_fragment_code(ShaderBuilderItem *sbi, const char *uniforms_text) {
    char *str = (char *)sbi->frag_code;
    size_t orig_len = strlen(str);
    size_t new_len = orig_len + 1000;
    char *ret =malloc(new_len); // TODO: free at lyte_shaderbuilder_build
    memset(ret, 0, new_len);
    sprintf(ret, "%s%s%s%s%s%s%s%s", shader_header, frag_header_1, frag_header_2, frag_sep, uniforms_text, frag_sep, str, frag_footer);
    return ret;
}


int lyte_shaderbuilder_build(lyte_ShaderBuilder shaderbuilder, lyte_Shader *shader) {
    ShaderBuilderItem *sbi = shaderbuilder;
    if (!sbi) {
        fprintf(stderr, "ShaderBuilder not found.");
        return 1;
    }

    const char *uniforms_code = get_full_uniforms_code(sbi);
    if (!uniforms_code) {
        fprintf(stderr, "Uniforms code was not generated.");
        return 2;
    }
    const char *full_code_vertex = get_full_vertex_code(sbi, uniforms_code);
    if (!full_code_vertex) {
        fprintf(stderr, "Vertex code was not generated.");
        return 3;
    }
    const char *full_code_fragment = get_full_fragment_code(sbi, uniforms_code);
    if (!full_code_vertex) {
        fprintf(stderr, "Fragment code was not generated.");
        return 4;
    }


    ShaderItem *shd = malloc(sizeof(ShaderItem));

    shd->uniform_floats = malloc(SGP_UNIFORM_CONTENT_SLOTS*sizeof(float)); // TODO: free in lyte_cleanup_shader
    memset(shd->uniform_floats, 0, SGP_UNIFORM_CONTENT_SLOTS*sizeof(float));
    shd->images = malloc(SGP_TEXTURE_SLOTS*sizeof(lyte_Image)); // TODO: free in lyte_cleanup_shader
    memset(shd->images, 0, SGP_TEXTURE_SLOTS*sizeof(lyte_Image));

    shd->num_uniform_definitions = sbi->num_uniform_definitions;
    shd->uniform_definitions = malloc(shd->num_uniform_definitions * sizeof(ShaderBuilderItem));
    memcpy(shd->uniform_definitions, sbi->uniform_definitions, shd->num_uniform_definitions * sizeof(ShaderBuilderItem)); // TODO: free in lyte_cleanup_shader

    // sg shader description

    // init
    sg_shader_desc shader_desc = {0};
    shader_desc.label = "lyteshaderprogram";
    shd->num_uniform_floats = 0;
    shd->num_images = 0;
    // shader code
    shader_desc.vertex_func.source = full_code_vertex;
    shader_desc.fragment_func.source = full_code_fragment;
    shader_desc.vertex_func.entry = "main";
    shader_desc.fragment_func.entry = "main";

    // "MAGIC" uniforms: vec4 current_color and sampler2D current_image

    shader_desc.uniform_blocks[0].stage = SG_SHADERSTAGE_VERTEX;
    shader_desc.uniform_blocks[0].layout = SG_UNIFORMLAYOUT_NATIVE;
    shader_desc.uniform_blocks[0].glsl_uniforms[0].glsl_name = "current_color";
    shader_desc.uniform_blocks[0].glsl_uniforms[0].type = (sg_uniform_type)LYTE_UNIFORMTYPE_VEC4;
    shader_desc.uniform_blocks[0].glsl_uniforms[0].array_count = 1;

    shader_desc.uniform_blocks[1].stage = SG_SHADERSTAGE_FRAGMENT;
    shader_desc.uniform_blocks[1].layout = SG_UNIFORMLAYOUT_NATIVE;
    shader_desc.uniform_blocks[1].glsl_uniforms[0].glsl_name = "current_color";
    shader_desc.uniform_blocks[1].glsl_uniforms[0].type = (sg_uniform_type)LYTE_UNIFORMTYPE_VEC4;
    shader_desc.uniform_blocks[1].glsl_uniforms[0].array_count = 1;

    shd->num_uniform_floats += 4; // r,g,b,a for current_color

    shader_desc.samplers[0].stage = SG_SHADERSTAGE_FRAGMENT;
    shader_desc.samplers[0].sampler_type = SG_SAMPLERTYPE_FILTERING;
    shader_desc.views[0] = (sg_shader_view) {
        .texture = {
            .stage = SG_SHADERSTAGE_FRAGMENT,
            .image_type = SG_IMAGETYPE_2D,
            .sample_type = SG_IMAGESAMPLETYPE_FLOAT,
            .multisampled = false
        },
    };
    shader_desc.texture_sampler_pairs[0] = (sg_shader_texture_sampler_pair){
        .stage = SG_SHADERSTAGE_FRAGMENT,
        .view_slot = 0,
        .sampler_slot = 0,
        .glsl_name = "current_image"
    };

    shd->num_images += 1; // current_image

    size_t num_uniforms = sbi->num_uniform_definitions;

    int flt_idx = 1;
    int img_idx = 1;

    for (int i=0; i<num_uniforms; i++) {
        ShaderUniformDefinition *sud = &shd->uniform_definitions[i];
        if (sud->type == LYTE_UNIFORMTYPE_SAMPLER2D) {
            // image
            shader_desc.samplers[img_idx].stage = SG_SHADERSTAGE_FRAGMENT;
            shader_desc.samplers[img_idx].sampler_type = SG_SAMPLERTYPE_FILTERING;
            shader_desc.views[img_idx] = (sg_shader_view) {
                .texture = {
                    .stage = SG_SHADERSTAGE_FRAGMENT,
                    .image_type = SG_IMAGETYPE_2D,
                    .sample_type = SG_IMAGESAMPLETYPE_FLOAT,
                    .multisampled = false
                },
            };
            shader_desc.texture_sampler_pairs[img_idx] = (sg_shader_texture_sampler_pair){
                .stage = SG_SHADERSTAGE_FRAGMENT,
                .view_slot = img_idx,
                .sampler_slot = img_idx,
                .glsl_name = sud->name
            };
            sud->location = img_idx;
            img_idx++;
            shd->num_images += 1;
        } else {
            // vertex block
            shader_desc.uniform_blocks[0].glsl_uniforms[flt_idx].glsl_name = sud->name;
            shader_desc.uniform_blocks[0].glsl_uniforms[flt_idx].type = (sg_uniform_type)sud->type;
            shader_desc.uniform_blocks[0].glsl_uniforms[flt_idx].array_count = 1;

            // fragment block
            shader_desc.uniform_blocks[1].glsl_uniforms[flt_idx].glsl_name = sud->name;
            shader_desc.uniform_blocks[1].glsl_uniforms[flt_idx].type = (sg_uniform_type)sud->type;
            shader_desc.uniform_blocks[1].glsl_uniforms[flt_idx].array_count = 1;
            flt_idx++;
            sud->location = shd->num_uniform_floats;
            shd->num_uniform_floats += sud->float_count;
        }
    }

    shader_desc.uniform_blocks[0].size = shd->num_uniform_floats * 4;
    shader_desc.uniform_blocks[1].size = shd->num_uniform_floats * 4;

    sg_shader sgshd = sg_make_shader(&shader_desc);

    sgp_pipeline_desc pip_desc = {0};
    pip_desc.blend_mode = (sgp_blend_mode)lytecore_state.blendmode;
    pip_desc.shader = sgshd;

    sg_pipeline pip = sgp_make_pipeline(&pip_desc);
    sg_resource_state state = sg_query_pipeline_state(pip);
    if (state != SG_RESOURCESTATE_VALID) {
        fprintf(stderr, "Failed to make custom pipeline: %d\n ", state);
        return 5;
    }

    // associate sgp pipeline with the shaderitem
    shd->pip_id = pip.id;
    shd->shd_id = sgshd.id;

    *shader = shd;

    // these are allocated in get_full_* functions (in this file, static inline)
    free((void *)uniforms_code);
    free((void *)full_code_vertex);
    free((void *)full_code_fragment);
    return 0;
}

int lyte_Shader_cleanup(lyte_Shader shader) {
    ShaderItem *shd = shader;
    if (shd) {
        free(shd->uniform_definitions);
        free(shd->uniform_floats);
        free(shd->images);
        sg_destroy_pipeline((sg_pipeline){ .id = shd->pip_id });
        sg_destroy_shader((sg_shader){.id = shd->shd_id});
        free(shd);
    }
    return 0;
}


int lyte_set_shader(lyte_Shader shader) {
    ShaderItem *shd = shader;
    if (!shd) {
        fprintf(stderr, "Shader not found.");
        return 1;
    }
    sgp_set_pipeline((sg_pipeline){.id=shd->pip_id});
    sgp_set_uniform(
        shd->uniform_floats, shd->num_uniform_floats*4,
        shd->uniform_floats, shd->num_uniform_floats*4
    );
    lyte_set_blendmode(lytecore_state.blendmode);
    lytecore_state.shader = shd;
    return 0;
}

int lyte_reset_shader(void) {
    lytecore_state.shader = NULL;
    sgp_reset_pipeline();
    return 0;
}


int lyte_core_shader_set_color() {
    if (lytecore_state.shader) {
        ShaderItem *shd = lytecore_state.shader;
        memcpy(shd->uniform_floats, lytecore_state.current_color, 16);
        sgp_set_uniform(
            shd->uniform_floats, shd->num_uniform_floats*4,
            shd->uniform_floats, shd->num_uniform_floats*4
        );
    }
}

int lyte_set_shader_uniform(lyte_Shader shader, const char * uniform_name, lyte_ShaderUniformValue uniform_value) {
    ShaderItem *shd = shader;
    if (!shd) {
        fprintf(stderr, "Shader not found.");
        return 1;
    }
    ShaderUniformDefinition *sud = NULL;
    for (int i=0; i<shd->num_uniform_definitions; i++) {
        if (shd->uniform_definitions[i].name == uniform_name) {
            sud = &shd->uniform_definitions[i];
            break;
        }
    }
    if (!sud) {
        fprintf(stderr, "Unknown shader uniform: %s\n", uniform_name);
        return 2;
    }
    switch (uniform_value.which) {
        case 0: { // float/int
            shd->uniform_floats[sud->location] = uniform_value.options.float_val;
            memcpy(shd->uniform_floats, lytecore_state.current_color, 16);
            sgp_set_uniform(shd->uniform_floats, shd->num_uniform_floats*4,
                shd->uniform_floats, shd->num_uniform_floats*4);
        }
        break;
        case 1: { // vecX/ivecX. X = 2 or 3 or 4
            if (uniform_value.options.vec_val.count > sud->float_count) {
                fprintf(stderr, "warning: too many uniform values sent\n");
            } else  if (uniform_value.options.vec_val.count > sud->float_count) {
                fprintf(stderr, "warning: not enough uniform values sent\n");
            }
            int count = MIN(MAX(uniform_value.options.vec_val.count, sud->float_count),4);
            for (int i=0; i<count; i++) {
                shd->uniform_floats[sud->location+i] = uniform_value.options.vec_val.data[i];
            }
            memcpy(shd->uniform_floats, lytecore_state.current_color, 16);
            sgp_set_uniform(shd->uniform_floats, shd->num_uniform_floats*4,
                shd->uniform_floats, shd->num_uniform_floats*4);
        }
        break;
        case 2: { // sampler2D
            shd->images[sud->location] = uniform_value.options.sampler2D_val;
            ImageItem *i = (ImageItem *)uniform_value.options.sampler2D_val;
            sgp_set_view(sud->location, i->view);
         }
         break;
        default: {
            fprintf(stderr, "Unknown shader uniform value, shouldn't happen.\n");
            return -1;
        }
        break;
    }
    return 0;
}

int lyte_reset_shader_uniform(lyte_Shader shader, const char * uniform_name) {
    ShaderItem *shd = shader;
    if (!shd) {
        fprintf(stderr, "Shader not found.");
        return 1;
    }
    ShaderUniformDefinition *sud = NULL;
    for (int i=0; i<shd->num_uniform_definitions; i++) {
        if (shd->uniform_definitions[i].name == uniform_name) {
            sud = &shd->uniform_definitions[i];
            break;
        }
    }
    if (!sud) {
        fprintf(stderr, "Unknown shader uniform: %s\n", uniform_name);
        return 2;
    }

    // TODO: Do we need resetting?

    return 0;
}
