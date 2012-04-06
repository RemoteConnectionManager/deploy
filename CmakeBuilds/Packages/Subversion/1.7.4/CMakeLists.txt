#from http://svn.apache.org/repos/asf/subversion/trunk/INSTALL
#this imports variables here
PackageSetup()

if(WIN32)
	#### here we download the binary package, ase md5deep does not currently support building under windows..... sic
	message(FATAL_ERROR "package ${PACKAGE} not currently available for windows")
else()

 	PackageWriteMultiPatchFile(tmp     
		mod_dav_svn.diff
 	)
 
 	file(WRITE ${Package_Source_Stamp_Dir}/patch.cmake ${tmp})

	set(Package_configure_flags --with-apr=<INSTALL_DIR> --with-apr-util=<INSTALL_DIR> --with-sqlite=<INSTALL_DIR> --with-apxs=<INSTALL_DIR>/bin/apxs LDFLAGS=-ldl)

	set(Package_source_setup
		URL http://mirror.nohup.it/apache/subversion/subversion-1.7.4.tar.gz 
		URL_MD5 15fa1ae5bcacade676ae3123043e6eaf
		PATCH_COMMAND ${CMAKE_COMMAND} -P ${Package_Source_Stamp_Dir}/patch.cmake
	)	

	PackageUnixConfigureAdd()
	
endif()



