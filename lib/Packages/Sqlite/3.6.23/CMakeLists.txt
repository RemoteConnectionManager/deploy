#from http://www.sqlite.org/
#this imports variables here
PackageSetup()

if(WIN32)
	#### here we download the binary package, ase md5deep does not currently support building under windows..... sic
	message(FATAL_ERROR "package ${PACKAGE} not currently available for windows")
else()
	#skipping configure make and install as required as source
	ExternalProject_Add(
		${PACKAGE}
		${Package_std_dirs}
		URL http://www.sqlite.org/sqlite-amalgamation-3.6.23.tar.gz
		INSTALL_COMMAND ""
		CONFIGURE_COMMAND ""
		BUILD_COMMAND ""
	)
	
	
	
endif()



