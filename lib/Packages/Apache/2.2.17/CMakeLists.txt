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
		#${Package_std_dirs}
		SOURCE_DIR ${EXTERNAL_ASSEMBLY_BASE_BUILD}/${PACKAGE}/build
		DOWNLOAD_DIR ${EXTERNAL_ASSEMBLY_BASE_SOURCE}/${PACKAGE}/${VERSION}/download
		INSTALL_DIR ${EXTERNAL_ASSEMBLY_COMMON_PREFIX}
		URL http://mirror.nohup.it/apache//httpd/httpd-2.2.17.tar.gz
		URL_MD5 66d8e107f85acc039fd5e624e85728a9
		CONFIGURE_COMMAND <SOURCE_DIR>/configure --srcdir=<SOURCE_DIR> --prefix=<INSTALL_DIR> --enable-dav --enable-dav-fs --enable-dav-lock --enable-ssl --enable-so --enable-rewrite --enable-deflate --enable-mime-magic
		BUILD_IN_SOURCE 1

	)
	
endif()



