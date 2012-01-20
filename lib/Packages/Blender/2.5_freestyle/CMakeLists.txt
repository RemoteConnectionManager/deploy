#this imports variables here

#WARNING the build is not automated:....   manually did:
1) first build python 3 as the cmake code does not find it in the assembly build phase, then it cannot pass the correct vars when build effectively the Blender package: it should be defined within a pre-configure step.......
2) a patch has to be applied to resolve a compile time issue found at:
http://projects.blender.org/tracker/?func=detail&atid=127&aid=27829&group_id=9
patch at:
http://projects.blender.org/tracker/download.php/9/127/27829/16928/Debian_lenny_no_XF86XK_AudioForward.patch
3) the default install does not install on CMAKE_INSTALL_PREFIX need to set
WITH_INSTALL_PORTABLE to OFF
Also this module get a svn repo, so changes each time is built....
PackageSetup()

if(UNIX)
	message("Prima di Find CMAKE_FIND_ROOT_PATH ${CMAKE_FIND_ROOT_PATH}<--")
	set(Python_FIND_VERSION_MAJOR 3)
	set(Python_FIND_VERSION_MINOR 2)
	set(Python_FIND_VERSION_EXACT 1)
	message("prima di Find Python PYTHON_EXECUTABLE ->${PYTHON_EXECUTABLE}<--")
	find_package(Python)
	message("dopo di Find Python PYTHON_EXECUTABLE ->${PYTHON_EXECUTABLE}<--")
	message("dopo di Find Python PYTHON_INCLUDE_DIR -->${PYTHON_INCLUDE_DIR}")
	message("dopo di Find Python _PYTHON_LIBRARY_PATH -->${_PYTHON_LIBRARY_PATH}")
	if(PYTHON_EXECUTABLE)
		set(custom_cmake_args ${custom_cmake_args} -DPYTHON_EXECUTABLE:PATH=${PYTHON_EXECUTABLE})
		get_filename_component(tmp ${PYTHON_EXECUTABLE} PATH)
		get_filename_component(PYTHON_MY_BASE_DIR ${tmp} PATH)
		set(custom_cmake_args ${custom_cmake_args} -DCMAKE_FIND_ROOT_PATH:PATH=${PYTHON_MY_BASE_DIR})
	endif()
	if(PYTHON_LIBRARY)
		set(custom_cmake_args ${custom_cmake_args} -DPYTHON_LIBRARY:PATH=${PYTHON_LIBRARY})
	endif()
	if(PYTHON_INCLUDE_DIR)
		set(custom_cmake_args ${custom_cmake_args} -DPYTHON_INCLUDE_DIR:PATH=${PYTHON_INCLUDE_DIR})
	endif()

# 	set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM ONLY)
# 	message("Prima di Find CMAKE_FIND_ROOT_PATH_MODE_PROGRAM ->${CMAKE_FIND_ROOT_PATH_MODE_PROGRAM}<--")
# 	find_package(PythonInterp)
# 	message("Found PYTHON_EXECUTABLE ->${PYTHON_EXECUTABLE}<--")
# 	if(PYTHON_EXECUTABLE)
# 		get_filename_component(tmp ${PYTHON_EXECUTABLE} PATH)
# 		get_filename_component(PYTHON_MY_BASE_DIR ${tmp} PATH)
# 		message("adding to CMAKE_FIND_ROOT_PATH ->${PYTHON_MY_BASE_DIR}<--")
# 		set(CMAKE_FIND_ROOT_PATH ${CMAKE_FIND_ROOT_PATH} ${PYTHON_MY_BASE_DIR} )
# 		set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
# 		set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
# 		set(PYTHON_INCLUDE_PATH "")
# 		message("Prima di Find PYTHON_INCLUDE_DIR -->${PYTHON_INCLUDE_DIR}")
# 		message("Prima di Find PYTHON_INCLUDE_PATH-->${PYTHON_INCLUDE_PATH}")
# 		find_package(PythonLibs)
# 		message("Dopo di Find PYTHON_INCLUDE_DIR -->${PYTHON_INCLUDE_DIR}")
# 		if(PYTHON_LIBRARY)
# 			set(custom_cmake_args ${custom_cmake_args} -DPYTHON_LIBRARY:PATH=${PYTHON_LIBRARY})
# 		endif()
# 		if(PYTHON_INCLUDE_DIR)
# 			set(custom_cmake_args ${custom_cmake_args} -DPYTHON_INCLUDE_DIR:PATH=${PYTHON_INCLUDE_DIR})
# 		endif()
# 		set(custom_cmake_args ${custom_cmake_args} -DCMAKE_FIND_ROOT_PATH:PATH=${PYTHON_MY_BASE_DIR})
# 	endif()
#     set(Package_specific_cmake_args ${custom_cmake_args} -DWITH_OPENEXR:BOOL=OFF -DWITH_OPENAL:BOOL=OFF -DWITH_SDL:BOOL=OFF)
# 
endif()

set(Package_source_setup
	SVN_REPOSITORY https://svn.blender.org/svnroot/bf-blender/branches/soc-2008-mxcurioni/
	UPDATE_COMMAND ""
	)


PackageCmakeAdd()


# if(UNIX) 
#     	set(Package_add_cmake_args ${Package_add_cmake_args} -DWITH_OPENEXR:BOOL=OFF -DWITH_OPENAL:BOOL=OFF)
# 	file(WRITE ${Package_Source_Stamp_Dir}/patch.cmake ${tmp})
# endif()
# 
# ExternalProject_Add(
# 	${PACKAGE}
# 	${Package_std_dirs}
# #	URL http://switch.dl.sourceforge.net/project/collada-dom/Collada%20DOM/Collada%20DOM%202.2/collada-dom-2.2.zip
# 	SVN_REPOSITORY https://svn.blender.org/svnroot/bf-blender/branches/soc-2008-mxcurioni/
# 	UPDATE_COMMAND ""
# 	#PATCH_COMMAND ${CMAKE_COMMAND} -P ${Package_Source_Stamp_Dir}/patch.cmake
# 	CMAKE_COMMAND ${CMAKE_COMMAND}
# 	CMAKE_ARGS 
# 		${Package_std_cmake_args}
# 		${Package_add_cmake_args}
# 	${Package_current_dependencies_effective_line}
# 	INSTALL_COMMAND ""
# )
#no patch#set(PATCH_COMMAND ${CMAKE_COMMAND} -E copy ${Package_Dir}/Patch/CMakeLists.txt <SOURCE_DIR>/CMakeLists.txt)

#include(SimpleExternalProject)

