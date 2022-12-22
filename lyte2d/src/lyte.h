/* (c) mg */

#ifndef LYTE_H_INCLUDED
#define LYTE_H_INCLUDED

#ifndef LOG
#define LOG(...)
#endif

#include <lua.h>
#include <morebase.h>

#define CHK_STACK(n)                                                                         \
    if (lua_gettop(L) != (n)) {                                                              \
        fprintf(stderr, "Stack top was expected to be %d but is %d.\n", (n), lua_gettop(L)); \
        ASSERT(false);                                                                       \
    }

int get_config(M_Config *cfg, int argc, char *argv[]);
int lyteapi_open(lua_State *L);

#endif /* LYTE_H_INCLUDED */
