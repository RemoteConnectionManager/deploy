#from http://www.php.net/downloads.php
#this imports variables here
PackageSetup()

if(WIN32)
	####  windows..... not done yet
	message(FATAL_ERROR "package ${PACKAGE} not currently available for windows")
else()
	set(Package_configure_flags --with-apxs2=<INSTALL_DIR>/bin/apxs --with-mysql=<INSTALL_DIR> --with-pdo-mysql=<INSTALL_DIR> --disable-cgi --with-zlib_dir=<INSTALL_DIR> --with-gettext --with-mcrypt=<INSTALL_DIR> --with-gd --with-jpeg-dir=<INSTALL_DIR> --with-png-dir=<INSTALL_DIR> --with-freetype-dir=<INSTALL_DIR> --enable-zip --enable-mbstring --with-xsl=<INSTALL_DIR> --with-libxml-dir=<INSTALL_DIR>  )
# 	--with-curl=<INSTALL_DIR>
	set(Package_source_setup
		URL http://www.php.net/distributions/php-5.4.0.tar.gz
		URL_MD5 46b72e274c6ea7e775245ffdb81c9ce5
	)
	PackageUnixConfigureAdd()
	
endif()



