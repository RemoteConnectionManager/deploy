cmake_minimum_required(VERSION 2.8)
if(NOT AUTO_PACKAGE)
  message(FATAL "Please define AUTO_PACKAGE with cmake -DAUTO_PACKAGE:PATH=<package name>")
endif() 

if( NOT EXTERNAL_ASSEMBLY_BUILD_SHARED_HINT)
	set(EXTERNAL_ASSEMBLY_BUILD_SHARED_HINT ON CACHE BOOL "use shared linking")
endif()

include(../../CMakeModules/AssemblySetup.cmake)
debug_message("configuring with generator -->${CMAKE_GENERATOR}<--")

set(CMAKE_PREFIX_PATH ${EXTERNAL_ASSEMBLY_COMMON_PREFIX} )
set(CMAKE_FIND_ROOT_PATH "${CMAKE_PREFIX_PATH}" )
#set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)

add_external_package_dir(${AUTO_PACKAGE} ${AUTO_PACKAGE_VERSION} ${AUTO_PACKAGE_FORCE})

