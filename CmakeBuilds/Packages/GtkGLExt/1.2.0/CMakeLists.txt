#from http://projects.gnome.org/gtkglext/
#this imports variables here
PackageSetup()

if(WIN32)
	message(FATAL_ERROR "package ${PACKAGE} not currently available for windows")
else()
	#configure based install 
	set(Package_PkgConfig ON)
	set(Package_source_setup
		URL http://downloads.sourceforge.net/project/gtkglext/gtkglext/1.2.0/gtkglext-1.2.0.tar.gz
		URL_MD5 5c3240bfc1b21becd33ce35c5abe6f8d
	)

	PackageUnixConfigureAdd()
# 	PackageUnixConfigureSimpleAdd(
# 
# 		http://mesh.dl.sourceforge.net/project/gtkglext/gtkglext/1.2.0/gtkglext-1.2.0.tar.gz
# 
# 	)
endif()

