cmake_minimum_required(VERSION 2.8)
if(CMAKE_EXTRA_GENERATOR)
	message("WARNING: resetting CMAKE_GENERATOR from ->${CMAKE_GENERATOR}<- to --->${CMAKE_EXTRA_GENERATOR}<-")
	set(CMAKE_GENERATOR ${CMAKE_EXTRA_GENERATOR})
endif()
include(../../CMakeModules/AssemblySetup.cmake)
debug_message("configuring with generator -->${CMAKE_GENERATOR}<--")


# set(EXTERNAL_ASSEMBLY_COMMON_PREFIX ${CMAKE_BINARY_DIR}/../../install/python)
# add_external_package_dir(Python 2.7.1)
# set(EXTERNAL_ASSEMBLY_COMMON_PREFIX ${CMAKE_BINARY_DIR}/../../install/Qt4)
# add_external_package_dir(Qt4 4.7.2)

set(EXTERNAL_ASSEMBLY_COMMON_PREFIX ${CMAKE_BINARY_DIR}/../install/ParaView)

set(CMAKE_PREFIX_PATH   "${CMAKE_BINARY_DIR}/../../install/python;${CMAKE_BINARY_DIR}/../../install/Qt4;${EXTERNAL_ASSEMBLY_COMMON_PREFIX}" )
set(CMAKE_FIND_ROOT_PATH "${CMAKE_PREFIX_PATH}" )

add_external_package_dir(ParaView 3.10.1)
