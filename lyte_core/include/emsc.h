#ifndef EMSC_H_INCLUDED
#define EMSC_H_INCLUDED

#if defined(__EMSCRIPTEN__)

/* common emscripten platform helper functions */

#include <stdbool.h>
#include <stdint.h>

#include <emscripten/emscripten.h>
#include <emscripten/html5.h>

enum {
    EMSC_NONE = 0,
    EMSC_TRY_WEBGL2 = (1<<0),
    EMSC_ANTIALIAS = (1<<1)
};


/* initialize WebGL context and canvas */
void emsc_init(const char* canvas_name, int flags);

int emsc_width();

int emsc_height();

bool emsc_webgl_fallback();

#endif // __EMSCRIPTEN__

#endif  // EMSC_H_INCLUDED
