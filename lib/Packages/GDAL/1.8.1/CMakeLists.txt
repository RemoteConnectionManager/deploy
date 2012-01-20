#this imports variables here
PackageSetup()

if(WIN32)
	message(FATAL_ERROR "package ${PACKAGE} not currently available for windows")
else()
	#configure based install 
	set(Package_PkgConfig ON)
	set(Package_source_setup
		URL http://download.osgeo.org/gdal/gdal-1.8.1.tar.gz
		URL_MD5 b32269893afc9dc9eced45e74e4c6bb4
	)
	set(Package_InSource ON)	
	PackageUnixConfigureAdd()

endif()

