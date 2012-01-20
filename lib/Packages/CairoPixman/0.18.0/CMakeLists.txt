#from http://cairographics.org
#this imports variables here
PackageSetup()

if(WIN32)
	message(FATAL_ERROR "package ${PACKAGE} not currently available for windows")
else()
	#configure based install 
	#set(Package_PkgConfig ON)
	PackageUnixConfigureSimpleAdd(
		http://cairographics.org/releases/pixman-0.18.0.tar.gz
	)
endif()

