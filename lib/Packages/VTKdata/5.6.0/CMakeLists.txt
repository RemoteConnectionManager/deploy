#this imports variables here
#override default for shared build

PackageSetup()

message("cmake args -->${Package_std_cmake_args}<--")


ExternalProject_Add(
	${PACKAGE}
	${Package_std_dirs}
	URL http://www.vtk.org/files/release/5.6/vtk-5.6.0.tar.gz
	CMAKE_COMMAND ${CMAKE_COMMAND}
	CMAKE_ARGS 
		${Package_std_cmake_args}
	${Package_current_dependencies_effective_line}
)



