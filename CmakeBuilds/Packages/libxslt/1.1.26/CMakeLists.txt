#from ftp://xmlsoft.org/libxslt/
#this imports variables here
#message("@@@@@@@prima di PackageSetup package ${PACKAGE}")
PackageSetup()

if(WIN32)
	message(FATAL_ERROR "package ${PACKAGE} not currently available for windows")
else()
	#configure based install 
	set(Package_PkgConfig ON)
	set(Package_source_setup
		URL ftp://xmlsoft.org/libxslt/libxslt-1.1.26.tar.gz
		URL_MD5 e61d0364a30146aaa3001296f853b2b9
	)

	PackageUnixConfigureAdd()
endif()




















