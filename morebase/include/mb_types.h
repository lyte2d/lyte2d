/* (c) mg */

#ifndef MB_TYPES_H_INCLUDED
#define MB_TYPES_H_INCLUDED

#include <stdbool.h>
#include <stdint.h>
#include <stddef.h>

typedef struct M_SizeI {
    int w, h;
} M_SizeI;

typedef struct M_SizeF {
    float w, h;
} M_SizeF;

typedef struct M_PosI {
    int x, y;
} M_PosI;

typedef struct M_PosF {
    float x, y;
} M_PosF;

#endif  /* MB_TYPES_H_INCLUDED */
