#this imports variables here
PackageSetup()

if(UNIX) 
	find_package(PythonInterp)
	if(PYTHON_EXECUTABLE)
		get_filename_component(tmp ${PYTHON_EXECUTABLE} PATH)
		get_filename_component(PYTHON_MY_BASE_DIR ${tmp} PATH)
		message("adding to CMAKE_FIND_ROOT_PATH ->${PYTHON_MY_BASE_DIR}<--")
		set(CMAKE_FIND_ROOT_PATH ${CMAKE_FIND_ROOT_PATH} ${PYTHON_MY_BASE_DIR} )
		find_package(PythonLibs)
		if(PYTHON_LIBRARY)
			set(custom_cmake_args ${custom_cmake_args} -DPYTHON_LIBRARY:PATH=${PYTHON_LIBRARY})
		endif()
		if(PYTHON_INCLUDE_DIR)
			set(custom_cmake_args ${custom_cmake_args} -DPYTHON_INCLUDE_DIR:PATH=${PYTHON_INCLUDE_DIR})
		endif()
		set(custom_cmake_args ${custom_cmake_args} -DCMAKE_FIND_ROOT_PATH:PATH=${PYTHON_MY_BASE_DIR})
	endif()
    set(Package_specific_cmake_args ${custom_cmake_args} -DWITH_OPENEXR:BOOL=OFF -DWITH_OPENAL:BOOL=OFF)
    PackageWriteMultiPatchFile(tmp     
#	FindLibs.diff
	p1.diff
    )
    file(WRITE ${Package_Source_Stamp_Dir}/patch.cmake ${tmp})

endif()

set(Package_source_setup
	SVN_REPOSITORY https://svn.blender.org/svnroot/bf-blender/branches/blender2.4
	UPDATE_COMMAND ""
	PATCH_COMMAND ${CMAKE_COMMAND} -P ${Package_Source_Stamp_Dir}/patch.cmake
	)


PackageCmakeAdd()






