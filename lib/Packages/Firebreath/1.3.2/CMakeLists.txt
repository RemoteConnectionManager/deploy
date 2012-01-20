#this imports variables here
PackageSetup()

#this setuse of external boost configured as static
set(Package_additional_cmake_args -DWITH_SYSTEM_BOOST=ON -DBoost_USE_STATIC_LIBS=ON)

#this is the folder where projects are (subdir of osgweb
set(Package_additional_cmake_args ${Package_additional_cmake_args} -DPROJECTS_DIR=<SOURCE_DIR>/../../../osg4web/B7/src/firebreath_projects)

ExternalProject_Add(
	${PACKAGE}
	${Package_std_dirs}
	URL http://code.google.com/p/firebreath/downloads/detail?name=firebreath-1.3.2a.zip&can=2&q=
	CMAKE_COMMAND ${CMAKE_COMMAND}
	CMAKE_ARGS 
		${Package_std_cmake_args}
		${Package_additional_cmake_args}
	BUILD_COMMAND ${CMAKE_COMMAND} --build . --config Release --target OSG4WebFirebreathPlugin
	INSTALL_COMMAND ""
	${Package_current_dependencies_effective_line}

)
#no patch#set(PATCH_COMMAND ${CMAKE_COMMAND} -E copy ${Package_Dir}/Patch/CMakeLists.txt <SOURCE_DIR>/CMakeLists.txt)

#include(SimpleExternalProject)

