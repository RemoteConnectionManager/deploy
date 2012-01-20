#from http://code.google.com/p/modwsgi/wiki/QuickInstallationGuide
#this imports variables here
PackageSetup()

if(WIN32)
	####  windows..... not done yet
	message(FATAL_ERROR "package ${PACKAGE} not currently available for windows")
else()
	set(Package_configure_flags --with-apxs=<INSTALL_DIR>/bin/apxs  )
	set(Package_InSource ON) #it seems that Apache is not able to build out of source....due to not finding expat

	set(Package_source_setup
		URL http://modwsgi.googlecode.com/files/mod_wsgi-3.3.tar.gz
		URL_MD5 6172bb2bbabcd0c25867c2bc06f99dbb
	)
	PackageUnixConfigureAdd()
	
endif()



