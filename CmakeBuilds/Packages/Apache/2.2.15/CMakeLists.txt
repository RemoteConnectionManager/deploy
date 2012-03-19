#from http://httpd.apache.org/docs/2.2/install.html
#this imports variables here
PackageSetup()

if(WIN32)
	#### here we download the binary package, ase md5deep does not currently support building under windows..... sic
	message(FATAL_ERROR "package ${PACKAGE} not currently available for windows")
else()
	#configure based install like ./configure --prefix=/$HOME/apache
	ExternalProject_Add(
		${PACKAGE}
		${Package_std_dirs}
		#URL http://apache.panu.it/httpd/httpd-2.2.15.tar.gz
		URL http://mirror.nohup.it/apache//httpd/httpd-2.2.15.tar.gz
		CONFIGURE_COMMAND <SOURCE_DIR>/configure --srcdir=<SOURCE_DIR> --prefix=<INSTALL_DIR> --enable-dav --enable-dav-fs --enable-dav-lock --enable-ssl --enable-so --enable-rewrite --enable-deflate --enable-mime-magic
	)
	
endif()



