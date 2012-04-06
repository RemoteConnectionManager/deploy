cmake_minimum_required(VERSION 2.8)
if(CMAKE_EXTRA_GENERATOR)
	message("WARNING: resetting CMAKE_GENERATOR from ->${CMAKE_GENERATOR}<- to --->${CMAKE_EXTRA_GENERATOR}<-")
	set(CMAKE_GENERATOR ${CMAKE_EXTRA_GENERATOR})
endif()
include(../../CMakeModules/AssemblySetup.cmake)
debug_message("configuring with generator -->${CMAKE_GENERATOR}<--")

set(CMAKE_PREFIX_PATH ${CMAKE_BINARY_DIR}/install )
set(CMAKE_FIND_ROOT_PATH "${CMAKE_PREFIX_PATH}" )
option(USE_SYSTEM_LIBRARIES "search also system libraries (CMAKE_FIND_ROOT_PATH_MODE_LIBRARY BOTH)" OFF)

if(USE_SYSTEM_LIBRARIES)
	set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY BOTH)
else()
	set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
endif()
set(EXTERNAL_ASSEMBLY_BUILD_SHARED_HINT ON)
set(CURL_static OFF)

add_external_package_dir(Apache 2.4.1)
add_external_package_dir(Subversion 1.7.4 TRUE)

add_external_package_dir(PHP 5.4.0)
option(USE_WSGI "build mod_wsgi module" OFF)
if(USE_WSGI)
#  add_external_package_dir(mod_wsgi)
endif()

