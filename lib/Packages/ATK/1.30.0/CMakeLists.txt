#from http://library.gnome.org/devel/atk/
#this imports variables here
PackageSetup()

if(WIN32)
	message(FATAL_ERROR "package ${PACKAGE} not currently available for windows")
else()
	#configure based install 
	set(Package_PkgConfig ON)
	set(Package_source_setup
		URL http://ftp.gnome.org/pub/gnome/sources/atk/1.30/atk-1.30.0.tar.gz
		URL_MD5 d546d814b3ddfd10659545fb3c1168fc
	)

	PackageUnixConfigureAdd()
# 	PackageUnixConfigureSimpleAdd(
# 		http://ftp.gnome.org/pub/gnome/sources/atk/1.30/atk-1.30.0.tar.gz
# 	)
endif()

