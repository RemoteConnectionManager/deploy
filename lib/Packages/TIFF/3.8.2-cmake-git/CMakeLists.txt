#this imports variables here
#here we unser debug postfix as the debug versioning is set up inside the package cmake

set(CMAKE_DEBUG_POSTFIX)

PackageSetup()


ExternalProject_Add(
	${PACKAGE}
	${Package_std_dirs}
	GIT_REPOSITORY git://scm.bluequartz.net/support-libraries/tiff.git
	UPDATE_COMMAND ""
	CMAKE_COMMAND ${CMAKE_COMMAND}
	CMAKE_ARGS 
		${Package_std_cmake_args}
)
#no patch#set(PATCH_COMMAND ${CMAKE_COMMAND} -E copy ${Package_Dir}/Patch/CMakeLists.txt <SOURCE_DIR>/CMakeLists.txt)

#include(SimpleExternalProject)

