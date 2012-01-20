#this imports variables here
PackageSetup()

set(Package_additional_cmake_args "")

#this instruct the packaging to put OSG plugins in the same folder as other dll's : 
#the reason seem that, dpending on OSG version and platform deploymen, the plugins (curl) was not able to find
#runtime included MSVC....
set(Package_additional_cmake_args ${Package_additional_cmake_args} -DSEPARATE_OSG_PLUGIN_DIR:BOOL=OFF)


ExternalProject_Add(
	${PACKAGE}
	${Package_std_dirs}
#	URL http://switch.dl.sourceforge.net/project/collada-dom/Collada%20DOM/Collada%20DOM%202.2/collada-dom-2.2.zip
	#SVN_REPOSITORY http://www.openscenegraph.org/svn/osg/OpenSceneGraph/trunk
#	DOWNLOAD_COMMAND ${BZR_EXE} branch http://3d.cineca.it/storage/bazaar_repo/BrowserEmbed/test_merge/
	BZR_REPOSITORY http://3d.cineca.it/storage/bazaar_repo/BrowserEmbed/test_merge/
	DEPENDS md5deep osg zip
	CMAKE_COMMAND ${CMAKE_COMMAND}
	CMAKE_ARGS 
		${Package_std_cmake_args}
		${Package_additional_cmake_args}
)
#no patch#set(PATCH_COMMAND ${CMAKE_COMMAND} -E copy ${Package_Dir}/Patch/CMakeLists.txt <SOURCE_DIR>/CMakeLists.txt)

#include(SimpleExternalProject)

