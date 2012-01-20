#from http://mcrypt.sourceforge.net/
#this imports variables here
PackageSetup()

if(WIN32)
	message(FATAL_ERROR "package ${PACKAGE} not currently available for windows")
else()
	#configure based install 

	set(Package_InSource ON)
	set(Package_source_setup
		URL http://garr.dl.sourceforge.net/project/mcrypt/Libmcrypt/2.5.8/libmcrypt-2.5.8.tar.gz
		URL_MD5 0821830d930a86a5c69110837c55b7da
	)
	PackageUnixConfigureAdd()
endif()

