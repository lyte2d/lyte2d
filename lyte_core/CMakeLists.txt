cmake_minimum_required(VERSION 3.15)
project(lyte_core C CXX)
message("===============> Project: ${PROJECT_NAME}")

add_library(${PROJECT_NAME} STATIC)

if(APPLE)
  find_package(OpenGL REQUIRED)
endif()

if(CMAKE_BUILD_TYPE MATCHES "Release" OR CMAKE_BUILD_TYPE MATCHES "MinSizeRel")
  message("===> [Release] " ${PROJECT_NAME} " : Release mode: " ${CMAKE_BUILD_TYPE})
else()
  set(DEBUG ON)
  message("===> [Debug] " ${PROJECT_NAME} " : Debug mode: " ${CMAKE_BUILD_TYPE})
endif()

set(BUILD_SHARED_LIBS OFF)

if (CMAKE_SYSTEM_NAME STREQUAL Emscripten)
    message("===> EMSCRIPTEN: " ${PROJECT_NAME})
    message("===> Skipping GLFW3 as emscripten has an internal implemtation for a version of it")
else()
    message("===> PROJECT:" ${PROJECT_NAME} "SYSTEM:" ${CMAKE_SYSTEM_NAME})
    message("===> ${PROJECT_NAME} system: " ${CMAKE_SYSTEM_NAME})

    message("===> Adding GLFW3")
    set(GLFW_BUILD_EXAMPLES OFF)
    set(GLFW_BUILD_TESTS OFF)
    set(GLFW_BUILD_DOCS OFF)
    set(GLFW_INSTALL ON)
    set(USE_MSVC_RUNTIME_LIBRARY_DLL OFF)
    add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/../deps/glfw-3.4 ${CMAKE_CURRENT_BINARY_DIR}/glfw)

    target_link_libraries(${PROJECT_NAME} PRIVATE
        glfw
    )

    if(APPLE)
      target_link_libraries(${PROJECT_NAME} PUBLIC
         OpenGL::GL
      )
    endif()
endif()


message("===> Adding PHYSFS")
set(PHYSFS_BUILD_SHARED OFF)
set(PHYSFS_BUILD_TEST OFF)
set(PHYSFS_BUILD_DOCS OFF)
set(PHYSFS_ARCHIVE_GRP OFF)
set(PHYSFS_ARCHIVE_WAD OFF)
set(PHYSFS_ARCHIVE_HOG OFF)
set(PHYSFS_ARCHIVE_MVL OFF)
set(PHYSFS_ARCHIVE_QPAK OFF)
set(PHYSFS_ARCHIVE_QPAK OFF)
set(PHYSFS_ARCHIVE_SLB OFF)
set(PHYSFS_ARCHIVE_ISO9660 OFF)
set(PHYSFS_ARCHIVE_VDF OFF)
set(PHYSFS_ARCHIVE_ZIP ON)
set(PHYSFS_ARCHIVE_7Z ON)
add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/../deps/physfs ${CMAKE_CURRENT_BINARY_DIR}/physfs)
target_link_libraries(${PROJECT_NAME} PRIVATE
    physfs-static
)

message("===> Adding FreeType")
add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/../deps/freetype ${CMAKE_CURRENT_BINARY_DIR}/freetype)
target_link_libraries(${PROJECT_NAME} PRIVATE
  freetype
)

message("===> Adding ODE")
set(ODE_WITH_DEMOS OFF)
set(ODE_WITH_TESTS OFF)
set(ODE_NO_BUILTIN_THREADING_IMPL ON)
add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/../deps/ode-0.16.4 ${CMAKE_CURRENT_BINARY_DIR}/ode)
target_link_libraries(${PROJECT_NAME} PRIVATE
    ODE
)

target_include_directories(${PROJECT_NAME}
  PUBLIC
    ./include
    # ${CMAKE_CURRENT_SOURCE_DIR}/../deps/glfw-3.3.8/deps/
  PRIVATE
    ./src
    ${GLFW_SOURCE_DIR}/include
    ${GLFW_SOURCE_DIR}/dependencies
    ${CMAKE_CURRENT_SOURCE_DIR}/../deps/sokol
    ${CMAKE_CURRENT_SOURCE_DIR}/../deps/sokol_gp
    ${CMAKE_CURRENT_SOURCE_DIR}/../deps/stb_image
    ${CMAKE_CURRENT_SOURCE_DIR}/../deps/fontstash
    ${CMAKE_CURRENT_SOURCE_DIR}/../deps/raudio/src
)

target_sources(${PROJECT_NAME}
# PUBLIC
    # ${CMAKE_CURRENT_SOURCE_DIR}/../deps/glfw-3.3.8/deps/glad_gl.c

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
    ${CMAKE_CURRENT_SOURCE_DIR}/../deps/stb_image/stb_image.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../deps/raudio/src/raudio.c
)


