#from http://gnuwin32.sourceforge.net/packages/unzip.htm
#this imports variables here
PackageSetup()

if(WIN32)
	#### here we download the binary package, ase md5deep does not currently support building under windows..... sic
	
	ExternalProject_Add(
		${PACKAGE}
		${Package_std_dirs}
		#MD5 925a5d4d9b4a63ff1a473cc4d47f2f05
		URL http://switch.dl.sourceforge.net/project/gnuwin32/unzip/5.51-1/unzip-5.51-1-bin.zip
	)
	#### add install step here (copy????)
else()
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