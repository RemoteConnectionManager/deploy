#this imports variables here
PackageSetup()

set(Package_additional_cmake_args "")

#this instruct the packaging to put OSG plugins in the same folder as other dll's : 
#the reason seem that, dpending on OSG version and platform deploymen, the plugins (curl) was not able to find
#runtime included MSVC....
set(Package_additional_cmake_args ${Package_additional_cmake_args} -DSEPARATE_OSG_PLUGIN_DIR:BOOL=OFF -DCORES_COMMON_DIR:BOOL=ON)

debug_message("--->
ExternalProject_Add(
	${PACKAGE}
	${Package_std_dirs}
	${Package_current_dependencies_effective_line}
#	URL http://switch.dl.sourceforge.net/project/collada-dom/Collada%20DOM/Collada%20DOM%202.2/collada-dom-2.2.zip
	#SVN_REPOSITORY http://www.openscenegraph.org/svn/osg/OpenSceneGraph/trunk
#	DOWNLOAD_COMMAND ${BZR_EXE} branch http://3d.cineca.it/storage/bazaar_repo/BrowserEmbed/test_merge/
	BZR_REPOSITORY http://3d.cineca.it/storage/bazaar_repo/BrowserEmbed/test_merge/
#	DEPENDS md5deep osg zip
	CMAKE_COMMAND ${CMAKE_COMMAND}
	CMAKE_ARGS 
		${Package_std_cmake_args}
		${Package_additional_cmake_args}
	
)
<--")
ExternalProject_Add(
	${PACKAGE}
	${Package_std_dirs}
	${Package_current_dependencies_effective_line}
#	URL http://switch.dl.sourceforge.net/project/collada-dom/Collada%20DOM/Collada%20DOM%202.2/collada-dom-2.2.zip
	#SVN_REPOSITORY http://www.openscenegraph.org/svn/osg/OpenSceneGraph/trunk
#	DOWNLOAD_COMMAND ${BZR_EXE} branch http://3d.cineca.it/storage/bazaar_repo/BrowserEmbed/test_merge/
	BZR_REPOSITORY http://3d.cineca.it/storage/bazaar_repo/BrowserEmbed/test_merge/
#	DEPENDS md5deep osg zip
	CMAKE_COMMAND ${CMAKE_COMMAND}
	CMAKE_ARGS 
		${Package_std_cmake_args}
		${Package_additional_cmake_args}
	BUILD_COMMAND ${CMAKE_COMMAND} --build . --config Release --target Build_simple_runprocess
	INSTALL_COMMAND ""
	
)
set(embed_viewer_targets Build_osg_embed_viewer_2 Build_osg_embed_viewer_1 Build_osg_embed_viewer)
set(cores Engine_FunCore)
set(simple_viewer Build_osgviewer Build_osgviewerCP)
set(copy_targets osg_copy_Release osg_copy_sys_libs)
set(targets ${embed_viewer_targets} ${cores} ${simple_viewer} ${copy_targets})
	ExternalProject_Add_Step(
		${PACKAGE}	xpi	
		COMMAND ${CMAKE_COMMAND} --build . --config Release --target build_xpi
		DEPENDEES ${targets}
		WORKING_DIRECTORY <BINARY_DIR>
	)
foreach(t ${targets})
	ExternalProject_Add_Step(
		${PACKAGE}	${t}
		COMMAND ${CMAKE_COMMAND} --build . --config Release --target ${t}
		DEPENDEES build
		DEPENDERS xpi
		WORKING_DIRECTORY <BINARY_DIR>
	)
endforeach()
