#from http://apr.apache.org/compiling_unix.html
#this imports variables here
PackageSetup()

if(WIN32)
	message(FATAL_ERROR "package ${PACKAGE} not currently available for windows")
else()
	#configure based install 
	set(Package_PkgConfig ON)
	set(Package_source_setup
		URL http://apache.fastbull.org//apr/apr-1.4.6.tar.gz
		URL_MD5 76cc4457fbb71eefdafa27dba8f511fb
	)

	PackageUnixConfigureAdd()
endif()

