#this imports variables here
#here we unser debug postfix as the debug versioning is set up inside the package cmake

set(CMAKE_DEBUG_POSTFIX)

PackageSetup()

ExternalProject_Add(
	${PACKAGE}-GetSource
	SOURCE_DIR ${Package_Source_Dir}
	STAMP_DIR ${Package_Source_Stamp_Dir}
	GIT_REPOSITORY git://scm.bluequartz.net/support-libraries/tiff.git
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



#no patch#set(PATCH_COMMAND ${CMAKE_COMMAND} -E copy ${Package_Dir}/Patch/CMakeLists.txt <SOURCE_DIR>/CMakeLists.txt)

#include(SimpleExternalProject)

