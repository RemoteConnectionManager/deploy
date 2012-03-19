cmake_minimum_required(VERSION 2.8)
if(CMAKE_EXTRA_GENERATOR)
	message("WARNING: resetting CMAKE_GENERATOR from ->${CMAKE_GENERATOR}<- to --->${CMAKE_EXTRA_GENERATOR}<-")
	set(CMAKE_GENERATOR ${CMAKE_EXTRA_GENERATOR})
endif()

#set(CMAKE_FIND_ROOT_PATH /usr )
#set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)


include(../../CMakeModules/AssemblySetup.cmake)
debug_message("configuring with generator -->${CMAKE_GENERATOR}<--")

get_filename_component(EXTERNAL_ASSEMBLY_COMMON_PREFIX ${CMAKE_SOURCE_DIR}/../../../install/paraview ABSOLUTE)

get_filename_component(QT_INSTALL_DIR ${CMAKE_SOURCE_DIR}/../../../install/qt ABSOLUTE)
set(CMAKE_PREFIX_PATH ${EXTERNAL_ASSEMBLY_COMMON_PREFIX} ${QT_INSTALL_DIR})

find_package(PythonLibs)
find_package(X11)
find_package(PythonLibs)
find_package(X11)
#set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)

#set(CMAKE_FIND_ROOT_PATH /usr )
#set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM BOTH)
# find_package(PythonInterp)
# if(PYTHON_EXECUTABLE)
# 	get_filename_component(tmp ${PYTHON_EXECUTABLE} PATH)
# 	get_filename_component(PYTHON_MY_BASE_DIR ${tmp} PATH)
# 	
# 	set(CMAKE_FIND_ROOT_PATH ${PYTHON_MY_BASE_DIR} )
# 	set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM ONLY)
# 	set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
# 	set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
# 	
# 	find_package(PythonLibs)
# endif()

