#include <check.h>
#include <stdlib.h>
#include <string.h>

// Include the full translation unit to access static inline helpers
#include "lyte_core/src/core_shader.c"

// Stub the extern that core_shader.c references in functions we don't call here
lyte_CoreState lytecore_state = {0};

START_TEST(test_get_full_uniforms_code_normal_name)
{
    ShaderUniformDefinition defs[1];
    defs[0].name = "my_uniform";
    defs[0].type = LYTE_UNIFORMTYPE_FLOAT;
    defs[0].float_count = 1;
    defs[0].location = 0;

    ShaderBuilderItem sbi = {0};
    sbi.uniform_definitions = defs;
    sbi.num_uniform_definitions = 1;

    char *result = get_full_uniforms_code(&sbi);
    ck_assert_ptr_nonnull(result);
    ck_assert_msg(strstr(result, "uniform float my_uniform;") != NULL,
        "Expected 'uniform float my_uniform;' in output");
    free(result);
}
END_TEST

// A 299-char name previously overflowed the old 256*(n+1) budget
START_TEST(test_get_full_uniforms_code_long_name)
{
    char long_name[300];
    memset(long_name, 'A', 299);
    long_name[299] = '\0';

    ShaderUniformDefinition defs[1];
    defs[0].name = long_name;
    defs[0].type = LYTE_UNIFORMTYPE_FLOAT;
    defs[0].float_count = 1;
    defs[0].location = 0;

    ShaderBuilderItem sbi = {0};
    sbi.uniform_definitions = defs;
    sbi.num_uniform_definitions = 1;

    char *result = get_full_uniforms_code(&sbi);
    ck_assert_ptr_nonnull(result);
    ck_assert_msg(strstr(result, long_name) != NULL,
        "Long uniform name missing from output — possible buffer overflow or truncation");
    free(result);
}
END_TEST

static Suite *shader_suite(void) {
    Suite *s = suite_create("core_shader");
    TCase *tc = tcase_create("get_full_uniforms_code");
    tcase_add_test(tc, test_get_full_uniforms_code_normal_name);
    tcase_add_test(tc, test_get_full_uniforms_code_long_name);
    suite_add_tcase(s, tc);
    return s;
}

int main(void) {
    Suite *s = shader_suite();
    SRunner *sr = srunner_create(s);
    srunner_run_all(sr, CK_NORMAL);
    int failed = srunner_ntests_failed(sr);
    srunner_free(sr);
    return (failed == 0) ? EXIT_SUCCESS : EXIT_FAILURE;
}
