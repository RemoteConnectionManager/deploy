#this imports variables here
PackageSetup()

if(WIN32)
	message(FATAL_ERROR "package ${PACKAGE} not currently available for windows")
else()
	#configure based install 
	set(Package_PkgConfig ON)
	set(Package_source_setup
		URL http://distfiles.gentoo.org/distfiles/libecwj2-3.3-2006-09-06.zip
		URL_MD5 acc04e07153c2a2a6595b3e2ebf34432
	)
	set(Package_InSource ON)	
	PackageUnixConfigureAdd()
	ExternalProject_Add_Step(${PACKAGE} mkdir_install_include
		COMMAND ${CMAKE_COMMAND} -E   make_directory <INSTALL_DIR>/include
		COMMENT "strange bug: not able to install if not already include folder"
		DEPENDEES build
		DEPENDERS install
	)

endif()

