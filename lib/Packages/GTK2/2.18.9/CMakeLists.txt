#from http://www.gtk.org/
#this imports variables here
PackageSetup()

if(WIN32)
	message(FATAL_ERROR "package ${PACKAGE} not currently available for windows")
else()
	#configure based install 
	set(Package_PkgConfig ON)
	set(Package_source_setup
		URL http://ftp.gnome.org/pub/gnome/sources/gtk+/2.18/gtk+-2.18.9.tar.gz
		URL_MD5 7afcf0beefbbea7f84f034955eaac621
	)

	PackageUnixConfigureAdd()
endif()

