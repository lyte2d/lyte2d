// (c) mg
#include "lyte.h"
#include <stdio.h>
#include <stdio.h>
#include <stdbool.h>
#include <lua.h>
#include <lauxlib.h>
#include <lualib.h>
#include <assert.h>
#include <stdlib.h>
#include <string.h>
#include <locale.h>

#include <isocline.h>


LYTE_LANG repl_lang = LUA;

// completion function defined below
static void _completer(ic_completion_env_t* cenv, const char* prefix );

// highlighter function defined below
static void _highlighter(ic_highlight_env_t* henv, const char* input, void* arg);


void repl_prompt(void) {
    // ic_style_def("grn", "green");
    // ic_printf("[grn]lyte$[/] ");
    printf("lyte$ ");
    fflush(stdout);
}


void repl_setup(LYTE_LANG _lang) {
    repl_lang = _lang;

    setlocale(LC_ALL,"C.UTF-8");  // we use utf-8 in this example

    // use `ic_print` functions to use bbcode's for markup
    ic_style_def("kbd","gray underline");     // you can define your own styles
    ic_style_def("ic-prompt","ansi-maroon");  // or re-define system styles

    ic_printf( "[b]Lyte2D[/b] alpha v0.2 REPL in %s.\n"
                "- Type 'lyte.quit()' to quit. (or use [kbd]ctrl-c[/]).\n"
                "- Press [kbd]F1[/] for help on editing commands.\n"
                "- Use [kbd]shift-tab[/] for multiline input. (or [kbd]ctrl-enter[/], or [kbd]ctrl-j[/])\n"
                "- Use [kbd]ctrl-r[/] to search the history.\n\n"
                "REPL is a work in progress. Proper completions not implemented yet\n\n", repl_lang == FENNEL ? "fennel" : "lua");

    // enable history; use a NULL filename to not persist history to disk
    ic_set_history("history.txt", -1 /* default entries (= 200) */);

    // enable completion with a default completion function
    ic_set_default_completer(&_completer, NULL);

    // enable syntax highlighting with a highlight function
    ic_set_default_highlighter(_highlighter, NULL);

    ic_enable_brace_insertion(false);
    ic_set_prompt_marker(">>> ", "... ");

    // try to auto complete after a completion as long as the completion is unique
    // ic_enable_auto_tab(true);

    // inline hinting is enabled by default
    // ic_enable_hint(false);
}


#if (defined __linux__) || (defined _WIN32)


/*
  char* input;
  while((input = ic_readline("isoclinε")) != NULL)    // ctrl-d returns NULL (as well as errors)
  {
    bool stop = (strcmp(input,"exit") == 0 || strcmp(input,"") == 0);
    ic_printf("[gray]-----[/]\n"           // echo the input
              "%s\n"
              "[gray]-----[/]\n", input );
    free(input);               // do not forget to free the returned input!
    if (stop) break;
  }
*/

/*
        fennel_eval_open = "return fennel.eval([===[";
        fennel_eval_close_1 = "]===], ";
        fennel_eval_close_2 = "{correlate=true, filename='";
        fennel_eval_close_3 = "', allowedGlobals=false})";
*/

//char input[1024] = {0};
char *input = NULL;
char *formatted_inp = NULL;
char nb_val = 0;
bool repl_check(lua_State *L) {
    bool ret = false;
#ifdef __linux__
    //nbchar_enable_raw_mode();
#endif
    nb_val = nbchar();
    if (nb_val) {
        //char *_input = fgets(input, sizeof(input), stdin);
        //(void)_input;
        luaL_Buffer b;
#ifdef __linux__
    //nbchar_enable_raw_mode();
        // input = malloc(4096);
        // input = fgets(input, 4090, stdin);
        input = ic_readline("");
#else
        // input = malloc(4096);
        // input = fgets(input, 4090, stdin);
        input = ic_readline("");
#endif
        // input = ic_readline_ex("", NULL, NULL, NULL, NULL);
        luaL_buffinit(L, &b);
        if (repl_lang == FENNEL) {
            // luaL_addstring(&b, "return unpack({fennel.eval([===[");
            luaL_addstring(&b, "return tool_eval_fennel([===[");
            luaL_addstring(&b, input);
            // luaL_addstring(&b, "]===], {correlate=true, filename='(repl)', allowedGlobals=false})})");
            luaL_addstring(&b, "]===])");
        } else if (repl_lang == LUA) {
            //printf("===DBG===\n%s %c %d\n===DBG===\n", input, input[0], input);
            if (input[0] == '=') {
                luaL_addstring(&b, "return ");
                luaL_addstring(&b, &input[1] );
            } else {
                luaL_addstring(&b, input);
            }
        } else {
            printf("Unexpected error: repl language");
            lua_error(L);
        }
        luaL_pushresult(&b);
        // todo: do we need to convert \n chars to \\n? for "send to" stuff? or is it a tooling responsibility?
        //luaL_addstring(&b, "\r");
        formatted_inp = (char *)luaL_checkstring(L, -1);
        lua_pop(L, 1);
        //int err = luaL_dostring(L,input);
        int err = 0;

        err = luaL_dostring(L, formatted_inp);

        // printf("\n-------\n\n\n%s\n\n\n-----\n", formatted_inp);
        if (err != 0) {
            const char *errstr = luaL_checkstring(L, -1);
            printf("Error: %s\n", errstr);
            lua_pop(L, 1);
        } else {
            int rescount = lua_gettop(L);
            for (int i=1;i<=rescount;i++) {
                if (repl_lang == FENNEL) {
                    lua_getglobal(L, "tostring_fennel");
                } else {
                    lua_getglobal(L, "tostring");
                }
                lua_pushvalue(L, i);
                lua_pcall(L, 1, 1, 0);
                const char *res = luaL_checkstring(L, -1);
                printf("%s\t", res);
            }
            lua_settop(L, 0);
            if (rescount == 0 && repl_lang == FENNEL && strlen(input) > 0) {
                printf("nil\n");
            }
            if (rescount > 0) { printf("\n"); }
        }
        free(input);
        input = NULL;
        repl_prompt();
        ret = true;

    }
#ifdef __linux__
    //nbchar_disable_raw_mode();

#endif
    return ret;
}

#else
bool repl_check(lua_State *L) { (void)L; return false; }
#endif




// -------------------------------------------------------------------------------
// Completion
// -------------------------------------------------------------------------------

// A custom completer function.
// Use `ic_add_completion( env, replacement, display, help)` to add actual completions.
static void word_completer(ic_completion_env_t* cenv, const char* word )
{
  // complete with list of words; only if the input is a word it will be a completion candidate
  // static const char* completions[] = { "exit", "quit", "print", NULL };
  // ic_add_completions(cenv, word, completions);
  static const char* completions2[] = { "lyte", "_G", NULL };

  // examples of more customized completions
  //if  (strcmp(word, "cmd") == 0) {
  if (word[0] == '?') {
    ic_add_completion(cenv, "// testing completions of isocline library");
    ic_add_completion(cenv, "lyte.quit()");
    ic_add_completion(cenv, "function dir(x) for k,v in pairs(x) do print(k) end end");
    ic_add_completion(cenv, " apples 🍎");
  }
  else if (strcmp(word, "id") == 0) {
    // replacement, display, and help
    ic_add_completion_ex(cenv, "function(x) return x end", "Lua: function(x) return x end", "identity lambda in Lua");
    ic_add_completion_ex(cenv, "(fn [x] x)", "Fennel: (fn [x] x)", "identity lambda in Fennel");
  }
  else if (word[0] != 0 && ic_istarts_with("hello lyte ",word)) {
    // many completions for hello isocline
    for(int i = 0; i < 100000; i++) {
      char buf[32];
      snprintf(buf,32,"hello lyte %03d", i+1);
      if (!ic_add_completion(cenv, buf)) break;  // break early if not all completions are needed (for better latency)
    }
  } else {
    ic_add_completions(cenv, word, completions2);
  }
}

// A completer function is called by isocline to complete. The input parameter is the input up to the cursor.
// We use `ic_complete_word` to only consider the final token on the input.
// (almost all user defined completers should use this)
static void _completer(ic_completion_env_t* cenv, const char* input )
{
  // try to complete file names from the roots "." and "/usr/local"
  // ic_complete_filename(cenv, input, 0, ".;/usr/local;c:\\Program Files" , NULL /* any extension */);
  if (strcmp(input,"./") == 0) {
    ic_complete_filename(cenv, input, 0, "." , NULL /* any extension */);
  } else {
    // and also use our custom completer
    ic_complete_word( cenv, input, &word_completer, NULL /* from default word boundary; whitespace or separator */ );
  }
  // ic_complete_word( cenv, input, &word_completer, &ic_char_is_idletter );
  // ic_complete_qword( cenv, input, &word_completer, &ic_char_is_idletter  );
}


// -------------------------------------------------------------------------------
// Syntax highlighting
// -------------------------------------------------------------------------------

// A highlight function is called by isocline when input can be highlighted.
// Use `ic_highlight_color` (or `bgcolor`, `underline`) to highlight characters from
// a given position until another attribute is set.
// Here we use some convenience functions to easily highlight
// simple tokens but a full-fledged highlighter probably needs regular expressions.
static void _highlighter(ic_highlight_env_t* henv, const char* input, void* arg) {
  (void)(arg); // unused
  // for all characters in the input..
  long len = (long)strlen(input);
  for (long i = 0; i < len; ) {
    static const char* keywords[] = { "fn", "local", "global", "set", NULL };
    static const char* controls[] = { "return", "if", "then", "else", NULL };
    static const char* types[]    = { "int", "double", "char", "void", NULL };
    long tlen;  // token length
    if ((tlen = ic_match_any_token(input, i, &ic_char_is_idletter, keywords)) > 0) {
      ic_highlight(henv, i, tlen, "keyword");
      i += tlen;
    }
    else if ((tlen = ic_match_any_token(input, i, &ic_char_is_idletter, controls)) > 0) {
      ic_highlight(henv, i, tlen, "plum");      // html color (or use the `control` style)
      i += tlen;
    }
    else if ((tlen = ic_match_any_token(input, i, &ic_char_is_idletter, types)) > 0) {
      ic_highlight(henv, i, tlen, "type");
      i += tlen;
    }
    else if ((tlen = ic_is_token(input, i, &ic_char_is_digit)) > 0) {  // digits
      ic_highlight(henv, i, tlen, "number");
      i += tlen;
    }
    else if (ic_starts_with(input + i,"--")) {  // line comment
      tlen = 2;
      while (i+tlen < len && input[i+tlen] != '\n') { tlen++; }
      ic_highlight(henv, i, tlen, "comment");   // or use a spefic color like "#408700"
      i += tlen;
    }
    else {
      ic_highlight(henv, i, 1, NULL);  // anything else (including utf8 continuation bytes)
      i++;
    }
  }
}

