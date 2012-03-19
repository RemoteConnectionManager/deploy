#from http://fontconfig.org/wiki/
#this imports variables here
PackageSetup()

if(WIN32)
	message(FATAL_ERROR "package ${PACKAGE} not currently available for windows")
else()
	#configure based install 
	set(Package_PkgConfig ON)
	message("WARNING!!!! setting --with-freetype-config to <INSTALL_DIR> ... NOT ROBUST should use find")
	set(Package_configure_flags --with-freetype-config=<INSTALL_DIR>/bin/freetype-config)
	set(Package_source_setup
		URL http://fontconfig.org/release/fontconfig-2.8.0.tar.gz
		URL_MD5 77e15a92006ddc2adbb06f840d591c0e
	)

	PackageUnixConfigureAdd()
#	PackageUnixConfigureSimpleAdd(
#		http://fontconfig.org/release/fontconfig-2.8.0.tar.gz
#	)
endif()

