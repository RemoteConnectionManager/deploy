#from http://www.openexr.com
#this imports variables here
PackageSetup()

if(WIN32)
	message(FATAL_ERROR "package ${PACKAGE} not currently available for windows")
else()
	#configure based install 
	set(Package_PkgConfig ON)
	PackageUnixConfigureSimpleAdd(
		http://download.savannah.gnu.org/releases-noredirect/openexr/openexr-1.6.1.tar.gz
	)
endif()

