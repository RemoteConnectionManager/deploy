#this imports variables here
PackageSetup()

FIND_PACKAGE(Bazaar)

ExternalProject_Add(
	${PACKAGE}-GetSource
	SOURCE_DIR ${Package_Source_Dir}
	STAMP_DIR ${Package_Source_Stamp_Dir}
	DOWNLOAD_COMMAND ${Bazaar_EXECUTABLE} branch lp:osg4weblinux <SOURCE_DIR>/osg4weblinux
	UPDATE_COMMAND ""
	CONFIGURE_COMMAND ""
	BUILD_COMMAND ""
	INSTALL_COMMAND ""
)


