####################################################################
#These options seems to be mutually exclusive, 
#so depending on the assembly setup decide weather configure static or shared
####################################################################
if(EXTERNAL_ASSEMBLY_BUILD_SHARED)
    set(PNG_SHARED ON)
    set(PNG_STATIC OFF)
else()
    set(PNG_SHARED OFF)
    set(PNG_STATIC ON)
endif()
set(Package_add_cmake_args -DPNG_SHARED:BOOL=${PNG_SHARED} -DPNG_STATIC:BOOL=${PNG_STATIC})
if(UNIX) 
    set(Package_add_cmake_args ${Package_add_cmake_args} -DPNG_NO_STDIO:BOOL=OFF)
endif()
####################################################################

#this imports variables here
PackageSetup()

ExternalProject_Add(
	${PACKAGE}-GetSource
	SOURCE_DIR ${Package_Source_Dir}
	STAMP_DIR ${Package_Source_Stamp_Dir}
	URL http://sunet.dl.sourceforge.net/project/libpng/libpng12/1.2.44/libpng-1.2.44.tar.gz
	URL_MD5 89b62f8daaeeab1342e307d6d1411ff1
	UPDATE_COMMAND ""
	CONFIGURE_COMMAND ""
	BUILD_COMMAND ""
	INSTALL_COMMAND ""
)

if(Package_current_dependencies_effective_line)
	set( Package_current_dependencies_effective_line ${Package_current_dependencies_effective_line} ${PACKAGE}-GetSource)
else()
	set(Package_current_dependencies_effective_line DEPENDS ${PACKAGE}-GetSource)
endif()

ExternalProject_Add(
	${PACKAGE}
	${Package_std_dirs}
	DOWNLOAD_COMMAND ""	
	${Package_current_dependencies_effective_line}
	CMAKE_COMMAND ${CMAKE_COMMAND}
	CMAKE_ARGS 
		${Package_std_cmake_args}
		${Package_add_cmake_args}
#		-DPNG_SHARED:BOOL=${PNG_SHARED}
#		-DPNG_STATIC:BOOL=${PNG_STATIC}
	STEP_TARGETS configure build
)





#ExternalProject_Add(
#libpng-1.2.41
#DEPENDS zlib-1.2.3
#URL http://downloads.sourceforge.net/project/libpng/00-libpng-stable/1.2.41/libpng-1.2.41.tar.gz
#PATCH_COMMAND ${CMAKE_COMMAND} -E rename <SOURCE_DIR>/scripts/libpng.pc.in <SOURCE_DIR>/scripts/libpng-pc.in
##DOWNLOAD_COMMAND ${Wget} <URL>
#BUILD_IN_SOURCE 0
#INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
#CMAKE_COMMAND ${CMAKE_COMMAND}
#CMAKE_ARGS 
#-DBUILD_SHARED_LIBS:BOOL=${BUILD_SHARED_LIBS}
#-DPNG_SHARED:BOOL=${PNG_SHARED}
#-DPNG_STATIC:BOOL=${PNG_STATIC}
#-DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
#-DCMAKE_PREFIX_PATH:PATH=<INSTALL_DIR>
#)
#