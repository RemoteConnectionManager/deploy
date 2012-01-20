#from http://www.php.net/downloads.php
#this imports variables here
PackageSetup()

if(WIN32)
	####  windows..... not done yet
	message(FATAL_ERROR "package ${PACKAGE} not currently available for windows")
else()
	#configure based install like ./configure --prefix=/$HOME/apache
	ExternalProject_Add(
		${PACKAGE}
		${Package_std_dirs}
		URL http://it.php.net/get/php-5.3.5.tar.gz/from/www.php.net/mirror
		URL_MD5 fb727a3ac72bf0ce37e1a20468a7bb81
		CONFIGURE_COMMAND <SOURCE_DIR>/configure --srcdir=<SOURCE_DIR> --prefix=<INSTALL_DIR> --with-apxs2=<INSTALL_DIR>/bin/apxs --with-mysql=<INSTALL_DIR> --with-pdo-mysql=<INSTALL_DIR> --disable-cgi --with-zlib --with-gettext --with-mcrypt=<INSTALL_DIR> --with-gd --with-jpeg-dir=<INSTALL_DIR> --with-png-dir=<INSTALL_DIR>
	)
	
endif()



