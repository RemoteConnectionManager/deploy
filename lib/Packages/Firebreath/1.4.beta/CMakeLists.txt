#this imports variables here
PackageSetup()

#this setuse of external boost configured as static
set(Package_additional_cmake_args -DWITH_SYSTEM_BOOST:BOOL=ON -DBoost_USE_STATIC_LIBS:BOOL=ON)

#this is the folder where projects are (subdir of osgweb
set(Package_additional_cmake_args ${Package_additional_cmake_args} -DPROJECTS_DIR=<SOURCE_DIR>/../../../osg4web/B7/src/firebreath_projects)



ExternalProject_Add(
	${PACKAGE}-GetSource
	SOURCE_DIR ${Package_Source_Dir}
	STAMP_DIR ${Package_Source_Stamp_Dir}
	GIT_REPOSITORY git://github.com/firebreath/FireBreath.git
	GIT_TAG "firebreath-1.4b4"
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
message("Package_current_dependencies_effective_line --->${Package_current_dependencies_effective_line}<--")
message("Package_additional_cmake_args --->${Package_additional_cmake_args}<--")


ExternalProject_Add(
	${PACKAGE}
	${Package_std_dirs}
	DOWNLOAD_COMMAND ""	
	CMAKE_COMMAND ${CMAKE_COMMAND}
	CMAKE_ARGS 
		${Package_std_cmake_args}
		${Package_additional_cmake_args}
	BUILD_COMMAND ${CMAKE_COMMAND} --build . --config Release --target OSG4WebFirebreathPlugin
	INSTALL_COMMAND ""
	${Package_current_dependencies_effective_line} 
	STEP_TARGETS configure build

)
#no patch#set(PATCH_COMMAND ${CMAKE_COMMAND} -E copy ${Package_Dir}/Patch/CMakeLists.txt <SOURCE_DIR>/CMakeLists.txt)

#include(SimpleExternalProject)

