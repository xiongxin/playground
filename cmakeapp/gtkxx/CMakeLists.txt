cmake_minimum_required(VERSION 3.22)
project(gtkxx)

set(CMAKE_CXX_STANDARD 20)

add_executable(gtkxx main.cpp)
add_executable(base base.cc)
add_executable(hello hello.cc world.cc)

include(FindPkgConfig)
pkg_check_modules(DEPS REQUIRED gtkmm-4.0 sigc++-3.0)
include_directories(${DEPS_INCLUDE_DIRS})
target_link_libraries(gtkxx ${DEPS_LIBRARIES})
target_link_libraries(base ${DEPS_LIBRARIES})
target_link_libraries(hello ${DEPS_LIBRARIES})

# find_package(sigc++ CONFIG REQUIRED)
