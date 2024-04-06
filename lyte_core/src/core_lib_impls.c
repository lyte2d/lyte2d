//
// "implementation" includes for the header libraries

#define XLOG
#define SOKOL_LOG(s) XLOG(s)

#define SGP_UNIFORM_CONTENT_SLOTS 1024
#define SGP_TEXTURE_SLOTS 8
// #define SGP_BATCH_OPTIMIZER_DEPTH 0
// #define SOKOL_VALIDATE_NON_FATAL

#define SOKOL_IMPL

#include "sokol_glue.h"
#include "sokol_fetch.h"
#include "sokol_args.h"

#if defined(__EMSCRIPTEN__)
#define SOKOL_GLES3
#define GLFW_INCLUDE_ES3
#else
#define SOKOL_GLCORE33
#endif

#include "sokol_gfx.h"

#if defined(__APPLE__)
#include <opengl/gl.h>
#define GLFW_INCLUDE_GLCOREARB
#else
#define GLFW_INCLUDE_NONE
#endif


#include "GLFW/glfw3.h"

#include "sokol_gp.h"

#define FONTSTASH_IMPLEMENTATION
#define FONS_USE_FREETYPE

#if defined(_MSC_VER )
#pragma warning(disable:4996)   // strncpy use in fontstash.h
#endif
#if defined(__GNUC__) || defined(__clang__)
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wunused-function"
#pragma GCC diagnostic ignored "-Wsign-conversion"
#endif
#include "fontstash.h"
#if defined(__GNUC__) || defined(__clang__)
#pragma GCC diagnostic pop
#endif
