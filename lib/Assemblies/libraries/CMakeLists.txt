cmake_minimum_required(VERSION 2.8)
if(CMAKE_EXTRA_GENERATOR)
	message("WARNING: resetting CMAKE_GENERATOR from ->${CMAKE_GENERATOR}<- to --->${CMAKE_EXTRA_GENERATOR}<-")
	set(CMAKE_GENERATOR ${CMAKE_EXTRA_GENERATOR})
endif()
include(../../CMakeModules/AssemblySetup.cmake)
debug_message("configuring with generator -->${CMAKE_GENERATOR}<--")

set(EXTERNAL_ASSEMBLY_COMMON_PREFIX ${CMAKE_BINARY_DIR}/install1)
set(CMAKE_PREFIX_PATH "${CMAKE_BINARY_DIR}/install1;${CMAKE_BINARY_DIR}/install2;${CMAKE_BINARY_DIR}/install3" )

add_external_package_dir(ZLIB)
add_external_package_dir(PNG)
add_external_package_dir(JPEG)
add_external_package_dir(Freetype)
add_external_package_dir(CURL)
add_external_package_dir(TIFF)
add_external_package_dir(EXPAT)
add_external_package_dir(Sqlite)

set(EXTERNAL_ASSEMBLY_COMMON_PREFIX ${CMAKE_BINARY_DIR}/install2)

add_external_package_dir(osg)

set(EXTERNAL_ASSEMBLY_COMMON_PREFIX ${CMAKE_BINARY_DIR}/install3)

add_external_package_dir(osg4web B7)
add_external_package_dir(Firebreath fb_osg4web)
