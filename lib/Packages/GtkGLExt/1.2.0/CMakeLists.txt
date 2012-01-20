#from http://cairographics.org
#this imports variables here
PackageSetup()

if(WIN32)
	message(FATAL_ERROR "package ${PACKAGE} not currently available for windows")
else()
	#configure based install 
	set(Package_PkgConfig ON)
	PackageUnixConfigureSimpleAdd(
		http://sourceforge.net/projects/gtkglext/files/gtkglext/1.2.0/gtkglext-1.2.0.tar.gz/download
	)
endif()

