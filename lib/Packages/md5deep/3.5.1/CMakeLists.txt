#from http://md5deep.sourceforge.net/
#this imports variables here
PackageSetup()

if(WIN32)
	#### here we download the binary package, ase md5deep does not currently support building under windows..... sic
	
	ExternalProject_Add(
		${PACKAGE}
		#WARNING!!!! this way  zip file directly expand into install/bin dir == source dir
		DOWNLOAD_DIR ${EXTERNAL_ASSEMBLY_BASE_SOURCE}/${PACKAGE}/${VERSION}/win32_bin_download
		SOURCE_DIR ${EXTERNAL_ASSEMBLY_COMMON_PREFIX}/bin
		#SHA256 8be48ae77fde088747f97e626bd81918cde9f7e5af3b8247a30e8c7def11b153
		URL http://switch.dl.sourceforge.net/project/md5deep/md5deep/md5deep-3.5.1/md5deep-3.5.1.zip
	)
	#### add install step here (copy????)
else()
	#configure based install like ./configure --prefix=/tmp/md5deep
	ExternalProject_Add(
		${PACKAGE}
		${Package_std_binary_dirs}
		#SHA256 a6a29f9892fa3a4a48bee0da341fd5dad5cdcdc2aecc521b28cf0b652bb3c415 
		URL http://switch.dl.sourceforge.net/project/md5deep/md5deep/md5deep-3.5.1/md5deep-3.5.1.tar.gz
		DOWNLOAD_DIR ${EXTERNAL_ASSEMBLY_BASE_SOURCE}/${PACKAGE}/${VERSION}/download
		SOURCE_DIR ${EXTERNAL_ASSEMBLY_BASE_BUILD}/${PACKAGE}/build
		BUILD_IN_SOURCE 1
		CONFIGURE_COMMAND <SOURCE_DIR>/configure --prefix=<INSTALL_DIR>
	)
endif()



#get_filename_component(Package_Dir ${CMAKE_CURRENT_LIST_FILE} PATH)
#message("processing file-->${Package_Dir} parent ${CMAKE_PARENT_LIST_FILE}")
#set(jpeg_patches
#    jerror_missing_stdlib_h.diff
#    jpeg-7_cmp.diff
#    win32_dll_support.diff
#)
#
#
#message("Patch line-->${PATCH_COMMAND_LINE}<---")
#
#ExternalProject_Add(
#jpeg-v7
#URL http://www.ijg.org/files/jpegsrc.v7.tar.gz
#PATCH_COMMAND ${PATCH_COMMAND_LINE} 
#BUILD_IN_SOURCE 0
#INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
#CMAKE_COMMAND ${CMAKE_COMMAND}
#CMAKE_ARGS 
#-DCMAKE_DEBUG_POSTFIX:STRING=D
#-DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
#-DCMAKE_PREFIX_PATH:PATH=<INSTALL_DIR>
#)
#
#foreach(p ${jpeg_patches} )
#	if(WIN32)
#		set(PATCH_COMMAND_LINE ${PATCH_PROGRAM} -p1 --binary -i ${Package_Dir}/Patch/${p})
#	else()
#		set(PATCH_COMMAND_LINE ${PATCH_PROGRAM} -p1 -i ${Package_Dir}/Patch/${p})
#	endif()
#	ExternalProject_Add_Step(
#		jpeg-v7	${p}	
#		COMMAND ${PATCH_COMMAND_LINE}
#		DEPENDEES download
#		DEPENDERS configure
#		WORKING_DIRECTORY <SOURCE_DIR>
#	)
#endforeach(p)
#