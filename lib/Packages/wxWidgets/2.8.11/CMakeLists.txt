#from http://www.wxwidgets.org/
#this imports variables here
PackageSetup()

if(WIN32)
	####  windows..... not done yet
	message(FATAL_ERROR "package ${PACKAGE} not currently available for windows")
else()
	#configure based install like ./configure --prefix=/$HOME/apache
	set(Package_PkgConfig ON)
	PackageUnixConfigureSimpleAdd(
		http://prdownloads.sourceforge.net/wxwindows/wxWidgets-2.8.11.tar.gz
	)

#	ExternalProject_Add(
#		${PACKAGE}
#		${Package_std_dirs}
#		URL http://prdownloads.sourceforge.net/wxwindows/wxWidgets-2.8.11.tar.gz
#		CONFIGURE_COMMAND <SOURCE_DIR>/configure --srcdir=<SOURCE_DIR> --prefix=<INSTALL_DIR> 
#		CONFIGURE_COMMAND <SOURCE_DIR>/configure --srcdir=<SOURCE_DIR> --prefix=<INSTALL_DIR> --with-apxs2=<INSTALL_DIR>/bin/apxs --with-mysql=<INSTALL_DIR> --disable-cgi --with-zlib --with-gettext --with-mcrypt=<INSTALL_DIR>
#	)
	
endif()



