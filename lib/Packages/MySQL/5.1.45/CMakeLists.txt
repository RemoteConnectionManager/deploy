#from http://dev.mysql.com/
#http://dev.mysql.com/doc/refman/5.1/en/getting-mysql.html
#http://dev.mysql.com/doc/mysql-sourcebuild-excerpt/5.1/en/configure-options.html

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
		URL http://dev.mysql.com/get/Downloads/MySQL-5.1/mysql-5.1.45.tar.gz/from/http://it.mysql.contactlab.it/
		CONFIGURE_COMMAND <SOURCE_DIR>/configure --srcdir=<SOURCE_DIR> --prefix=<INSTALL_DIR> 
	)
	
endif()




