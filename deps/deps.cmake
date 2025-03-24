set(BUILD_SHARED_LIBS OFF)

if (CMAKE_SYSTEM_NAME STREQUAL Emscripten)
else()
    message("===> Adding GLFW3")
    set(GLFW_BUILD_EXAMPLES OFF)
    set(GLFW_BUILD_TESTS OFF)
    set(GLFW_BUILD_DOCS OFF)
    set(GLFW_INSTALL ON)
    set(USE_MSVC_RUNTIME_LIBRARY_DLL OFF)

    set(GLFW_BUILD_WAYLAND OFF) ## Build issue with WAYLAND + GLFW on linux builds

    add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/../deps/glfw-3.4 ${CMAKE_CURRENT_BINARY_DIR}/glfw)

    target_link_libraries(${PROJECT_NAME} PRIVATE glfw )
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
add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/../deps/physfs-3.2.0 ${CMAKE_CURRENT_BINARY_DIR}/physfs)
target_link_libraries(${PROJECT_NAME} PRIVATE physfs-static )

message("===> Adding FreeType")
add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/../deps/freetype-2.13.2 ${CMAKE_CURRENT_BINARY_DIR}/freetype)
target_link_libraries(${PROJECT_NAME} PRIVATE freetype )

message("===> Adding ODE")
set(ODE_WITH_DEMOS OFF)
set(ODE_WITH_TESTS OFF)
set(ODE_NO_BUILTIN_THREADING_IMPL ON)
add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/../deps/ode-0.16.4 ${CMAKE_CURRENT_BINARY_DIR}/ode)
target_link_libraries(${PROJECT_NAME} PRIVATE ODE )

message("===> Adding Raudio")
target_compile_definitions(${PROJECT_NAME} PRIVATE RAUDIO_STANDALONE)
target_compile_definitions(${PROJECT_NAME} PRIVATE RAUDIO_NOLOG)
target_compile_definitions(${PROJECT_NAME} PRIVATE SUPPORT_MODULE_RAUDIO)
target_compile_definitions(${PROJECT_NAME} PRIVATE SUPPORT_FILEFORMAT_WAV)
target_compile_definitions(${PROJECT_NAME} PRIVATE SUPPORT_FILEFORMAT_OGG)
target_compile_definitions(${PROJECT_NAME} PRIVATE SUPPORT_FILEFORMAT_MP3)
target_compile_definitions(${PROJECT_NAME} PRIVATE SUPPORT_FILEFORMAT_FLAC)
target_compile_definitions(${PROJECT_NAME} PRIVATE SUPPORT_FILEFORMAT_XM)
target_compile_definitions(${PROJECT_NAME} PRIVATE SUPPORT_FILEFORMAT_MOD)
add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/../deps/raudio_fe56fa7/projects/CMake ${CMAKE_CURRENT_BINARY_DIR}/raudio)
target_link_libraries(${PROJECT_NAME} PRIVATE raudio )


message("===> Adding GL")
if(APPLE)
find_package(OpenGL REQUIRED)
  target_link_libraries(${PROJECT_NAME} PUBLIC OpenGL::GL)
endif()

if(CMAKE_SYSTEM_NAME STREQUAL "Linux")
    target_link_libraries(${PROJECT_NAME} PRIVATE
        GL
        GLU
    )
endif()


message("===> Adding (include dirs) sokol, sokol_gp, stb, fontstash")
target_include_directories(${PROJECT_NAME}
  PRIVATE
    ${GLFW_SOURCE_DIR}/include
    ${GLFW_SOURCE_DIR}/dependencies
    ${CMAKE_CURRENT_SOURCE_DIR}/../deps/mg_libs
    ${CMAKE_CURRENT_SOURCE_DIR}/../deps/sokol_547f455
    ${CMAKE_CURRENT_SOURCE_DIR}/../deps/sokol_gp_a6ce39f
    ${CMAKE_CURRENT_SOURCE_DIR}/../deps/stb_013ac3b
    ${CMAKE_CURRENT_SOURCE_DIR}/../deps/fontstash_b5ddc97/src
)


