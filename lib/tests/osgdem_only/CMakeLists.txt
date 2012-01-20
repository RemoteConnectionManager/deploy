cmake_minimum_required(VERSION 2.8)

  FIND_PACKAGE(Git)
  IF(Git_FOUND)
	MESSAGE("Git exec-->${GIT_EXECUTABLE}<--")
  ENDIF(Git_FOUND)
  FIND_PACKAGE(Subversion)
  IF(Subversion_FOUND)
	MESSAGE("svn exec-->${Subversion_SVN_EXECUTABLE}<-->${Subversion_VERSION_SVN}<--")
  ENDIF(Subversion_FOUND)

FIND_PACKAGE(osg)
message("OSG_FOUND-->${OSG_FOUND}<-------------")

if(CMAKE_EXTRA_GENERATOR)
	message("WARNING: resetting CMAKE_GENERATOR from ->${CMAKE_GENERATOR}<- to --->${CMAKE_EXTRA_GENERATOR}<-")
	set(CMAKE_GENERATOR ${CMAKE_EXTRA_GENERATOR})
endif()
include(../../CMakeModules/AssemblySetup.cmake)
debug_message("configuring with generator -->${CMAKE_GENERATOR}<--")
if(APPLE)
	set(CMAKE_OSX_ARCHITECTURES i386)
endif()

set(EXTERNAL_ASSEMBLY_COMMON_PREFIX ${CMAKE_BINARY_DIR}/install)
if(NOT EXTERNAL_ASSEMBLY_PREFIX_PATHS)
	set(EXTERNAL_ASSEMBLY_PREFIX_PATHS "${CMAKE_BINARY_DIR}/../deps/install/libs;${CMAKE_BINARY_DIR}/../deps/install/osg;${CMAKE_BINARY_DIR}/../gdal/install")
endif()
set(CMAKE_PREFIX_PATH "${CMAKE_PREFIX_PATH};${EXTERNAL_ASSEMBLY_COMMON_PREFIX};${EXTERNAL_ASSEMBLY_PREFIX_PATHS}")


add_external_package_dir(VPB)


