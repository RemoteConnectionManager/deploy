#this imports variables here
set(EXTERNAL_ASSEMBLY_BUILD_SHARED ON)
PackageSetup()



#PackageWriteMultiPatchFile(tmp     
#	module_override.diff
#	OpenThreads_versions.diff
#)
#file(WRITE ${Package_Source_Stamp_Dir}/patch.cmake ${tmp})



ExternalProject_Add(
	${PACKAGE}
	${Package_std_dirs}
#	URL http://switch.dl.sourceforge.net/project/collada-dom/Collada%20DOM/Collada%20DOM%202.2/collada-dom-2.2.zip
	GIT_REPOSITORY git://github.com/gwaldron/osgearth.git
	UPDATE_COMMAND ""
#	PATCH_COMMAND ${CMAKE_COMMAND} -P ${Package_Source_Stamp_Dir}/patch.cmake
	CMAKE_COMMAND ${CMAKE_COMMAND}
	CMAKE_ARGS 
		${Package_std_cmake_args}
	${Package_current_dependencies_effective_line}
)
#no patch#set(PATCH_COMMAND ${CMAKE_COMMAND} -E copy ${Package_Dir}/Patch/CMakeLists.txt <SOURCE_DIR>/CMakeLists.txt)

#include(SimpleExternalProject)

