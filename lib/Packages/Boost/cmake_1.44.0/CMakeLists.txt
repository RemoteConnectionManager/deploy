#####################################################
#the repo is extracted with this command
#
#git clone --branch cmake-1.44.0 git://gitorious.org/~denisarnaud/boost/denisarnauds-zeuners-boost-cmake.git src
#
#####################################################

#this imports variables here
PackageSetup()
#Bzip has to be disabled under windows
set(Package_additional_cmake_args -DWITH_BZIP2=OFF -DENABLE_DEBUG=OFF -DENABLE_SHARED=OFF -DLIBPREFIX=lib)
set(Package_cmake_generator_line "")
if(UNIX)
  find_program(KDEVELOP_EXE kdevelop)
  if(KDEVELOP_EXE)
    set(Package_cmake_generator_line CMAKE_GENERATOR KDevelop3)
  endif()
endif()
debug_message(Package_std_dirs-->${Package_std_dirs}<--)
ExternalProject_Add(
	${PACKAGE}
	${Package_std_dirs}
	${Package_current_dependencies_effective_line}
#	DOWNLOAD_COMMAND ${Git_EXECUTABLE} clone --branch cmake-1.44.0 git://gitorious.org/~denisarnaud/boost/denisarnauds-zeuners-boost-cmake.git src
#	DOWNLOAD_COMMAND ${GIT_EXECUTABLE} clone --branch cmake-1.44.0 http://git.gitorious.org/~denisarnaud/boost/denisarnauds-zeuners-boost-cmake.git <SOURCE_DIR>
#	GIT_REPOSITORY git://gitorious.org/~denisarnaud/boost/denisarnauds-zeuners-boost-cmake.git
	GIT_REPOSITORY http://git.gitorious.org/~denisarnaud/boost/denisarnauds-zeuners-boost-cmake.git
	GIT_TAG cmake-1.44.0
	UPDATE_COMMAND ""
	CMAKE_COMMAND ${CMAKE_COMMAND}
	CMAKE_ARGS 
		${Package_std_cmake_args}
		${Package_additional_cmake_args}
	#BUILD_COMMAND "" 
	#INSTALL_COMMAND ""
	${Package_cmake_generator_line}
	
)



	 
