#from http://www.ffmpeg.org/download.html
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
		URL http://www.ffmpeg.org/releases/ffmpeg-0.6.1.tar.gz
		URL_MD5 fd45cacbe1294554eb72a5c9a311866f
	)
	set(Package_configure_flags --enable-pic )
	PackageUnixConfigureAdd()
endif()

