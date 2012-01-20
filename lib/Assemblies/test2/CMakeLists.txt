cmake_minimum_required(VERSION 2.8)
include(../../CMakeModules/AssemblySetup.cmake)

#find_package(ZLIB NO_DEFAULT_PATH)
#message("zlib library NO_DEFAULT_PATH-->${ZLIB_LIBRARY}<-->${ZLIB_INCLUDE_DIR}<--")
#find_package(ZLIB )
#message("zlib library -->${ZLIB_LIBRARY}<-->${ZLIB_INCLUDE_DIR}<--")

#find_package(GIT)



#zlib
#add_subdirectory(../../Packages/zlib/1.2.3.7_beta ${EXTERNAL_ASSEMBLY_BASE_BUILD}/zlib)
#add_subdirectory(../../Packages/png/1.2.41 ${EXTERNAL_ASSEMBLY_BASE_BUILD}/png)
add_external_package_dir(zlib 1.2.3.7_beta)
add_external_package_dir(png 1.2.41)
add_external_package_dir(jpeg v7)
add_external_package_dir(freetype 2.3.8)
add_external_package_dir(curl 7.19.7)
add_external_package_dir(osg svn_head)
#add_subdirectory(../../Packages/jpeg/v7 ${EXTERNAL_ASSEMBLY_BASE_BUILD}/jpeg)

#jpeg
#add_subdirectory(../../Packages/jpeg/v7)

#### png
#include(Packages/png/1.2.41/external.cmake)
#add_subdirectory(../../Packages/png/1.2.41 ${BASE_BUILD}/png)
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
