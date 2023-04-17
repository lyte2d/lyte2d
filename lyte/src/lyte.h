/* (c) mg */

#ifndef LYTE_H_INCLUDED
#define LYTE_H_INCLUDED

#include <lua.h>
#include <morebase.h>

#define CHK_STACK(n)                                                                         \
    if (lua_gettop(L) != (n)) {                                                              \
        fprintf(stderr, "Stack top was expected to be %d but is %d.\n", (n), lua_gettop(L)); \
        ASSERT(false);                                                                       \
    }

int get_config(M_Config *cfg, int argc, char *argv[]);
int register_lyte(lua_State *L);

// REPL (+nbchar)
int nbchar(void);

// #ifdef __linux__
// void nbchar_enable_raw_mode();
// void nbchar_disable_raw_mode();
// #endif

typedef enum LYTE_LANG {
    LUA,
    FENNEL,
} LYTE_LANG;

void repl_setup(LYTE_LANG lang);
bool repl_check(lua_State *L); // returns: skip hint (after a repl pause 1 loop iteration is skipped to make dt normal sized)
void repl_prompt(void);


#endif /* LYTE_H_INCLUDED */
