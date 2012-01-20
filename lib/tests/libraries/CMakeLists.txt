cmake_minimum_required(VERSION 2.8)

include(../../CMakeModules/AssemblySetup.cmake)
debug_message("configuring with generator -->${CMAKE_GENERATOR}<--")

set(EXTERNAL_ASSEMBLY_COMMON_PREFIX ${CMAKE_BINARY_DIR}/../install/gtk)
#set(CMAKE_PREFIX_PATH 
#         "${CMAKE_BINARY_DIR}/install1;${CMAKE_BINARY_DIR}/install_boost;${CMAKE_BINARY_DIR}/install2;${CMAKE_BINARY_DIR}/install3" 
#)

set(CMAKE_PREFIX_PATH          ${EXTERNAL_ASSEMBLY_COMMON_PREFIX} )

set(CMAKE_FIND_ROOT_PATH "${CMAKE_PREFIX_PATH}" )
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
#set(EXTERNAL_ASSEMBLY_BUILD_SHARED_HINT ON)
set(EXTERNAL_ASSEMBLY_BUILD_SHARED ON)

#add_external_package_dir(GTK2)
add_external_package_dir(GtkGLExt)

set(EXTERNAL_ASSEMBLY_BUILD_SHARED OFF)

set(EXTERNAL_ASSEMBLY_COMMON_PREFIX ${CMAKE_BINARY_DIR}/../install/osg)
set(CMAKE_PREFIX_PATH          ${EXTERNAL_ASSEMBLY_COMMON_PREFIX} )

set(CMAKE_FIND_ROOT_PATH "${CMAKE_PREFIX_PATH}" )

add_external_package_dir(osg)

set(EXTERNAL_ASSEMBLY_COMMON_PREFIX ${CMAKE_BINARY_DIR}/../install/osg4web)

set(CMAKE_PREFIX_PATH   "${CMAKE_BINARY_DIR}/../install/gtk;${CMAKE_BINARY_DIR}/../install/osg;${EXTERNAL_ASSEMBLY_COMMON_PREFIX}" )
set(CMAKE_FIND_ROOT_PATH "${CMAKE_PREFIX_PATH}" )

add_external_package_dir(osg4web Linux)
add_external_package_dir(Firebreath 1.4.2)


