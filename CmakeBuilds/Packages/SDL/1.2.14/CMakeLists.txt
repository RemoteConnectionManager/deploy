#from http://www.libsdl.org/
#this imports variables here
PackageSetup()

if(WIN32)
#	message(FATAL_ERROR "package ${PACKAGE} not currently available for windows")
	ExternalProject_Add(
		${PACKAGE}
		${Package_std_dirs}
		URL http://www.libsdl.org/release/SDL-1.2.14.tar.gz
		URL_MD5 e52086d1b508fa0b76c52ee30b55bec4
		INSTALL_COMMAND ""
		CONFIGURE_COMMAND ""
		BUILD_COMMAND ""
	)
else()
	#configure based install 
	set(Package_PkgConfig ON)

	set(Package_configure_flags "")
	PackageUnixAddCmakeVarsToConfigureFlags()

	PackageUnixConfigureSimpleAdd(
		http://www.libsdl.org/release/SDL-1.2.14.tar.gz
	)
endif()

