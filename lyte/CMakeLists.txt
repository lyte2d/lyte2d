cmake_minimum_required(VERSION 3.15)
cmake_policy(SET CMP0091 NEW)
set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>")
if( WIN_GUI )
    # project(lyte_gui C)
    project(lyte_gui  LANGUAGES C )
else()
    # project(lyte C)
    project(lyte  LANGUAGES C )
endif()



message("===============> Project: ${PROJECT_NAME}")

set(CMAKE_EXPORT_COMPILE_COMMANDS on)


set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED true)
# set(CMAKE_CXX_STANDARD 11)
# set(CMAKE_CXX_STANDARD_REQUIRED True)

add_executable(${PROJECT_NAME})

if(CMAKE_BUILD_TYPE MATCHES "Release" OR CMAKE_BUILD_TYPE MATCHES "MinSizeRel")
  message("===> [Release] " ${PROJECT_NAME} " : Release mode: " ${CMAKE_BUILD_TYPE})
else()
  set(DEBUG ON)
  message("===> [Debug] " ${PROJECT_NAME} " : Debug mode: " ${CMAKE_BUILD_TYPE})
endif()


if (CMAKE_SYSTEM_NAME STREQUAL Emscripten)
    message("===> *** EMSCRIPTEN PROJECT: " ${PROJECT_NAME})
    set(CMAKE_EXECUTABLE_SUFFIX ".html")

    # target_link_options(${PROJECT_NAME} PRIVATE --shell-file ${CMAKE_CURRENT_SOURCE_DIR}/web/lyte.html  -sTOTAL_STACK=64MB -sINITIAL_MEMORY=256MB -sALLOW_MEMORY_GROWTH=1 -sUSE_GLFW=3 -sUSE_WEBGL2=1 -sFULL_ES3=1 -sLEGACY_RUNTIME=1 -sEXPORTED_FUNCTIONS=['_malloc'])
    target_link_options(${PROJECT_NAME} PRIVATE --shell-file ${CMAKE_CURRENT_SOURCE_DIR}/../lyte_wasm/html/lyte.html  )
    # target_link_options(${PROJECT_NAME} PRIVATE --preload-file ${CMAKE_CURRENT_SOURCE_DIR}/images)
    # WASM+JS size optimizations
    # target_link_options(${PROJECT_NAME} PRIVATE -sNO_FILESYSTEM=1 -sASSERTIONS=0 -sMALLOC=emmalloc --closure=1)
    # target_link_options(${PROJECT_NAME} PRIVATE -sASSERTIONS=0 -sMALLOC=emmalloc --closure=1)
    target_compile_definitions(${PROJECT_NAME} PUBLIC -DEMSCRIPTEN=1)
    # set_target_properties(${PROJECT_NAME} PROPERTIES LINK_FLAGS "-s USE_GLFW=3 -s USE_WEBGL2=1 -s FULL_ES3=1  --preload-file ${PROJECT_SOURCE_DIR}/images")
    # set_target_properties(${PROJECT_NAME} PROPERTIES LINK_FLAGS "-s TOTAL_STACK=64MB -s INITIAL_MEMORY=256MB -s ALLOW_MEMORY_GROWTH=1 -s USE_GLFW=3 -s USE_WEBGL2=1 -s FULL_ES3=1  ")
    set_target_properties(${PROJECT_NAME} PROPERTIES LINK_FLAGS "-s TOTAL_STACK=64MB -s INITIAL_MEMORY=256MB -s ALLOW_MEMORY_GROWTH=1 -s USE_GLFW=3 -s USE_WEBGL2=1 -s FULL_ES3=1 -s LEGACY_RUNTIME=1  ")
    # set_target_properties(${PROJECT_NAME} PROPERTIES LINK_FLAGS "-s TOTAL_STACK=64MB -s INITIAL_MEMORY=256MB -s ALLOW_MEMORY_GROWTH=1 -s USE_GLFW=3 -s USE_WEBGL2=1 -s FULL_ES3=1 -s LEGACY_RUNTIME=1 -s EXPORTED_FUNCTIONS=['_main','_malloc','_int_sqrt'] -s EXTRA_EXPORTED_RUNTIME_METHODS=['ccall','cwrap']")
    set_target_properties(${PROJECT_NAME} PROPERTIES LINK_FLAGS "-s TOTAL_STACK=64MB -s INITIAL_MEMORY=256MB -s ALLOW_MEMORY_GROWTH=1 -s USE_GLFW=3 -s USE_WEBGL2=1 -s FULL_ES3=1 -s LEGACY_RUNTIME=1 -s EXPORTED_FUNCTIONS=['_main','_malloc'] -s EXPORTED_RUNTIME_METHODS=['ccall','cwrap']")
    # set_target_properties(${PROJECT_NAME} PROPERTIES LINK_FLAGS "-s TOTAL_STACK=64MB -s INITIAL_MEMORY=256MB -s ALLOW_MEMORY_GROWTH=1 -s USE_GLFW=3 -s USE_WEBGL2=1 -s FULL_ES3=1 -s LEGACY_RUNTIME=1 -s EXPORTED_FUNCTIONS=\"['_malloc']\" ")
elseif(CMAKE_SYSTEM_NAME STREQUAL "Linux")

elseif(MSVC)

else()
    message("===> *** WINDOWS PROJECT:" ${PROJECT_NAME} "SYSTEM:" ${CMAKE_SYSTEM_NAME})
    message("setting some flags")
    # set(CMAKE_C_STANDARD_LIBRARIES "-static-libgcc -static-libstdc++ -lwsock32 -lws2_32 ${CMAKE_CXX_STANDARD_LIBRARIES}")
    # set(CMAKE_CXX_STANDARD_LIBRARIES "-static-libgcc -static-libstdc++ -lwsock32 -lws2_32 ${CMAKE_CXX_STANDARD_LIBRARIES}")
    #set(CMAKE_CXX_STANDARD_LIBRARIES "-static-libgcc -lwsock32 -lws2_32 ${CMAKE_CXX_STANDARD_LIBRARIES}")
    # set(CMAKE_CXX_STANDARD_LIBRARIES "${CMAKE_CXX_STANDARD_LIBRARIES} -static-libgcc") #-lws2_32 -lwsock32")

    # set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -Wl,-Bstatic,--whole-archive -lwinpthread -Wl,--no-whole-archive")
    set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -Wl,-Bstatic")
endif()

if(MSVC)
    set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>")
#    if( WIN_GUI )
#        message("==> Building windows GUI app")
#        target_link_options(${PROJECT_NAME} PRIVATE "/SUBSYSTEM:WINDOWS" "/ENTRY:mainCRTStartup")
#    else()
#        message("==> Building windows console app")
#    endif()
else ()
target_compile_options(${PROJECT_NAME} PUBLIC  -O3 -Wall -Wextra -Wpedantic -Werror -Werror=vla)
    # target_compile_options(${PROJECT_NAME} PUBLIC -std=c++11 -O3 -Wall -Wextra -Wpedantic -Werror -Werror=vla)
    # target_compile_options(${PROJECT_NAME} PUBLIC -static-libstdc++  -O3 -Wall -Wextra -Wpedantic -Werror -Werror=vla)
endif()

if( WIN_GUI )
    message("==> Building windows GUI app")
    if (MSVC)
        target_link_options(${PROJECT_NAME} PRIVATE "/SUBSYSTEM:WINDOWS" "/ENTRY:mainCRTStartup")
    else()
         target_link_options(${PROJECT_NAME} PRIVATE "-mwindows")

    endif()
endif()


add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/../lyte_core ${CMAKE_CURRENT_BINARY_DIR}/lyte_core)
# add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/../lyte_physics ${CMAKE_CURRENT_BINARY_DIR}/lyte_physics)
add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/../dependencies/lua-5.1.5 ${CMAKE_CURRENT_BINARY_DIR}/lua51)
add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/../dependencies/isocline ${CMAKE_CURRENT_BINARY_DIR}/isocline)

target_link_libraries(${PROJECT_NAME} PRIVATE
    lyte_core
    #    lyte_physics
    lua51-static
    isocline
)
if(CMAKE_SYSTEM_NAME STREQUAL "Linux")
    set(CMAKE_THREAD_LIBS_INIT "-lpthread")
    set(CMAKE_HAVE_THREADS_LIBRARY 1)
    set(CMAKE_USE_WIN32_THREADS_INIT 0)
    set(CMAKE_USE_PTHREADS_INIT 1)
    set(THREADS_PREFER_PTHREAD_FLAG ON)

    target_link_libraries(${PROJECT_NAME} PRIVATE
        GL
        GLU
    )
endif()

target_include_directories(${PROJECT_NAME} PRIVATE
    ./src
    ${CMAKE_CURRENT_SOURCE_DIR}/../lyte_api/include
    ${CMAKE_CURRENT_SOURCE_DIR}/../lyte_boot/include
    ${CMAKE_CURRENT_SOURCE_DIR}/../lyte_common/include
    ${CMAKE_CURRENT_SOURCE_DIR}/../lyte_repl/include
)

target_sources(${PROJECT_NAME} PRIVATE
    ./src/main.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../lyte_api/src/api_generated.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../lyte_repl/src/nbchar.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../lyte_repl/src/repl.c
)

