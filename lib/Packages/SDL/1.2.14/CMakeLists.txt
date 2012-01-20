#from http://www.libsdl.org/
#this imports variables here
PackageSetup()

if(WIN32)
	message(FATAL_ERROR "package ${PACKAGE} not currently available for windows")
else()
	#configure based install 
	set(Package_PkgConfig ON)

	set(Package_configure_flags "")
	PackageUnixAddCmakeVarsToConfigureFlags()

	PackageUnixConfigureSimpleAdd(
		http://www.libsdl.org/release/SDL-1.2.14.tar.gz
	)
endif()

