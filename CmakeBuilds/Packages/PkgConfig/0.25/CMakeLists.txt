#from http://www.freedesktop.org/wiki/Software/pkg-config
#this imports variables here
PackageSetup()

if(WIN32)
	message(FATAL_ERROR "package ${PACKAGE} not currently available for windows")
else()
	#configure based install 
#	set(Package_PkgConfig ON)
#	set(Package_configure_flags --enable-gtk=no)
	set(Package_source_setup
		URL http://pkgconfig.freedesktop.org/releases/pkg-config-0.25.tar.gz
		URL_MD5 a3270bab3f4b69b7dc6dbdacbcae9745
	)

	PackageUnixConfigureAdd()
#	PackageUnixConfigureSimpleAdd(
#		http://cairographics.org/releases/pixman-0.18.0.tar.gz
#	)
endif()

