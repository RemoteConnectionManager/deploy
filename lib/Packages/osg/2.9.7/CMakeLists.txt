#this imports variables here
PackageSetup()

#these are the patches to apply (order important???)
PackageWriteMultiPatchFile(tmp     
	module_override.diff
)
file(WRITE ${Package_Source_Stamp_Dir}/patch.cmake ${tmp})



ExternalProject_Add(
	${PACKAGE}
	${Package_std_dirs}
	DEPENDS zlib png jpeg freetype curl 
	URL http://www.openscenegraph.org/downloads/developer_releases/OpenSceneGraph-2.9.7.zip
	PATCH_COMMAND ${CMAKE_COMMAND} -P ${Package_Source_Stamp_Dir}/patch.cmake
	CMAKE_COMMAND ${CMAKE_COMMAND}
	CMAKE_ARGS 
		${Package_std_cmake_args}
)



