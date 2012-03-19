#from http://www.paraview.org
#paraview_data http://www.paraview.org/files/v3.8/ParaViewData-3.8.1.zip

#this imports variables here
PackageSetup()
message("Package_current_dependencies_effective_line------------------>${Package_current_dependencies_effective_line}<-----------------------")
message("Package_std_cmake_args------->${Package_std_cmake_args}<--")
set(make_command "")
set(custom_cmake_args "")
if(UNIX)
     set(make_command BUILD_COMMAND make -j 8)
endif()

option(${PACKAGE}_get_data "download  ${PACKAGE} data" ON)
option(${PACKAGE}_python "activate   ${PACKAGE} python wrapping" ON)
option(${PACKAGE}_examples "compile  ${PACKAGE} examples" ON)
option(${PACKAGE}_mpi "activate   ${PACKAGE} mpi" ON)

if(${PACKAGE}_python)
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
	set(custom_cmake_args ${custom_cmake_args} -DPARAVIEW_ENABLE_PYTHON:BOOL=ON)
endif()

if(${PACKAGE}_get_data)
	get_filename_component(tmp ${Package_Source_Dir} PATH)
	set(${PACKAGE}_data_root ${tmp}/data)
	ExternalProject_Add(
		${PACKAGE}_data
		SOURCE_DIR ${${PACKAGE}_data_root}
		URL http://www.paraview.org/files/v3.8/ParaViewData-3.8.1.zip
		URL_MD5 3f3d16ad4ab37798d3e747bfd0492d46
		DOWNLOAD_DIR ${Package_Download_Dir}
		STAMP_DIR ${Package_Source_Stamp_Dir}
		UPDATE_COMMAND ""
		INSTALL_COMMAND ""
		CONFIGURE_COMMAND ""
		BUILD_COMMAND ""
	)
	if(Package_current_dependencies_effective_line)
		set(Package_current_dependencies_effective_line ${Package_current_dependencies_effective_line} ${PACKAGE}_data)
	else()
		set(Package_current_dependencies_effective_line DEPENDS ${PACKAGE}_data)
	endif()
	set(custom_cmake_args ${custom_cmake_args} -DPARAVIEW_DATA_ROOT:PATH=${${PACKAGE}_data_root})
endif()	

if(${PACKAGE}_mpi)
	set(custom_cmake_args ${custom_cmake_args} -DPARAVIEW_USE_MPI:BOOL=${${PACKAGE}_mpi})
endif()

if(${PACKAGE}_examples)
	set(custom_cmake_args ${custom_cmake_args} -DBUILD_EXAMPLES:BOOL=${${PACKAGE}_examples})
endif()

ExternalProject_Add(
	${PACKAGE}
	${Package_std_dirs}
	URL http://www.paraview.org/files/v3.8/ParaView-3.8.1.tar.gz
	URL_MD5 b432b9e68cc308ae8f086d759f578125
	CMAKE_COMMAND ${CMAKE_COMMAND}
	CMAKE_ARGS ${Package_std_cmake_args} 
		${custom_cmake_args}
	${make_command}
	${Package_current_dependencies_effective_line}
	#CONFIGURE_COMMAND <SOURCE_DIR>/configure --srcdir=<SOURCE_DIR> --prefix=<INSTALL_DIR> --with-plugins=innodb_plugin
)
	





