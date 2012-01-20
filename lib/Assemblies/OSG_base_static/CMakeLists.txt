cmake_minimum_required(VERSION 2.8)

message("ATTENZIONE CMAKE_BUILD_TYPE-->${CMAKE_BUILD_TYPE}<--")
set(CMAKE_DEBUG_POSTFIX "D")
SET(USER_MODULE_PATH "" CACHE PATH "set this to define a folder for module override")
IF(USER_MODULE_PATH)
	SET(CMAKE_MODULE_PATH "${USER_MODULE_PATH};${CMAKE_SOURCE_DIR}/../../CMakeModules;${CMAKE_MODULE_PATH}")
ELSE(USER_MODULE_PATH)
	SET(CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/../../CMakeModules;${CMAKE_MODULE_PATH}")
ENDIF(USER_MODULE_PATH)

# Allow the user to toggle between static/shared builds
option(CMAKEPORTS_BUILD_SHARED OFF)
if(NOT DEFINED BUILD_SHARED_LIBS)
    set(BUILD_SHARED_LIBS ${CMAKEPORTS_BUILD_SHARED})
endif()
#


  FIND_PACKAGE(Subversion)
  IF(Subversion_FOUND)
	MESSAGE("svn exec-->${Subversion_SVN_EXECUTABLE}<-->${Subversion_VERSION_SVN}<--")
  ENDIF(Subversion_FOUND)
  
  FIND_PROGRAM(Wget wget)
  IF(Wget)
	MESSAGE("wget exec-->${Wget}")
  ENDIF(Wget)
 
  find_program(PATCH_PROGRAM patch)
   IF(PATCH_PROGRAM)
	MESSAGE("patch exec-->${PATCH_PROGRAM}")
  ENDIF()



include(ExternalProject)

get_filename_component(BASE_SOURCE ${CMAKE_SOURCE_DIR}/../../Sources ABSOLUTE)
set(BASE_BUILD ${CMAKE_BINARY_DIR}/bld)
set(CMAKE_INSTALL_PREFIX ${CMAKE_BINARY_DIR}/install)
set(CMAKE_PREFIX_PATH ${CMAKE_BINARY_DIR}/install)
#set(CMAKE_BUILD_TYPE Release)
set(CMAKE_DEBUG_SUFFIX "d")


find_package(ZLIB NO_DEFAULT_PATH)
message("zlib library NO_DEFAULT_PATH-->${ZLIB_LIBRARY}<-->${ZLIB_INCLUDE_DIR}<--")
find_package(ZLIB )
message("zlib library -->${ZLIB_LIBRARY}<-->${ZLIB_INCLUDE_DIR}<--")

find_package(PNG NO_DEFAULT_PATH)
message("png library NO_DEFAULT_PATH-->${PNG_LIBRARY}<-->${PNG_INCLUDE_DIR}<--")
find_package(PNG )
message("png library -->${PNG_LIBRARY}<-->${PNG_INCLUDE_DIR}<--")



#zlib
add_subdirectory(../../Packages/zlib/1.2.3 ${BASE_BUILD}/zlib)

#jpeg
#add_subdirectory(../../Packages/jpeg/v7)

#### png
#include(Packages/png/1.2.41/external.cmake)
add_subdirectory(../../Packages/png/1.2.41 ${BASE_BUILD}/png)
#add_subdirectory(../../Packages/collada_dom/2.2 ${BASE_BUILD}/collada_dom)
#add_subdirectory(../../Packages/pcre/8.01 ${BASE_BUILD}/pcre)

#freetype
#add_subdirectory(Packages/freetype/2.3.8)

#### curl
#include(Packages/curl/7.19.7/external.cmake)
#add_subdirectory(Packages/curl/7.19.7)
#include(Packages/zlib/1.2.3/external.cmake)

#ExternalProject_Add(
#CMake-2-6-4
#CVS_REPOSITORY :pserver:anonymous:cmake@www.cmake.org:/cvsroot/CMake
#CVS_MODULE CMake
#CVS_TAG -r CMake-2-6-4
#CMAKE_ARGS -DCMAKE_INSTALL_PREFIX:PATH=${CMAKE_INSTALL_PREFIX}
#UPDATE_COMMAND ""
#)
