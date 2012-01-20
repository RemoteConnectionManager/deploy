#from http://cairographics.org
#this imports variables here
PackageSetup()

if(WIN32)
	message(FATAL_ERROR "package ${PACKAGE} not currently available for windows")
else()
	#configure based install 
	set(Package_PkgConfig ON)
	set(Package_configure_flags --enable-gtk=no)
	set(Package_source_setup
		URL http://cairographics.org/releases/pixman-0.18.0.tar.gz
		URL_MD5 a4fb870fc325be258089f1683642e976
	)

	PackageUnixConfigureAdd()
#	PackageUnixConfigureSimpleAdd(
#		http://cairographics.org/releases/pixman-0.18.0.tar.gz
#	)
endif()

