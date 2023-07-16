//

#ifndef REPL_H_INCLUDED
#define REPL_H_INCLUDED

#include <lua.h>
#include <stdbool.h>

int nbchar(void);
void repl_setup(void);
bool repl_check(lua_State *L); // returns: skip hint (after a repl pause 1 loop iteration is skipped to make dt normal sized)
void repl_prompt(void);

#endif  // REPL_H_INCLUDED
