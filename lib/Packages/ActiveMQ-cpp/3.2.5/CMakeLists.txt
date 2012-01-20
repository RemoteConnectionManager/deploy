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
		SVN_REPOSITORY https://svn.apache.org/repos/asf/activemq/activemq-cpp/tags/activemq-cpp-3.2.5/activemq-cpp/
		UPDATE_COMMAND ""
#		URL http://it.apache.contactlab.it//activemq/activemq-cpp/source/activemq-cpp-library-3.2.5-src.tar.gz
#		URL_MD5 cfce3b8dad5a178735b0fd466b6aa80c
	)

	PackageUnixConfigureAdd()
endif()

