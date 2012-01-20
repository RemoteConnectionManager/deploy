#this imports variables here
#override default as we force osg shared build
set(EXTERNAL_ASSEMBLY_BUILD_SHARED ON)
PackageSetup()

#these are the patches to apply (order important???)
#to obtain successive patches:
#modify
#copy the mod to

#diff -Nur src_orig src > ..\..\..\Packages\osg\2.9.7\Patch\OpenThreads_versions.diff

#PackageWriteMultiPatchFile(tmp     
#	module_override.diff
#)
#file(WRITE ${Package_Source_Stamp_Dir}/patch.cmake ${tmp})



ExternalProject_Add(
	${PACKAGE}
	${Package_std_dirs}
	URL http://download.github.com/gwaldron-osgearth-osgearth_1.4_T2010-08-27-0-gd773498.tar.gz
#	PATCH_COMMAND ${CMAKE_COMMAND} -P ${Package_Source_Stamp_Dir}/patch.cmake
	CMAKE_COMMAND ${CMAKE_COMMAND}
	CMAKE_ARGS 
		${Package_std_cmake_args}
#		-DBUILD_OSG_EXAMPLES:BOOL=ON
	${Package_current_dependencies_effective_line}
)



