#from http://activemq.apache.org/cms/index.html
#this imports variables here
PackageSetup()

if(WIN32)
	message(FATAL_ERROR "package ${PACKAGE} not currently available for windows")
else()
	#configure based install 
	set(Package_PkgConfig ON)
	set(Package_configure_flags --with-apr=<INSTALL_DIR>)
	set(Package_source_setup
		URL http://it.apache.contactlab.it/activemq/activemq-cpp/source/activemq-cpp-library-3.3.0-src.tar.gz
		URL_MD5 78142c4a90520071cb7c7f14e192fa12
	)

	PackageUnixConfigureAdd()
endif()

