cmake_minimum_required(VERSION 3.5)

project(lua55)

option(LUA_BUILD_SHARED "Build shared library" OFF)
option(LUA_BUILD_STATIC "Build static library" ON)

set(LUA_SRC
src/lapi.c
src/lauxlib.c
src/lbaselib.c
src/lcode.c
src/lcorolib.c
src/lctype.c
src/ldblib.c
src/ldebug.c
src/ldo.c
src/ldump.c
src/lfunc.c
src/lgc.c
src/linit.c
src/liolib.c
src/llex.c
src/lmathlib.c
src/lmem.c
src/loadlib.c
src/lobject.c
src/lopcodes.c
src/loslib.c
src/lparser.c
src/lstate.c
src/lstring.c
src/lstrlib.c
src/ltable.c
src/ltablib.c
src/ltm.c
src/lua.c
src/luac.c
src/lundump.c
src/lutf8lib.c
src/lvm.c
src/lzio.c

)

if (LUA_BUILD_STATIC)
	add_library(lua55-static STATIC ${LUA_SRC})
	target_include_directories(lua55-static PUBLIC src)
endif()

if (LUA_BUILD_SHARED)
	add_library(lua55 SHARED ${LUA_SRC})
	target_include_directories(lua55 PUBLIC src)
	if(MSVC)
		set_property(TARGET lua55 PROPERTY COMPILE_DEFINITIONS LUA_BUILD_AS_DLL=1)
	endif()
	install(TARGETS lua55 RUNTIME DESTINATION . LIBRARY DESTINATION .)
endif()
