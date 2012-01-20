#from http://library.gnome.org/devel/glib/
#this imports variables here
PackageSetup()

if(WIN32)
	message(FATAL_ERROR "package ${PACKAGE} not currently available for windows")
else()
	#configure based install 
	set(Package_PkgConfig ON)
	PackageUnixConfigureSimpleAdd(
		http://ftp.gnome.org/pub/gnome/sources/glib/2.22/glib-2.22.5.tar.gz
	)
endif()

