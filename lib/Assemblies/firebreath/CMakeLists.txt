cmake_minimum_required(VERSION 2.8)
if(CMAKE_EXTRA_GENERATOR)
	message("WARNING: resetting CMAKE_GENERATOR from ->${CMAKE_GENERATOR}<- to --->${CMAKE_EXTRA_GENERATOR}<-")
	set(CMAKE_GENERATOR ${CMAKE_EXTRA_GENERATOR})
endif()
include(../../CMakeModules/AssemblySetup.cmake)
debug_message("configuring with generator -->${CMAKE_GENERATOR}<--")

FIND_PROGRAM(
	Mercurial_EXECUTABLE hg
	DOC "Mercurial command line client"
)
if(UNIX)
	add_external_package_dir(GTK2 2.18.9)
endif()
#add_external_package_dir(Firebreath luigicalori-cmake)
add_external_package_dir(Firebreath latest)
