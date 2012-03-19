#from http://md5deep.sourceforge.net/
#this imports variables here
PackageSetup()

if(WIN32)
	#### here we download the binary package, ase md5deep does not currently support building under windows..... sic
	
#	ExternalProject_Add(
#		${PACKAGE}
#		#WARNING!!!! this way  zip file directly expand into install/bin dir == source dir
#		DOWNLOAD_DIR ${EXTERNAL_ASSEMBLY_BASE_SOURCE}/${PACKAGE}/${VERSION}/win32_bin_download
#		SOURCE_DIR ${EXTERNAL_ASSEMBLY_COMMON_PREFIX}/bin
#		#SHA256 8be48ae77fde088747f97e626bd81918cde9f7e5af3b8247a30e8c7def11b153
#		URL http://switch.dl.sourceforge.net/project/md5deep/md5deep/md5deep-3.5.1/md5deep-3.5.1.zip
#	)
	#### add install step here (copy????)
	PackageWindowsBinarySimpleAdd(http://switch.dl.sourceforge.net/project/md5deep/md5deep/md5deep-3.5.1/md5deep-3.5.1.zip)
else()
	#configure based install like ./configure --prefix=/tmp/md5deep
	
	#SHA256 a6a29f9892fa3a4a48bee0da341fd5dad5cdcdc2aecc521b28cf0b652bb3c415 
	PackageUnixConfigureSimpleAdd(http://switch.dl.sourceforge.net/project/md5deep/md5deep/md5deep-3.5.1/md5deep-3.5.1.tar.gz)
endif()



