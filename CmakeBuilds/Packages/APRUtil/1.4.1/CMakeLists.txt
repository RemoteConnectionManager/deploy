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
		URL http://apache.fastbull.org//apr/apr-util-1.4.1.tar.gz
		URL_MD5 666a5d56098a9debf998510e304c8095
	)

	PackageUnixConfigureAdd()
endif()

