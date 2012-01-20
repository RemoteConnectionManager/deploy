#this imports variables here
PackageSetup()


ExternalProject_Add(
	${PACKAGE}
	${Package_std_dirs}
	URL http://www.bzip.org/1.0.5/bzip2-1.0.5.tar.gz
	PATCH_COMMAND ${CMAKE_COMMAND} -E copy "${Package_Dir}/Patch/CMakeLists.txt" <SOURCE_DIR>/CMakeLists.txt
	DEPENDS zlib
	CMAKE_COMMAND ${CMAKE_COMMAND}
	CMAKE_ARGS 
		${Package_std_cmake_args}
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