#ifndef LYTE_INTERNAL_H
#define LYTE_INTERNAL_H

#include "lyte_core.h"

#define GLFW_INCLUDE_NONE
#include <GLFW/glfw3.h>

#define SGP_UNIFORM_CONTENT_SLOTS 1024
#define SGP_TEXTURE_SLOTS 8


#ifndef MIN
#define MIN(a,b) (((a)<(b))?(a):(b))
#endif

#ifndef MAX
#define MAX(a,b) (((a)>(b))?(a):(b))
#endif

#ifndef M_PI
#define M_PI  3.14159265358979323846264f
#endif

typedef struct lyte_QuadSize {
    int left, right, top, bottom;
} lyte_QuadSize;

typedef struct lyte_CoreState {
    lyte_Args args;

    lyte_BlendMode default_blendmode;
    lyte_FilterMode default_filtermode;

    const char *exe_name;
    const char *window_title;
    lyte_Size window_size;
    lyte_Size window_min_size;
    bool fullscreen;
    bool vsync;
    lyte_BlendMode blendmode;
    lyte_FilterMode filtermode;
    lyte_QuadSize window_margins;
    lyte_QuadSize window_paddings;

    float hidpi_xscale;
    float hidpi_yscale;

    float current_color[4];

    GLFWwindow *window;  // GLFWwindow
    GLFWwindow *monitor; // GLFWmonitor
    GLFWwindow *mode;    // GLFWVidMode

    void *shader; // ShaderItem (internal)

    bool do_quit; // set to true to quit the app
    bool first_frame; // first frame of the tick function

    lyte_TickFunction tick_fn;
    void *app_data;

} lyte_CoreState;


extern lyte_CoreState lytecore_state;

#endif // LYTE_INTERNAL_H