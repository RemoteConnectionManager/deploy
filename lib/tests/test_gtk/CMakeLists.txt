cmake_minimum_required(VERSION 2.8)

include(../../CMakeModules/AssemblySetup.cmake)
debug_message("configuring with generator -->${CMAKE_GENERATOR}<--")

set(CMAKE_PREFIX_PATH ${CMAKE_BINARY_DIR}/install )
set(CMAKE_FIND_ROOT_PATH "${CMAKE_PREFIX_PATH}" )
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)

add_external_package_dir(GTK2)

