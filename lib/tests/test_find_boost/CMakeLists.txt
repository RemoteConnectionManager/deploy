cmake_minimum_required(VERSION 2.8)

include(../../CMakeModules/AssemblySetup.cmake)
debug_message("configuring with generator -->${CMAKE_GENERATOR}<--")

set(EXTERNAL_ASSEMBLY_COMMON_PREFIX ${CMAKE_BINARY_DIR}/install)
if(NOT EXTERNAL_ASSEMBLY_PREFIX_PATHS)
	set(EXTERNAL_ASSEMBLY_PREFIX_PATHS "${CMAKE_BINARY_DIR}/../osg4web_deps/install/libs;${CMAKE_BINARY_DIR}/../osg4web_deps/install/osg;${CMAKE_BINARY_DIR}/../osg4web_deps/install/boost")
endif()
set(CMAKE_PREFIX_PATH "${CMAKE_PREFIX_PATH};${EXTERNAL_ASSEMBLY_COMMON_PREFIX};${EXTERNAL_ASSEMBLY_PREFIX_PATHS}")

find_package(Boost COMPONENTS thread REQUIRED)
#Find_Package(Boost)
find_package(Boost COMPONENTS system REQUIRED)
find_package(Boost COMPONENTS date_time REQUIRED)

