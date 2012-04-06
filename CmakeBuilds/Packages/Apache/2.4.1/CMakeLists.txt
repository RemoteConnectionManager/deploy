#from http://httpd.apache.org/docs/2.2/install.html
#this imports variables here
PackageSetup()

if(WIN32)
	#### here we download the binary package, ase md5deep does not currently support building under windows..... sic
	message(FATAL_ERROR "package ${PACKAGE} not currently available for windows")
else()

	set(Package_configure_flags --enable-dav --enable-dav-fs --enable-dav-lock --enable-ssl --enable-so --enable-rewrite --enable-deflate --enable-mime-magic --enable-proxy --enable-proxy-ajp --enable-proxy-http --with-apr=<INSTALL_DIR> --with-apr-util=<INSTALL_DIR> )
	set(Package_source_setup
		URL http://mirror.nohup.it/apache/httpd/httpd-2.4.1.tar.gz
		URL_MD5 4366afbea8149ca125af01fd59a2f8a2
	)
#	set(Package_InSource ON) #it seems that Apache is not able to build out of source....due to not finding expat
	PackageUnixConfigureAdd()
	
endif()



