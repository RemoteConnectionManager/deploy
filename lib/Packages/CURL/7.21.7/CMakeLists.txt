#this imports variables here
PackageSetup()

if(BUILD_SHARED_LIBS)
	set(tmp OFF)
else()
	set(tmp ON)
endif()
option(${PACKAGE}_static "build  ${PACKAGE} static" ${tmp})

FIND_PACKAGE(Ldap)
if(LDAP_FOUND)
	set(tmp OFF)
else()
	set(tmp ON)
endif()
option(${PACKAGE}_disable_ldap "build  ${PACKAGE} without ldap" ${tmp})

FIND_PACKAGE(OpenSSL)
if(OPENSSL_FOUND)
	set(tmp OFF)
else()
	set(tmp ON)
endif()
option(${PACKAGE}_disable_openssl "build  ${PACKAGE} without ssl" ${tmp})

#these are the patches to apply (order important!!!)
PackageWriteMultiPatchFile(tmp 
	static_install.diff
	override_modules.diff
)

file(WRITE ${Package_Source_Stamp_Dir}/patch.cmake ${tmp})


set(Package_source_setup
	URL http://curl.haxx.se/download/curl-7.21.7.tar.gz
	URL_MD5 3bbdab8bf540d73d10d2a82d964bc20a
	PATCH_COMMAND ${CMAKE_COMMAND} -P ${Package_Source_Stamp_Dir}/patch.cmake
	UPDATE_COMMAND ""
)


if(LDAP_FOUND)
	set(_disable_ldap_flag "")
else()
	set(_disable_ldap_flag "-DCURL_DISABLE_LDAP:BOOL=ON")
endif()  



message("WARNING!!!!! forcing OPENSSL disabling   ")
set(_disable_use_openssl "-DCMAKE_USE_OPENSSL:BOOL=OFF")

	set(Package_specific_cmake_args ${Package_specific_cmake_args} -DCURL_STATICLIB:BOOL=${PACKAGE}_static)
	if(${PACKAGE}_disable_ldap)
		set(Package_specific_cmake_args ${Package_specific_cmake_args} -DCURL_DISABLE_LDAP:BOOL=ON)
	endif()
	if(${PACKAGE}_disable_openssl)
		set(Package_specific_cmake_args ${Package_specific_cmake_args} -DCURL_DISABLE_LDAP:BOOL=ON)
	endif()
PackageCmakeAdd()



