cmake_minimum_required(VERSION 2.8)
if(CMAKE_EXTRA_GENERATOR)
	message("WARNING: resetting CMAKE_GENERATOR from ->${CMAKE_GENERATOR}<- to --->${CMAKE_EXTRA_GENERATOR}<-")
	set(CMAKE_GENERATOR ${CMAKE_EXTRA_GENERATOR})
endif()
include(../../CMakeModules/AssemblySetup.cmake)
debug_message("configuring with generator -->${CMAKE_GENERATOR}<--")

find_package(PythonInterp)
message("PYTHON_EXECUTABLE-->${PYTHON_EXECUTABLE}<--")
add_external_package_dir(Python 2.6.5)

add_external_package_dir(Paramiko)

