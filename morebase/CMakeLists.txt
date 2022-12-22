cmake_minimum_required(VERSION 3.20)
project(morebase C)
message("===============> Project: ${PROJECT_NAME}")

add_library(${PROJECT_NAME} STATIC)

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
    add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/../external/glfw-3.3.8 ${CMAKE_CURRENT_BINARY_DIR}/glfw)

    target_link_libraries(${PROJECT_NAME} PRIVATE
        glfw
    )
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
add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/../external/physfs ${CMAKE_CURRENT_BINARY_DIR}/physfs)
target_link_libraries(${PROJECT_NAME} PRIVATE
    physfs-static
)


message("===> Adding FreeType")
# set()
add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/../external/freetype ${CMAKE_CURRENT_BINARY_DIR}/freetype)
target_link_libraries(${PROJECT_NAME} PRIVATE
  freetype
)


target_include_directories(${PROJECT_NAME}
  PUBLIC
    ./include
  PRIVATE
    ./impl
    ${GLFW_SOURCE_DIR}/include
    ${GLFW_SOURCE_DIR}/deps
    # ${CMAKE_CURRENT_SOURCE_DIR}/../external/sokol_gp/thirdparty
    ${CMAKE_CURRENT_SOURCE_DIR}/../external/sokol
    ${CMAKE_CURRENT_SOURCE_DIR}/../external/sokol_gp
    ${CMAKE_CURRENT_SOURCE_DIR}/../external/stb_image
    ${CMAKE_CURRENT_SOURCE_DIR}/../external/fontstash
    ${CMAKE_CURRENT_SOURCE_DIR}/../external/raudio/src
    ${CMAKE_CURRENT_SOURCE_DIR}/../external/raudio/sc/external
)

target_sources(${PROJECT_NAME} PRIVATE
    ./impl/morebase.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../external/stb_image/stb_image.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../external/raudio/src/raudio.c
)


