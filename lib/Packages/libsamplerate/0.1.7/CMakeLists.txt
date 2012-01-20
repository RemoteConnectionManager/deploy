#from http://www.mega-nerd.com/SRC/download.html
#this imports variables here
PackageSetup()

if(WIN32)
	message(FATAL_ERROR "package ${PACKAGE} not currently available for windows")
else()
	#configure based install 
#	set(Package_PkgConfig ON)
	PackageUnixConfigureSimpleAdd(
		http://www.mega-nerd.com/SRC/libsamplerate-0.1.7.tar.gz
	)
endif()

