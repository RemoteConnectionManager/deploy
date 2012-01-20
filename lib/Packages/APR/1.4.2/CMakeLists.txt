#from http://apr.apache.org/compiling_unix.html
#this imports variables here
PackageSetup()

if(WIN32)
	message(FATAL_ERROR "package ${PACKAGE} not currently available for windows")
else()
	#configure based install 
	set(Package_PkgConfig ON)
	set(Package_source_setup
		URL http://it.apache.contactlab.it//apr/apr-1.4.2.tar.gz
		URL_MD5 fc80cb54f158c2674f9eeb47a1f672cd
	)

	PackageUnixConfigureAdd()
endif()

