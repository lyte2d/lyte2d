//

#include <stdio.h>
#include <assert.h>
#include <stdlib.h>
#include <string.h>

#include "lyte_core.h"
#include "map.h"

#include "sokol_gfx.h"
#include "sokol_gp.h"


//*********************************************
// *************** TEMPORARY ***************
#include "morebase.h"
// *************** TEMPORARY ***************
//*********************************************

// ShaderBuilder

int lyte_new_shaderbuilder(lyte_ShaderBuilder *val) {
    M_ShaderDef *shaderdef =  M_shaderdef_create();
    val->handle = shaderdef->_shader_id;
    return 0;
}

int lyte_cleanup_shaderbuilder(lyte_ShaderBuilder shaderbuilder) {

    return 0;
}

int lyte_shaderbuilder_uniform(lyte_ShaderBuilder shaderbuilder, const char * uniform_name, lyte_UniformType uniform_type) {
    M_ShaderDef *sd = M_shaderdef_find(shaderbuilder.handle);
    if (!sd) {
        printf("shaderdef not found\n");
        return 1;
    }
    M_shaderdef_uniform(sd, uniform_name, (M_UniformType)uniform_type);
    return 0;
}

int lyte_shaderbuilder_vertex(lyte_ShaderBuilder shaderbuilder, const char * vertex_code) {
    M_ShaderDef *sd = M_shaderdef_find(shaderbuilder.handle);
    if (!sd) {
        printf("shaderdef not found\n");
        return 1;
    }
    M_shaderdef_vertex(sd, vertex_code);
    return 0;
}

int lyte_shaderbuilder_fragment(lyte_ShaderBuilder shaderbuilder, const char * fragment_code) {
    M_ShaderDef *sd = M_shaderdef_find(shaderbuilder.handle);
    if (!sd) {
        printf("shaderdef not found\n");
        return 1;
    }
    M_shaderdef_fragment(sd, fragment_code);
    return 0;
}


// Shader

 int lyte_shaderbuilder_build(lyte_ShaderBuilder shaderbuilder, lyte_Shader *shader) {
    M_ShaderDef *sd = M_shaderdef_find(shaderbuilder.handle);
    if (!sd) {
        printf("shaderdef not found\n");
        return 1;
    }
    M_Shader s = M_newshader(sd);
    shader->handle = s.id;
    return 0;
}

 int lyte_cleanup_shader(lyte_Shader shader) {

    return 0;
}


 int lyte_set_shader(lyte_Shader shader) {
    M_Shader s;
    s.id = shader.handle;
    M_shader_set(s);
    return 0;
}

 int lyte_reset_shader(void) {
    M_shader_unset();
    return 0;
}

 int lyte_send_shader_uniform(lyte_Shader shader, const char * uniform_name, lyte_ShaderUniformValue uniform_value, int which_uniform_value) {
    M_Shader s;
    s.id = shader.handle;
    M_ShaderUniform uf = {0};
    uf.name = uniform_name;

    // printf("WHICH: %d\n", which_uniform_value);

    switch (which_uniform_value) {
        case 0: {
            uf.count = 1;
            uf.data = &uniform_value.float_val;
            printf("%f\n", uniform_value.float_val);
        }
        break;
        case 1: {
            uf.count = uniform_value.float_list.count;
            uf.data = uniform_value.float_list.values;
        }
        break;
        case 2: {
            uf.count = 0;
            uf.data = &(uniform_value.image_val);
         }
         break;
        default: {
            printf("UNKNOWN SHADER UNIFORM VALUE\n");
        }
        break;
    }

    M_shader_send(s, uf);
    return 0;
}
