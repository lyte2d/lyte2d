message("====================================================================")

if(WIN32)
    message("==> WIN32")
endif()

if(APPLE)
    message("==> APPLE")
endif()

if(LINUX)
    message("==> LINUX")
endif()

if(UNIX)
    message("==> UNIX")
endif()

if(IOS)
    message("==> IOS")
endif()

if(ANDROID)
    message("==> ANDROID")
endif()

if(BSD)
    message("==> ANDROID")
endif()

if(CYGWIN)
    message("==> CYGWIN")
endif()

if(MINGW)
    message("==> MINGW")
endif()

if(MSYS)
    message("==> MSYS")
endif()

if(EMSCRIPTEN)
    message("==> EMSCRIPTEN")
endif()

# one of https://cmake.org/cmake/help/latest/variable/CMAKE_LANG_COMPILER_ID.html
message("----> ${CMAKE_C_COMPILER_ID}")
# one of https://cmake.org/cmake/help/latest/variable/CMAKE_SYSTEM_NAME.html#variable:CMAKE_SYSTEM_NAME
message("----> ${CMAKE_HOST_SYSTEM_NAME}")


message("====================================================================")

# one of these should be set per target
set(compile_options_msvc    "/W4")

set(compile_options_nonmsvc "-Wall" "-Wextra")

if (MSVC)
    set(compile_options ${compile_options_msvc})
else()
    set(compile_options ${compile_options_nonmsvc})
endif()
