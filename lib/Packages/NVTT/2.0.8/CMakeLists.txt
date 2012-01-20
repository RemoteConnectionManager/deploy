####################################################################
#These options seems to be mutually exclusive, 
#so depending on the assembly setup decide weather configure static or shared
####################################################################


#this imports variables here
PackageSetup()

#these are the patches to apply (order important???)
PackageWriteMultiPatchFile(tmp     
	p1.diff
)

file(WRITE ${Package_Source_Stamp_Dir}/patch.cmake ${tmp})

#ExternalProject_Add(
#	"${PACKAGE}_src"
#	${Package_std_dirs}
#	URL http://nvidia-texture-tools.googlecode.com/files/nvidia-texture-tools-2.0.8-1.tar.gz
#	URL_MD5 7449c95ca1583b512561c83c5a5f401c
#	PATCH_COMMAND ${CMAKE_COMMAND} -P ${Package_Source_Stamp_Dir}/patch.cmake
#	INSTALL_COMMAND ""
#	CONFIGURE_COMMAND ""
#	BUILD_COMMAND ""
#)

#message("in NVTT Package_std_dirs -->${Package_std_dirs}<--")
ExternalProject_Add(
	${PACKAGE}
#        DEPENDS ${PACKAGE}_src
	${Package_std_dirs}
	URL http://nvidia-texture-tools.googlecode.com/files/nvidia-texture-tools-2.0.8-1.tar.gz
	URL_MD5 7449c95ca1583b512561c83c5a5f401c
	#PATCH_COMMAND ${CMAKE_COMMAND} -P ${Package_Source_Stamp_Dir}/patch.cmake
	PATCH_COMMAND ${PATCH_PROGRAM} -p0 --binary < ${Package_Dir}/Patch/p1.patch
	${Package_current_dependencies_effective_line} 


	CMAKE_COMMAND ${CMAKE_COMMAND}
	CMAKE_ARGS 
		${Package_std_cmake_args}
		${Package_add_cmake_args}
)





