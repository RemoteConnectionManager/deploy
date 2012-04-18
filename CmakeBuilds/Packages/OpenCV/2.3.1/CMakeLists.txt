

#this imports variables here
PackageSetup()

#set(Package_source_setup
#	SVN_REPOSITORY https://simtk.org/svn/simbody/trunk/
#	UPDATE_COMMAND ""
#)

option(${PACKAGE}_python "activate   ${PACKAGE} python wrapping" ON)
option(${PACKAGE}_use_image_internal "${PACKAGE} use internal jpeg,tiff,png" ON)



set(Package_source_setup
	URL http://sourceforge.net/projects/opencvlibrary/files/opencv-unix/2.3.1/OpenCV-2.3.1a.tar.bz2/download
	URL_MD5 82e4b6bfa349777233eea09b075e931e
)


if(${PACKAGE}_python)
	find_package(PythonInterp)
	if(PYTHON_EXECUTABLE)
		get_filename_component(tmp ${PYTHON_EXECUTABLE} PATH)
		get_filename_component(PYTHON_MY_BASE_DIR ${tmp} PATH)
		message("adding to CMAKE_FIND_ROOT_PATH ->${PYTHON_MY_BASE_DIR}<--")
		set(CMAKE_FIND_ROOT_PATH ${CMAKE_FIND_ROOT_PATH} ${PYTHON_MY_BASE_DIR} )
		find_package(PythonLibs)
		if(PYTHON_LIBRARY)
			set(Package_specific_cmake_args ${Package_specific_cmake_args} -DPYTHON_LIBRARY:PATH=${PYTHON_LIBRARY})
		endif()
		if(PYTHON_INCLUDE_DIR)
			set(Package_specific_cmake_args ${Package_specific_cmake_args} -DPYTHON_INCLUDE_DIR:PATH=${PYTHON_INCLUDE_DIR})
		endif()
		set(Package_specific_cmake_args ${Package_specific_cmake_args} -DCMAKE_FIND_ROOT_PATH:PATH=${PYTHON_MY_BASE_DIR})
	endif()
	set(Package_specific_cmake_args ${Package_specific_cmake_args} -DBUILD_NEW_PYTHON_SUPPORT:BOOL=ON )
endif()

if(${PACKAGE}_use_image_internal)
	set(Package_specific_cmake_args ${Package_specific_cmake_args} -DOPENCV_BUILD_3RDPARTY_LIBS:BOOL=ON )
endif()


PackageCmakeAdd()


	





