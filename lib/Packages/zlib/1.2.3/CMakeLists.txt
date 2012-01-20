#it defines common setup
include(PackageSetup)
#define te url of thee package
set(URL http://www.zlib.net/zlib-1.2.3.tar.gz)
set(PATCH_COMMAND ${CMAKE_COMMAND} -E copy ${Package_Dir}/Patch/CMakeLists.txt <SOURCE_DIR>/CMakeLists.txt)

#include(SimpleExternalProject)
ExternalProject_Add(
	${PACKAGE}_get_src
	SOURCE_DIR ${BASE_SOURCE}/${PACKAGE}/src
	STAMP_DIR ${BASE_SOURCE}/${PACKAGE}/stamp
	DOWNLOAD_DIR ${BASE_SOURCE}/${PACKAGE}/download
	#define te url of thee package
	URL http://www.zlib.net/zlib-1.2.3.tar.gz
	PATCH_COMMAND ${CMAKE_COMMAND} -E copy "${Package_Dir}/Patch/CMakeLists.txt" <SOURCE_DIR>/CMakeLists.txt
)
ExternalProject_Add(
	${PACKAGE}
	DEPENDS ${PACKAGE}_get_src
	DOWNLOAD_COMMAND ""
	SOURCE_DIR ${BASE_SOURCE}/${PACKAGE}/src
	BINARY_DIR ${BASE_BUILD}/${PACKAGE}/build
	INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
	CMAKE_COMMAND ${CMAKE_COMMAND}
	CMAKE_ARGS 
		${Package_std_cmake_args}
)
	
#get_filename_component(Package_Dir ${CMAKE_CURRENT_LIST_FILE} PATH)
#message("processing file-->${Package_Dir} parent ${CMAKE_PARENT_LIST_FILE}")
#
#ExternalProject_Add(
#${PACKAGE}
##URL http://downloads.sourceforge.net/project/libpng/zlib/1.2.3/zlib-1.2.3.tar.gz?use_mirror=garr
#URL http://www.zlib.net/zlib-1.2.3.tar.gz
#PATCH_COMMAND ${CMAKE_COMMAND} -E copy "${Package_Dir}/Patch/CMakeLists.txt" <SOURCE_DIR>/CMakeLists.txt
#INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
#CMAKE_COMMAND ${CMAKE_COMMAND}
#CMAKE_ARGS 
#-DBUILD_SHARED_LIBS:BOOL=${BUILD_SHARED_LIBS}
#-DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
#)
