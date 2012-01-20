cmake_minimum_required(VERSION 2.8)
if(CMAKE_EXTRA_GENERATOR)
	message("WARNING: resetting CMAKE_GENERATOR from ->${CMAKE_GENERATOR}<- to --->${CMAKE_EXTRA_GENERATOR}<-")
	set(CMAKE_GENERATOR ${CMAKE_EXTRA_GENERATOR})
endif()
include(../../CMakeModules/AssemblySetup.cmake)
debug_message("configuring with generator -->${CMAKE_GENERATOR}<--")

set(CMAKE_PREFIX_PATH ${CMAKE_BINARY_DIR}/install )
set(CMAKE_FIND_ROOT_PATH "${CMAKE_PREFIX_PATH}" )
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(EXTERNAL_ASSEMBLY_BUILD_SHARED_HINT ON)


add_external_package_dir(Apache)
add_external_package_dir(Subversion 1.6.16 1)

add_external_package_dir(PHP)

