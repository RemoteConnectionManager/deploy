#from http://www.apache.org/dist/xerces/c/3/
#this imports variables here
PackageSetup()

if(WIN32)
	message(FATAL_ERROR "package ${PACKAGE} not currently available for windows")
else()
	#set(Package_configure_flags --enable-xlib-xrender=no)
	set(Package_source_setup
		URL http://www.apache.org/dist/xerces/c/3/sources/xerces-c-3.1.1.tar.gz
		URL_MD5 6a8ec45d83c8cfb1584c5a5345cb51ae
	)

	PackageUnixConfigureAdd()
endif()

