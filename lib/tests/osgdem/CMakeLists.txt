cmake_minimum_required(VERSION 2.8)

  FIND_PACKAGE(Git)
  IF(Git_FOUND)
	MESSAGE("Git exec-->${GIT_EXECUTABLE}<--")
  ENDIF(Git_FOUND)
  FIND_PACKAGE(Subversion)
  IF(Subversion_FOUND)
	MESSAGE("svn exec-->${Subversion_SVN_EXECUTABLE}<-->${Subversion_VERSION_SVN}<--")
  ENDIF(Subversion_FOUND)


if(CMAKE_EXTRA_GENERATOR)
	message("WARNING: resetting CMAKE_GENERATOR from ->${CMAKE_GENERATOR}<- to --->${CMAKE_EXTRA_GENERATOR}<-")
	set(CMAKE_GENERATOR ${CMAKE_EXTRA_GENERATOR})
endif()
include(../../CMakeModules/AssemblySetup.cmake)
debug_message("configuring with generator -->${CMAKE_GENERATOR}<--")
if(APPLE)
	set(CMAKE_OSX_ARCHITECTURES i386)
endif()

set(EXTERNAL_ASSEMBLY_COMMON_PREFIX ${CMAKE_BINARY_DIR}/install/libs)
set(CMAKE_PREFIX_PATH "${CMAKE_PREFIX_PATH};${EXTERNAL_ASSEMBLY_COMMON_PREFIX}")
set(CMAKE_FIND_ROOT_PATH "${CMAKE_PREFIX_PATH}" )
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
add_external_package_dir(ZLIB)
add_external_package_dir(JPEG)
add_external_package_dir(CURL)
add_external_package_dir(TIFF)
add_external_package_dir(GDAL)
add_external_package_dir(PNG)
add_external_package_dir(Freetype )


  set(EXTERNAL_ASSEMBLY_COMMON_PREFIX ${CMAKE_BINARY_DIR}/install/osg)
  set(CMAKE_PREFIX_PATH "${CMAKE_PREFIX_PATH};${EXTERNAL_ASSEMBLY_COMMON_PREFIX}")
  set(CMAKE_FIND_ROOT_PATH "${CMAKE_PREFIX_PATH}" )
  set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY BOTH)

add_external_package_dir(osg 3.0.1)
add_external_package_dir(osgdata svn_head)
add_external_package_dir(VPB svn_head)


