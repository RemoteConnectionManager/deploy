#this imports variables here
PackageSetup()

ExternalProject_Add(
	${PACKAGE}
	${Package_std_dirs}
	HG_REPOSITORY https://firebreath.googlecode.com/hg/
	CMAKE_COMMAND ${CMAKE_COMMAND}
	CMAKE_ARGS 
		-DPROJECTS_DIR=<SOURCE_DIR>/examples
		${Package_std_cmake_args}
)
#no patch#set(PATCH_COMMAND ${CMAKE_COMMAND} -E copy ${Package_Dir}/Patch/CMakeLists.txt <SOURCE_DIR>/CMakeLists.txt)

#include(SimpleExternalProject)

