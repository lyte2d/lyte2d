//
// "implementation" includes for the header libraries

#define STB_IMAGE_IMPLEMENTATION
#if defined(__clang__)
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-function"
#endif
#include "stb_image.h"
#if defined(__clang__)
#pragma clang diagnostic pop
#endif


#define XLOG
#define SOKOL_LOG(s) XLOG(s)

#define SGP_UNIFORM_CONTENT_SLOTS 1024
#define SGP_TEXTURE_SLOTS 8
// #define SGP_BATCH_OPTIMIZER_DEPTH 0
// #define SOKOL_VALIDATE_NON_FATAL

#define SOKOL_IMPL

// #include "sokol_glue.h"
#include "sokol_fetch.h"
#include "sokol_args.h"

#define SOKOL_GLCORE

#include "sokol_gfx.h"

#if defined(__APPLE__)
#include <opengl/gl.h>
#define GLFW_INCLUDE_GLCOREARB
// #elif defined(_WIN32)
//  #include <glad/gl.h>
// #define GL_VIEWPORT 0x0BA2
// void glReadPixels(GLint   x, GLint   y, GLsizei   width, GLsizei   height, GLenum   format, GLenum   type, void * pixels);
#else
#define GLFW_INCLUDE_NONE
#endif


#include "sokol_gfx_ext.h"
#include "sokol_gp.h"
#include "sokol_app.h"
#include "sokol_time.h"

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
