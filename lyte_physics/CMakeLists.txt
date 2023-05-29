cmake_minimum_required(VERSION 3.15)
project(lyte_physics LANGUAGES C CXX)
message("===============> Project: ${PROJECT_NAME}")

add_library(${PROJECT_NAME} STATIC)

set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED True)


if(CMAKE_BUILD_TYPE MATCHES "Release" OR CMAKE_BUILD_TYPE MATCHES "MinSizeRel")
  message("===> [Release] " ${PROJECT_NAME} " : Release mode: " ${CMAKE_BUILD_TYPE})
else()
  set(DEBUG ON)
  message("===> [Debug] " ${PROJECT_NAME} " : Debug mode: " ${CMAKE_BUILD_TYPE})
endif()


if (CMAKE_SYSTEM_NAME STREQUAL Emscripten)
    message("===> EMSCRIPTEN: " ${PROJECT_NAME})
else()
    message("===> PROJECT:" ${PROJECT_NAME} "SYSTEM:" ${CMAKE_SYSTEM_NAME})
endif()

message("===> Adding ODE")
set(BUILD_SHARED_LIBS OFF)
set(ODE_WITH_DEMOS OFF)
set(ODE_WITH_TESTS OFF)
set(ODE_NO_BUILTIN_THREADING_IMPL ON)
add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/../dependencies/ode-0.16.2 ${CMAKE_CURRENT_BINARY_DIR}/ode)

target_link_libraries(${PROJECT_NAME} PRIVATE
    ODE
)

target_include_directories(${PROJECT_NAME}
  PUBLIC
    ./include
  PRIVATE
    ./src
    ${CMAKE_CURRENT_SOURCE_DIR}/../lyte_api/include
    ${CMAKE_CURRENT_SOURCE_DIR}/../lyte_common/include

)

target_sources(${PROJECT_NAME}
  PRIVATE
    ./src/physics.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../lyte_common/src/map.c
)