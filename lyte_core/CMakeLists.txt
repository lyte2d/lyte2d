cmake_minimum_required(VERSION 3.15)
project(lyte_core C CXX)
message("===============> Project: ${PROJECT_NAME}")
include(../etc/basics.cmake)

add_library(${PROJECT_NAME} STATIC)

include(../deps/deps.cmake)

if(CMAKE_BUILD_TYPE MATCHES "Release" OR CMAKE_BUILD_TYPE MATCHES "MinSizeRel")
  message("===> [Release] " ${PROJECT_NAME} " : Release mode: " ${CMAKE_BUILD_TYPE})
else()
  set(DEBUG ON)
  message("===> [Debug] " ${PROJECT_NAME} " : Debug mode: " ${CMAKE_BUILD_TYPE})
endif()

target_include_directories(${PROJECT_NAME}
  PUBLIC
    ./include
  PRIVATE
    ./src
)

target_sources(${PROJECT_NAME}

PRIVATE
    ./src/map.c
    ./src/utf8encode.c
    ./src/core_lib_impls.c
    ./src/core_audio.c
    ./src/core_filesystem.c
    ./src/core_font.c
    ./src/core_input.c
    ./src/core_image.c
    ./src/core_loop.c
    ./src/core_physics.c
    ./src/core_shader.c
    ./src/core_shapes.c
    ./src/core_state.c
    ./src/core_window.c
    ./src/lyte_emsc.c
)
