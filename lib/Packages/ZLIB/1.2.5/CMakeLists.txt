#this imports variables here
PackageSetup()
####################################################################
#this is to patch a bug in file gzguts.h 
#equivalent to adding --->#  define snprintf _snprintf
if(MSVC)
	set(MY_CMAKE_C_FLAGS "/Dsnprintf=_snprintf ${CMAKE_C_FLAGS}")
endif()	
message("Building ${PACKAGE} with -->-DCMAKE_C_FLAGS=${MY_CMAKE_C_FLAGS}")
#####################################################################


ExternalProject_Add(
	${PACKAGE}-GetSource
	SOURCE_DIR ${Package_Source_Dir}
	STAMP_DIR ${Package_Source_Stamp_Dir}
	URL http://zlib.net/current/zlib-1.2.5.tar.gz
	URL_MD5 c735eab2d659a96e5a594c9e8541ad63
	PATCH_COMMAND ${CMAKE_COMMAND} -E remove zconf.h
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
	CMAKE_GENERATOR ${CMAKE_GENERATOR}
	CMAKE_ARGS 
		${Package_std_cmake_args}
	${Package_current_dependencies_effective_line} 
	STEP_TARGETS configure build
)

