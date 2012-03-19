#this imports variables here
#here we unser debug postfix as the debug versioning is set up inside the package cmake

set(CMAKE_DEBUG_POSTFIX)

PackageSetup()

FIND_PACKAGE(Git)

if(Git_FOUND)
	set(Package_source_setup
		GIT_REPOSITORY git://scm.bluequartz.net/support-libraries/tiff.git
		UPDATE_COMMAND ""
	)
else()
	set(Package_source_setup
		URL http://3d-test.cineca.it/files/ITABC/public/cmake_packages/tiff3.8.2_cmake_git_norepo.tgz
		URL_MD5 6d91318e2a31d5b1f448817713694624
	)
endif()

PackageCmakeAdd()

# ExternalProject_Add(
# 	${PACKAGE}-GetSource
# 	SOURCE_DIR ${Package_Source_Dir}
# 	STAMP_DIR ${Package_Source_Stamp_Dir}
# 	GIT_REPOSITORY git://scm.bluequartz.net/support-libraries/tiff.git
# 	UPDATE_COMMAND ""
# 	CONFIGURE_COMMAND ""
# 	BUILD_COMMAND ""
# 	INSTALL_COMMAND ""
# )
# 
# if(Package_current_dependencies_effective_line)
# 	set( Package_current_dependencies_effective_line ${Package_current_dependencies_effective_line} ${PACKAGE}-GetSource)
# else()
# 	set(Package_current_dependencies_effective_line DEPENDS ${PACKAGE}-GetSource)
# endif()
# 
# ExternalProject_Add(
# 	${PACKAGE}
# 	${Package_std_dirs}
# 	DOWNLOAD_COMMAND ""	
# 	CMAKE_GENERATOR ${CMAKE_GENERATOR}
# 	CMAKE_ARGS 
# 		${Package_std_cmake_args}
# 	${Package_current_dependencies_effective_line} 
# 	STEP_TARGETS configure build
# )



#no patch#set(PATCH_COMMAND ${CMAKE_COMMAND} -E copy ${Package_Dir}/Patch/CMakeLists.txt <SOURCE_DIR>/CMakeLists.txt)

#include(SimpleExternalProject)

