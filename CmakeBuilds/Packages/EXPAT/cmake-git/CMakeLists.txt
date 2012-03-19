#this imports variables here
PackageSetup()

FIND_PACKAGE(Git)

if(Git_FOUND)
	set(Package_source_setup
		GIT_REPOSITORY 	git://scm.bluequartz.net/support-libraries/expat.git
		UPDATE_COMMAND ""
	)
else()
	set(Package_source_setup
		URL http://3d-test.cineca.it/files/ITABC/public/cmake_packages/expat_cmake_git_norepo.tgz
		URL_MD5 af926bdc400d40db4b95718cb4ff961f
	)
endif()

PackageCmakeAdd()

# ExternalProject_Add(
# 	${PACKAGE}
# 	${Package_std_dirs}
# 	GIT_REPOSITORY 	git://scm.bluequartz.net/support-libraries/expat.git
# 	UPDATE_COMMAND ""
# 	CMAKE_COMMAND ${CMAKE_COMMAND}
# 	CMAKE_ARGS 
# 		${Package_std_cmake_args}
# )
#no patch#set(PATCH_COMMAND ${CMAKE_COMMAND} -E copy ${Package_Dir}/Patch/CMakeLists.txt <SOURCE_DIR>/CMakeLists.txt)

#include(SimpleExternalProject)

