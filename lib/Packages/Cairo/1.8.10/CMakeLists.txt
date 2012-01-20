#from http://cairographics.org
#this imports variables here
PackageSetup()

if(WIN32)
	message(FATAL_ERROR "package ${PACKAGE} not currently available for windows")
else()
	#configure based install 
	set(Package_PkgConfig ON)
	set(Package_source_setup
		URL http://cairographics.org/releases/cairo-1.8.10.tar.gz
		URL_MD5 b60a82f405f9400bbfdcf850b1728d25
	)

	PackageUnixConfigureAdd()
#	PackageUnixConfigureSimpleAdd(
#		http://cairographics.org/releases/cairo-1.8.10.tar.gz
#	)
endif()

