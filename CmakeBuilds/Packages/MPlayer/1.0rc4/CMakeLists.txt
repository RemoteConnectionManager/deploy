#from http://www.mplayerhq.hu/MPlayer/releases/
#this imports variables here
PackageSetup()

if(WIN32)
	message(FATAL_ERROR "package ${PACKAGE} not currently available for windows")
else()
	#configure based install 
	set(Package_PkgConfig ON)

#we use incource build as seems the --srcdir is not working, probably this package use --source_path instead
	set(Package_InSource ON) 
	set(Package_source_setup
		URL http://www.mplayerhq.hu/MPlayer/releases/MPlayer-1.0rc4.tar.gz
		URL_MD5 f3abf9b59d0ac4fb2b63bc6bc33b8d02
	)

	PackageUnixConfigureAdd()
endif()

