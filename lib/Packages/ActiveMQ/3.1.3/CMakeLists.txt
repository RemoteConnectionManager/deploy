#from http://activemq.apache.org/cms/index.html
#this imports variables here
PackageSetup()

if(WIN32)
	message(FATAL_ERROR "package ${PACKAGE} not currently available for windows")
else()
	#configure based install 
	set(Package_PkgConfig ON)
	#set(Package_configure_flags --enable-gtk=no)
	set(Package_source_setup
		SVN_REPOSITORY https://svn.apache.org/repos/asf/activemq/activemq-cpp/tags/activemq-cpp-3.1.3/
		UPDATE_COMMAND ""
	)

	PackageUnixConfigureAdd()
#	PackageUnixConfigureSimpleAdd(
#		http://cairographics.org/releases/pixman-0.18.0.tar.gz
#	)
endif()

