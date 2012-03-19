#from http://sourceforge.net/projects/expat/
#this imports variables here
PackageSetup()

if(WIN32)
	message(FATAL_ERROR "package ${PACKAGE} not currently available for windows")
else()
	#configure based install 
	set(Package_PkgConfig ON)
	PackageUnixConfigureSimpleAdd(
		http://puzzle.dl.sourceforge.net/project/expat/expat/2.0.1/expat-2.0.1.tar.gz
	)
endif()

