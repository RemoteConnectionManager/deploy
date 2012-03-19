#from http://apr.apache.org/compiling_unix.html
#this imports variables here
PackageSetup()

if(WIN32)
	message(FATAL_ERROR "package ${PACKAGE} not currently available for windows")
else()
	#configure based install 
	set(Package_PkgConfig ON)
	set(Package_configure_flags --with-apr=<INSTALL_DIR>  --with-expat=<INSTALL_DIR>)
	set(Package_source_setup
		URL http://mirror.nohup.it/apache//apr/apr-util-1.3.10.tar.gz
		URL_MD5 82acd25cf3df8c72eba44eaee8b80c19
	)

	PackageUnixConfigureAdd()
endif()

