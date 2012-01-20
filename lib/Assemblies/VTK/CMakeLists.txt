cmake_minimum_required(VERSION 2.8)
message("uuuuuuuuuuuuuuuuuuuuuuuuu")
if(CMAKE_EXTRA_GENERATOR)
	message("WARNING: resetting CMAKE_GENERATOR from ->${CMAKE_GENERATOR}<- to --->${CMAKE_EXTRA_GENERATOR}<-")
	set(CMAKE_GENERATOR ${CMAKE_EXTRA_GENERATOR})
endif()
include(../../CMakeModules/AssemblySetup.cmake)

debug_message("configuring with generator -->${CMAKE_GENERATOR}<--")

set(BUILD_SHARED_LIBS ON)
set(VTK_WRAP_PYTHON ON)
set(BUILD_EXAMPLES ON)
list(APPEND Package_Pass_Variables VTK_WRAP_PYTHON BUILD_EXAMPLES)
add_external_package_dir(VTK 5.6.0)

