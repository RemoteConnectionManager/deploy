#from http://library.gnome.org/devel/pango/
#this imports variables here
PackageSetup()

if(WIN32)
	message(FATAL_ERROR "package ${PACKAGE} not currently available for windows")
else()
	#configure based install 
	set(Package_PkgConfig ON)
	set(Package_source_setup
		URL http://ftp.gnome.org/pub/gnome/sources/pango/1.26/pango-1.26.2.tar.gz
		URL_MD5 a2ebe81d171abfa4913ea103ca25761a
	)

	PackageUnixConfigureAdd()
# 	PackageUnixConfigureSimpleAdd(
# 		http://ftp.gnome.org/pub/gnome/sources/pango/1.26/pango-1.26.2.tar.gz
# 	)
endif()

