#from http://mcrypt.sourceforge.net/
#this imports variables here
PackageSetup()

if(WIN32)
	message(FATAL_ERROR "package ${PACKAGE} not currently available for windows")
else()
	#configure based install 

	set(Package_InSource ON)
	PackageUnixConfigureSimpleAdd(
		http://sourceforge.net/projects/mcrypt/files/Libmcrypt/2.5.8/libmcrypt-2.5.8.tar.gz/download
	)
endif()

