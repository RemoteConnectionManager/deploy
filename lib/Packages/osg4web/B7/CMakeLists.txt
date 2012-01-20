#this imports variables here
PackageSetup()

ExternalProject_Add(
	${PACKAGE}
	${Package_std_dirs}
#	URL http://switch.dl.sourceforge.net/project/collada-dom/Collada%20DOM/Collada%20DOM%202.2/collada-dom-2.2.zip
	#SVN_REPOSITORY http://www.openscenegraph.org/svn/osg/OpenSceneGraph/trunk
#	DOWNLOAD_COMMAND ${BZR_EXE} branch http://3d.cineca.it/storage/bazaar_repo/BrowserEmbed/test_merge/
	BZR_REPOSITORY http://3d.cineca.it/storage/bazaar_repo/BrowserEmbed/test_merge/
	DEPENDS md5deep
	CMAKE_COMMAND ${CMAKE_COMMAND}
	CMAKE_ARGS 
		${Package_std_cmake_args}
)
#no patch#set(PATCH_COMMAND ${CMAKE_COMMAND} -E copy ${Package_Dir}/Patch/CMakeLists.txt <SOURCE_DIR>/CMakeLists.txt)

#include(SimpleExternalProject)

