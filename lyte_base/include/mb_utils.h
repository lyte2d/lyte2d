/* (c) mg */

#ifndef MB_UTILS_H_INCLUDED
#define MB_UTILS_H_INCLUDED

// common macros

#define ASSERT_(x, y)                                                                     \
    if (!(x)) {                                                                           \
        fprintf(stderr, "!!! ERROR: '%s' -- file: %s line: %d\n", y, __FILE__, __LINE__); \
        assert(x);                                                                        \
    }

#define ASSERT(x) ASSERT_(x, "")

#endif /* MB_UTILS_H_INCLUDED */
