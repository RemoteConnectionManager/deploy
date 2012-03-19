#this imports variables here
PackageSetup()




ExternalProject_Add(
	${PACKAGE}
	${Package_std_dirs}
	SVN_REPOSITORY http://www.openscenegraph.org/svn/osg/OpenSceneGraph-Data/trunk
	INSTALL_COMMAND ""
	CONFIGURE_COMMAND ""
	BUILD_COMMAND ""

	${Package_current_dependencies_effective_line}
)

