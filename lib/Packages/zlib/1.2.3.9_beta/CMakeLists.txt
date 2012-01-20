#this imports variables here
PackageSetup()
####################################################################
#this is to patch a bug in file gzguts.h 
#equivalent to adding --->#  define snprintf _snprintf
if(MSVC)
	set(MY_CMAKE_C_FLAGS "/Dsnprintf=_snprintf ${CMAKE_C_FLAGS}")
else()
#this is to avoid linking errors on AMD64, basically add -fPIC also to static lib buildslike
#relocation R_X86_64_32S
#see
#http://www.cmake.org/pipermail/cmake/2006-September/011316.html
#http://www.gentoo.org/proj/en/base/amd64/howtos/index.xml?part=1&chap=3

#old#	if("${CMAKE_SYSTEM_PROCESSOR}" STREQUAL "x86_64")
#old#		set(MY_CMAKE_C_FLAGS "-fPIC ${CMAKE_C_FLAGS}")
#old#	else()
#old#		set(MY_CMAKE_C_FLAGS "${CMAKE_C_FLAGS}")
#old#	endif()
endif()	
message("Building ${PACKAGE} with -->-DCMAKE_C_FLAGS=${MY_CMAKE_C_FLAGS}")
#####################################################################

ExternalProject_Add(
	${PACKAGE}
	${Package_std_dirs}
	URL http://zlib.net/current/beta/zlib-1.2.3.9.tar.gz
	CMAKE_COMMAND ${CMAKE_COMMAND}
	CMAKE_ARGS 
		${Package_std_cmake_args}
)

########################################################################################
#
##include(SimpleExternalProject)
#ExternalProject_Add(
#	${PACKAGE}_get_src
#	${Package_std_source_dirs}
#	SOURCE_DIR ${BASE_SOURCE}/${PACKAGE}/${VERSION}/src
#	STAMP_DIR ${BASE_SOURCE}/${PACKAGE}/${VERSION}/stamp
#	DOWNLOAD_DIR ${BASE_SOURCE}/${PACKAGE}/${VERSION}/download
#	#define te url of thee package
#	URL http://zlib.net/current/beta/zlib-1.2.3.7.tar.gz
#	CONFIGURE_COMMAND ""
#	BUILD_COMMAND ""
#	INSTALL_COMMAND ""
#)
#
#####################################################################
##this is to patch a bug in file gzguts.h 
##equivalent to adding --->#  define snprintf _snprintf
#set(MY_CMAKE_C_FLAGS "/Dsnprintf=_snprintf ${CMAKE_C_FLAGS}")
#message("Building ${PACKAGE} with -->-DCMAKE_C_FLAGS=${MY_CMAKE_C_FLAGS}")
######################################################################
#
#ExternalProject_Add(
#	${PACKAGE}
#	DEPENDS ${PACKAGE}_get_src
#	DOWNLOAD_COMMAND ""
#	UPDATE_COMMAND ""
#	SOURCE_DIR ${EXTERNAL_ASSEMBLY_BASE_SOURCE}/${PACKAGE}/${VERSION}/src
#	BINARY_DIR ${BASE_BUILD}/${PACKAGE}/build
#	INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
#	CMAKE_COMMAND ${CMAKE_COMMAND}
#	CMAKE_ARGS 
#		${Package_std_cmake_args}
#		-DCMAKE_C_FLAGS:STRING=${MY_CMAKE_C_FLAGS}
#)
#	
##get_filename_component(Package_Dir ${CMAKE_CURRENT_LIST_FILE} PATH)
##message("processing file-->${Package_Dir} parent ${CMAKE_PARENT_LIST_FILE}")
##
##ExternalProject_Add(
##${PACKAGE}
###URL http://downloads.sourceforge.net/project/libpng/zlib/1.2.3/zlib-1.2.3.tar.gz?use_mirror=garr
##URL http://www.zlib.net/zlib-1.2.3.tar.gz
##PATCH_COMMAND ${CMAKE_COMMAND} -E copy "${Package_Dir}/Patch/CMakeLists.txt" <SOURCE_DIR>/CMakeLists.txt
##INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
##CMAKE_COMMAND ${CMAKE_COMMAND}
##CMAKE_ARGS 
##-DBUILD_SHARED_LIBS:BOOL=${BUILD_SHARED_LIBS}
##-DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
##)
#