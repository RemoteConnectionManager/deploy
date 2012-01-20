#from http://fontconfig.org/wiki/
#this imports variables here
PackageSetup()

if(WIN32)
	message(FATAL_ERROR "package ${PACKAGE} not currently available for windows")
else()
	#configure based install 
	set(Package_PkgConfig ON)
	set(Package_configure_flags --with-freetype-config=<INSTALL_DIR>/bin/freetype-config)
	PackageUnixConfigureSimpleAdd(
		http://fontconfig.org/release/fontconfig-2.8.0.tar.gz
	)
endif()

