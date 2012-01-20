#from http://library.gnome.org/devel/atk/
#this imports variables here
PackageSetup()

if(WIN32)
	message(FATAL_ERROR "package ${PACKAGE} not currently available for windows")
else()
	#configure based install 
	set(Package_PkgConfig ON)
	PackageUnixConfigureSimpleAdd(
		http://ftp.gnome.org/pub/gnome/sources/atk/1.30/atk-1.30.0.tar.gz
	)
endif()

