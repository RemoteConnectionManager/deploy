#from http://library.gnome.org/devel/glib/
#this imports variables here
PackageSetup()

if(WIN32)
	message(FATAL_ERROR "package ${PACKAGE} not currently available for windows")
else()
	#configure based install 
	set(Package_PkgConfig ON)
	set(Package_source_setup
		URL http://ftp.gnome.org/pub/gnome/sources/glib/2.22/glib-2.22.5.tar.gz
		URL_MD5 62ef6169c184344446679b32d7473601
	)

	PackageUnixConfigureAdd()

# 	PackageUnixConfigureSimpleAdd(
# 		http://ftp.gnome.org/pub/gnome/sources/glib/2.22/glib-2.22.5.tar.gz
# 	)
endif()

