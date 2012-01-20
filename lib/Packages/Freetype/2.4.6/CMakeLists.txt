#this imports variables here
PackageSetup()

# if(BUILD_SHARED_LIBS)
	# set(tmp OFF)
# else()
	# set(tmp ON)
# endif()
# option(${PACKAGE}_static "build  ${PACKAGE} static" ${tmp})



#these are the patches to apply (order important!!!)
PackageWriteMultiPatchFile(tmp 
	freetype-2.3.11_cmp.diff
)

file(WRITE ${Package_Source_Stamp_Dir}/patch.cmake ${tmp})


set(Package_source_setup
	URL http://mirror.lihnidos.org/GNU/savannah/freetype/freetype-2.4.6.tar.gz
	URL_MD5 1dc4af24a86e2f78a49ac6b520a81ec5
	PATCH_COMMAND ${CMAKE_COMMAND} -P ${Package_Source_Stamp_Dir}/patch.cmake
	UPDATE_COMMAND ""
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



# set(_disable_use_openssl "-DCMAKE_USE_OPENSSL:BOOL=OFF")

	# set(Package_specific_cmake_args ${Package_specific_cmake_args} -DCURL_STATICLIB:BOOL=${PACKAGE}_static)
	# if(${PACKAGE}_disable_ldap)
		# set(Package_specific_cmake_args ${Package_specific_cmake_args} -DCURL_DISABLE_LDAP:BOOL=ON)
	# endif()
	# if(${PACKAGE}_disable_openssl)
		# set(Package_specific_cmake_args ${Package_specific_cmake_args} -DCURL_DISABLE_LDAP:BOOL=ON)
	# endif()
PackageCmakeAdd()



