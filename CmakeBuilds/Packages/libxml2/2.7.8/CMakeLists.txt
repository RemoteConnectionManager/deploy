#from ftp://xmlsoft.org/libxslt/
#this imports variables here
PackageSetup()

if(WIN32)
	message(FATAL_ERROR "package ${PACKAGE} not currently available for windows")
else()
	#configure based install 
	set(Package_PkgConfig ON)
	set(Package_source_setup
		URL ftp://xmlsoft.org/libxslt/libxml2-2.7.8.tar.gz
		URL_MD5 8127a65e8c3b08856093099b52599c86
	)

	PackageUnixConfigureAdd()
endif()

