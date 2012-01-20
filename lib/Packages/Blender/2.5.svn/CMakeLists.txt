#this imports variables here
PackageSetup()

if(UNIX) 
    set(Package_add_cmake_args ${Package_add_cmake_args} -DWITH_OPENEXR:BOOL=OFF -DWITH_OPENAL:BOOL=OFF)
    PackageWriteMultiPatchFile(tmp     
#	FindLibs.diff
	p1.diff
    )

file(WRITE ${Package_Source_Stamp_Dir}/patch.cmake ${tmp})

endif()

ExternalProject_Add(
	${PACKAGE}
	${Package_std_dirs}
#	URL http://switch.dl.sourceforge.net/project/collada-dom/Collada%20DOM/Collada%20DOM%202.2/collada-dom-2.2.zip
	SVN_REPOSITORY https://svn.blender.org/svnroot/bf-blender/tags/blender-2.54-release/blender/
	UPDATE_COMMAND ""
	#PATCH_COMMAND ${CMAKE_COMMAND} -P ${Package_Source_Stamp_Dir}/patch.cmake
	CMAKE_COMMAND ${CMAKE_COMMAND}
	CMAKE_ARGS 
		${Package_std_cmake_args}
		${Package_add_cmake_args}
	${Package_current_dependencies_effective_line}
	INSTALL_COMMAND ""
)
#no patch#set(PATCH_COMMAND ${CMAKE_COMMAND} -E copy ${Package_Dir}/Patch/CMakeLists.txt <SOURCE_DIR>/CMakeLists.txt)

#include(SimpleExternalProject)

