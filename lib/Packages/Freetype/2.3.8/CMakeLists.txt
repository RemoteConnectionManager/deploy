#this imports variables here
PackageSetup()

set(Package_source_setup
	URL http://downloads.sourceforge.net/freetype/freetype-2.3.8.tar.gz
	URL_MD5 ebd7d255fd72b7f86c94501b80c50009
	PATCH_COMMAND ${CMAKE_COMMAND} -E copy_directory ${Package_Dir}/Patch <SOURCE_DIR>
)
set(CMP_ARCHIVE_OUTPUT_DIRECTORY lib)
set(CMP_RUNTIME_OUTPUT_DIRECTORY bin)
if(WIN32)
    set(CMP_LIBRARY_OUTPUT_DIRECTORY bin)
else(WIN32)
    set(CMP_LIBRARY_OUTPUT_DIRECTORY lib)
endif(WIN32)

set(Package_specific_cmake_args
		-DCMP_ARCHIVE_OUTPUT_DIRECTORY:PATH=${CMP_ARCHIVE_OUTPUT_DIRECTORY}
		-DCMP_RUNTIME_OUTPUT_DIRECTORY:PATH=${CMP_RUNTIME_OUTPUT_DIRECTORY}
		-DCMP_LIBRARY_OUTPUT_DIRECTORY:PATH=${CMP_LIBRARY_OUTPUT_DIRECTORY}
)

PackageCmakeAdd()

# #these are the patches to apply (order important???)
# PackageWriteMultiPatchFile(tmp     
# 	freetype-2.3.8_cmp.diff
# )
# file(WRITE ${Package_Source_Stamp_Dir}/patch.cmake ${tmp})
# 
#     set(CMP_ARCHIVE_OUTPUT_DIRECTORY lib)
#     set(CMP_RUNTIME_OUTPUT_DIRECTORY bin)
#     if(WIN32)
#         set(CMP_LIBRARY_OUTPUT_DIRECTORY bin)
#     else(WIN32)
#         set(CMP_LIBRARY_OUTPUT_DIRECTORY lib)
#     endif(WIN32)
# 
# 
# ExternalProject_Add(
# 	${PACKAGE}-GetSource
# 	SOURCE_DIR ${Package_Source_Dir}
# 	STAMP_DIR ${Package_Source_Stamp_Dir}
# 	URL http://downloads.sourceforge.net/freetype/freetype-2.3.8.tar.gz
# 	URL_MD5 ebd7d255fd72b7f86c94501b80c50009
# 	PATCH_COMMAND ${CMAKE_COMMAND} -P ${Package_Source_Stamp_Dir}/patch.cmake
# 	UPDATE_COMMAND ""
# 	CONFIGURE_COMMAND ""
# 	BUILD_COMMAND ""
# 	INSTALL_COMMAND ""
# )
# 
# if(Package_current_dependencies_effective_line)
# 	set( Package_current_dependencies_effective_line ${Package_current_dependencies_effective_line} ${PACKAGE}-GetSource)
# else()
# 	set(Package_current_dependencies_effective_line DEPENDS ${PACKAGE}-GetSource)
# endif()
# 
# 
# ExternalProject_Add(
# 	${PACKAGE}
# 	${Package_std_dirs}
# 	DOWNLOAD_COMMAND ""	
# 	#CMAKE_COMMAND ${CMAKE_COMMAND}
# 	CMAKE_GENERATOR ${CMAKE_GENERATOR}
# 	CMAKE_ARGS 
# 		${Package_std_cmake_args}
# 		-DCMP_ARCHIVE_OUTPUT_DIRECTORY:PATH=${CMP_ARCHIVE_OUTPUT_DIRECTORY}
# 		-DCMP_RUNTIME_OUTPUT_DIRECTORY:PATH=${CMP_RUNTIME_OUTPUT_DIRECTORY}
# 		-DCMP_LIBRARY_OUTPUT_DIRECTORY:PATH=${CMP_LIBRARY_OUTPUT_DIRECTORY}
# 	${Package_current_dependencies_effective_line} 
# 	STEP_TARGETS configure build
# )
# 
# # if(UNIX)
# # 	PackageUnixPkgConfigInstall(
# # 		  freetype238
# # 		  freetype2
# # 	)
# # endif()
# 
# #get_filename_component(Package_Dir ${CMAKE_CURRENT_LIST_FILE} PATH)
# #message("processing file-->${Package_Dir} parent ${CMAKE_PARENT_LIST_FILE}")
# #set(p freetype-2.3.8_cmp.diff)
# #	if(WIN32)
# #		set(PATCH_COMMAND_LINE ${PATCH_PROGRAM} -p1 --binary -i ${Package_Dir}/Patch/${p})
# #	else()
# #		set(PATCH_COMMAND_LINE ${PATCH_PROGRAM} -p1 -i ${Package_Dir}/Patch/${p})
# #	endif()
# #
# #    set(CMP_ARCHIVE_OUTPUT_DIRECTORY lib)
# #    set(CMP_RUNTIME_OUTPUT_DIRECTORY bin)
# #    if(WIN32)
# #        set(CMP_LIBRARY_OUTPUT_DIRECTORY bin)
# #    else(WIN32)
# #        set(CMP_LIBRARY_OUTPUT_DIRECTORY lib)
# #    endif(WIN32)
# #
# #
# #message("Patch line-->${PATCH_COMMAND_LINE}<---")
# #
# #ExternalProject_Add(
# #freetype-2.3.8
# #URL http://downloads.sourceforge.net/freetype/freetype-2.3.8.tar.gz
# #PATCH_COMMAND ${PATCH_COMMAND_LINE} 
# #BUILD_IN_SOURCE 0
# #INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
# #CMAKE_COMMAND ${CMAKE_COMMAND}
# #CMAKE_ARGS 
# #-DCMAKE_DEBUG_POSTFIX:STRING=D
# #-DCMP_ARCHIVE_OUTPUT_DIRECTORY:PATH=${CMP_ARCHIVE_OUTPUT_DIRECTORY}
# #-DCMP_RUNTIME_OUTPUT_DIRECTORY:PATH=${CMP_RUNTIME_OUTPUT_DIRECTORY}
# #-DCMP_LIBRARY_OUTPUT_DIRECTORY:PATH=${CMP_LIBRARY_OUTPUT_DIRECTORY}
# #-DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
# #-DCMAKE_PREFIX_PATH:PATH=<INSTALL_DIR>
# #)
# #
# #