#this imports variables here
PackageSetup()

#these are the patches to apply (order important???)
PackageWriteMultiPatchFile(tmp     
	freetype-2.3.11_cmp.diff
)
file(WRITE ${Package_Source_Stamp_Dir}/patch.cmake ${tmp})

    set(CMP_ARCHIVE_OUTPUT_DIRECTORY lib)
    set(CMP_RUNTIME_OUTPUT_DIRECTORY bin)
    if(WIN32)
        set(CMP_LIBRARY_OUTPUT_DIRECTORY bin)
    else(WIN32)
        set(CMP_LIBRARY_OUTPUT_DIRECTORY lib)
    endif(WIN32)


ExternalProject_Add(
	${PACKAGE}
	${Package_std_dirs}
	URL http://download.savannah.gnu.org/releases/freetype/freetype-2.3.11.tar.gz
#	PATCH_COMMAND ${CMAKE_COMMAND} -P ${Package_Source_Stamp_Dir}/patch.cmake
	#CMAKE_COMMAND ${CMAKE_COMMAND}
	CMAKE_GENERATOR ${CMAKE_GENERATOR}
	CMAKE_ARGS 
		${Package_std_cmake_args}
		-DCMP_ARCHIVE_OUTPUT_DIRECTORY:PATH=${CMP_ARCHIVE_OUTPUT_DIRECTORY}
		-DCMP_RUNTIME_OUTPUT_DIRECTORY:PATH=${CMP_RUNTIME_OUTPUT_DIRECTORY}
		-DCMP_LIBRARY_OUTPUT_DIRECTORY:PATH=${CMP_LIBRARY_OUTPUT_DIRECTORY}
)

if(UNIX)
	PackageUnixPkgConfigInstall(
		  freetype238
		  freetype2
	)
endif()

#get_filename_component(Package_Dir ${CMAKE_CURRENT_LIST_FILE} PATH)
#message("processing file-->${Package_Dir} parent ${CMAKE_PARENT_LIST_FILE}")
#set(p freetype-2.3.8_cmp.diff)
#	if(WIN32)
#		set(PATCH_COMMAND_LINE ${PATCH_PROGRAM} -p1 --binary -i ${Package_Dir}/Patch/${p})
#	else()
#		set(PATCH_COMMAND_LINE ${PATCH_PROGRAM} -p1 -i ${Package_Dir}/Patch/${p})
#	endif()
#
#    set(CMP_ARCHIVE_OUTPUT_DIRECTORY lib)
#    set(CMP_RUNTIME_OUTPUT_DIRECTORY bin)
#    if(WIN32)
#        set(CMP_LIBRARY_OUTPUT_DIRECTORY bin)
#    else(WIN32)
#        set(CMP_LIBRARY_OUTPUT_DIRECTORY lib)
#    endif(WIN32)
#
#
#message("Patch line-->${PATCH_COMMAND_LINE}<---")
#
#ExternalProject_Add(
#freetype-2.3.8
#URL http://downloads.sourceforge.net/freetype/freetype-2.3.8.tar.gz
#PATCH_COMMAND ${PATCH_COMMAND_LINE} 
#BUILD_IN_SOURCE 0
#INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
#CMAKE_COMMAND ${CMAKE_COMMAND}
#CMAKE_ARGS 
#-DCMAKE_DEBUG_POSTFIX:STRING=D
#-DCMP_ARCHIVE_OUTPUT_DIRECTORY:PATH=${CMP_ARCHIVE_OUTPUT_DIRECTORY}
#-DCMP_RUNTIME_OUTPUT_DIRECTORY:PATH=${CMP_RUNTIME_OUTPUT_DIRECTORY}
#-DCMP_LIBRARY_OUTPUT_DIRECTORY:PATH=${CMP_LIBRARY_OUTPUT_DIRECTORY}
#-DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
#-DCMAKE_PREFIX_PATH:PATH=<INSTALL_DIR>
#)
#
#