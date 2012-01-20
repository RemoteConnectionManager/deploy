#this imports variables here
PackageSetup()


ExternalProject_Add(
	${PACKAGE}
	${Package_std_dirs}
	URL http://firebreath.googlecode.com/files/firebreath-1.3.0rc3.tar.gz
	CMAKE_COMMAND ${CMAKE_COMMAND}
	CMAKE_ARGS 
		-DPROJECTS_DIR=<SOURCE_DIR>/../../../osg4web/B7/src/firebreath_projects
		${Package_std_cmake_args}
	BUILD_COMMAND ${CMAKE_COMMAND} --build . --config Release --target FBTestPlugin
	INSTALL_COMMAND ""
	${Package_current_dependencies_effective_line}

)
#no patch#set(PATCH_COMMAND ${CMAKE_COMMAND} -E copy ${Package_Dir}/Patch/CMakeLists.txt <SOURCE_DIR>/CMakeLists.txt)

#include(SimpleExternalProject)

