#from http://library.gnome.org/devel/pango/
#this imports variables here
PackageSetup()

if(WIN32)
	message(FATAL_ERROR "package ${PACKAGE} not currently available for windows")
else()
	#configure based install 
	set(Package_PkgConfig ON)
	PackageUnixConfigureSimpleAdd(
		http://ftp.gnome.org/pub/gnome/sources/pango/1.26/pango-1.26.2.tar.gz
	)
endif()

