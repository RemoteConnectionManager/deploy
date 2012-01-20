#from http://svn.apache.org/repos/asf/subversion/trunk/INSTALL
#this imports variables here
PackageSetup()

if(WIN32)
	#### here we download the binary package, ase md5deep does not currently support building under windows..... sic
	message(FATAL_ERROR "package ${PACKAGE} not currently available for windows")
else()
	#configure based install like ./configure --prefix=/$HOME/subversion
	ExternalProject_Add(
		${PACKAGE}
		${Package_std_dirs}
		URL http://subversion.tigris.org/downloads/subversion-1.6.9.tar.gz
		#MD5: bb0fe4ccfdd4645ea4581933c6a666b3
		CONFIGURE_COMMAND <SOURCE_DIR>/configure --srcdir=<SOURCE_DIR> --prefix=<INSTALL_DIR> --with-apr=<INSTALL_DIR> --with-apr-util=<INSTALL_DIR> --with-sqlite=${EXTERNAL_ASSEMBLY_BASE_SOURCE}/Sqlite/3.6.23/src 
	)
	
endif()



