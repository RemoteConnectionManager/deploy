#from http://www.dlitz.net/software/pycrypto/
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
		URL http://ftp.dlitz.net/pub/dlitz/crypto/pycrypto/pycrypto-2.1.0.tar.gz
#SHA256		253e1c22ea0249f0429df4f7e2eb973b119c83b146c0f421298f5e8e6822d8a2
		CONFIGURE_COMMAND ""
		INSTALL_COMMAND ""
		BUILD_COMMAND ""
	)
	
endif()



