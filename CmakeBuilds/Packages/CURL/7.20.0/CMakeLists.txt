#this imports variables here
PackageSetup()


#these are the patches to apply (order important!!!)
PackageWriteMultiPatchFile(tmp     
	lib_install.diff
    override_modules.diff
	openssl.diff
	socklen_t.diff
)

file(WRITE ${Package_Source_Stamp_Dir}/patch.cmake ${tmp})


ExternalProject_Add(
	${PACKAGE}-GetSource
	SOURCE_DIR ${Package_Source_Dir}
	STAMP_DIR ${Package_Source_Stamp_Dir}
	URL http://curl.haxx.se/download/curl-7.20.0.tar.gz
	URL_MD5 ce04744b4ac753f851d34a6e5835410a
	PATCH_COMMAND ${CMAKE_COMMAND} -P ${Package_Source_Stamp_Dir}/patch.cmake
	UPDATE_COMMAND ""
	CONFIGURE_COMMAND ""
	BUILD_COMMAND ""
	INSTALL_COMMAND ""
)

if(BUILD_SHARED_LIBS)
    set(CURL_STATICLIB OFF)
else()
    set(CURL_STATICLIB ON)
endif()


FIND_PACKAGE(Ldap)
if(LDAP_FOUND)
	set(_disable_ldap_flag "")
else()
	set(_disable_ldap_flag "-DCURL_DISABLE_LDAP:BOOL=ON")
endif()  

message("WARNING!!!!! forcing OPENSSL disabling   ")
set(_disable_use_openssl "-DCMAKE_USE_OPENSSL:BOOL=OFF")


if(Package_current_dependencies_effective_line)
	set( Package_current_dependencies_effective_line ${Package_current_dependencies_effective_line} ${PACKAGE}-GetSource)
else()
	set(Package_current_dependencies_effective_line DEPENDS ${PACKAGE}-GetSource)
endif()


ExternalProject_Add(
	${PACKAGE}
	${Package_std_dirs}
	DOWNLOAD_COMMAND ""	
	CMAKE_COMMAND ${CMAKE_COMMAND}
	CMAKE_ARGS 
		${Package_std_cmake_args}
		-DCURL_STATICLIB:BOOL=${CURL_STATICLIB}
		#this is for disabling ldap that does break builds under kubuntu
		${_disable_ldap_flag}
		${_disable_use_openssl}
	${Package_current_dependencies_effective_line} 
	STEP_TARGETS configure build
)











#get_filename_component(Package_Dir ${CMAKE_CURRENT_LIST_FILE} PATH)
#message("processing file-->${Package_Dir} parent ${CMAKE_PARENT_LIST_FILE}")
#if(BUILD_SHARED_LIBS)
#    set(CURL_STATICLIB OFF)
#else()
#    set(CURL_STATICLIB ON)
#endif()
#ExternalProject_Add(
#curl-7.19.7
#DEPENDS zlib-1.2.3
#URL http://curl.haxx.se/download/curl-7.19.7.tar.gz
#PATCH_COMMAND ${CMAKE_COMMAND} -E copy "${Package_Dir}/Patch/lib/CMakeLists.txt" <SOURCE_DIR>/lib/CMakeLists.txt
#BUILD_IN_SOURCE 0
#INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
#CMAKE_COMMAND ${CMAKE_COMMAND}
#CMAKE_ARGS 
#-DCURL_STATICLIB:BOOL=${CURL_STATICLIB}
#-DCMAKE_DEBUG_POSTFIX:STRING=D
#-DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
#-DCMAKE_PREFIX_PATH:PATH=<INSTALL_DIR>
#)
#