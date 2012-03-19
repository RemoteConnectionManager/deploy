#from http://www.lag.net/paramiko/
#this imports variables here
PackageSetup()

PackagePythonSetupSimpleAdd( http://www.lag.net/paramiko/download/paramiko-1.7.6.tar.gz )

#if(WIN32)
#	#### here we download the binary package, ase md5deep does not currently support building under windows..... sic
#	message(FATAL_ERROR "package ${PACKAGE} not currently available for windows")
#else()
#	#configure based install like ./configure --prefix=/$HOME/subversion
#	ExternalProject_Add(
#		${PACKAGE}
#		${Package_std_dirs}
#		URL http://www.lag.net/paramiko/download/paramiko-1.7.6.tar.gz
#		CONFIGURE_COMMAND ""
#		BUILD_COMMAND ""
#		INSTALL_COMMAND ${CMAKE_COMMAND} -E chdir <SOURCE_DIR> python setup.py build --build-base=<BINARY_DIR> install --prefix=<INSTALL_DIR>
#	)
#	
#endif()
#
#
#
#