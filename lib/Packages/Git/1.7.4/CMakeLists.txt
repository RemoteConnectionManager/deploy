#from https://git.wiki.kernel.org/index.php/Installation
#this imports variables here
PackageSetup()

if(WIN32)
	message(FATAL_ERROR "package ${PACKAGE} not currently available for windows")
else()
	#configure based install 
	set(Package_PkgConfig ON)
	set(Package_InSource ON)
	set(Package_source_setup
		URL http://www.kernel.org/pub/software/scm/git/git-1.7.4.tar.gz
		URL_MD5 52fe5ea90ffd9935e8982264b5417675
	)

	PackageUnixConfigureAdd()
#	PackageUnixConfigureSimpleAdd(
#		http://cairographics.org/releases/cairo-1.8.10.tar.gz
#	)
endif()

