#it defines common setup
#include(PackageSetup)

#this imports variables here
PackageSetup()

#these are the patches to apply (order important???)
PackageWriteMultiPatchFile(tmp     
	jerror_missing_stdlib_h.diff
    jpeg-7_cmp.diff
    win32_dll_support.diff
)

file(WRITE ${Package_Source_Stamp_Dir}/patch.cmake ${tmp})

ExternalProject_Add(
	${PACKAGE}-GetSource
	SOURCE_DIR ${Package_Source_Dir}
	STAMP_DIR ${Package_Source_Stamp_Dir}
	URL http://www.ijg.org/files/jpegsrc.v7.tar.gz
	URL_MD5 382ef33b339c299b56baf1296cda9785
	PATCH_COMMAND ${CMAKE_COMMAND} -P ${Package_Source_Stamp_Dir}/patch.cmake
	UPDATE_COMMAND ""
	CONFIGURE_COMMAND ""
	BUILD_COMMAND ""
	INSTALL_COMMAND ""
)

if(Package_current_dependencies_effective_line)
	set( Package_current_dependencies_effective_line ${Package_current_dependencies_effective_line} ${PACKAGE}-GetSource)
else()
	set(Package_current_dependencies_effective_line DEPENDS ${PACKAGE}-GetSource)
endif()

ExternalProject_Add(
	${PACKAGE}
	${Package_std_dirs}
	DOWNLOAD_COMMAND ""	
	CMAKE_GENERATOR ${CMAKE_GENERATOR}
	CMAKE_ARGS 
		${Package_std_cmake_args}
	${Package_current_dependencies_effective_line} 
	STEP_TARGETS configure build
)

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