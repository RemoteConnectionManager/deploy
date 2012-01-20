#from 		http://www.bzip.org/
#this imports variables here
PackageSetup()

FIND_PROGRAM(Bunzip_EXECUTABLE bunzip2 bunzip
  DOC "bunzip executable"
  ${Package_search_hints}
)

if(Bunzip_EXECUTABLE)
	message("found bunzip, skipping external")
else()
	message("bunzip NOT FOUND, inserting external")
	if(WIN32)
		#### here we download the binary package, as bzip2 does not currently support building under windows..... sic
		
		ExternalProject_Add(
			${PACKAGE}
			#WARNING!!!! this way  zip file directly expand into install/bin dir == source dir
			DOWNLOAD_DIR ${EXTERNAL_ASSEMBLY_BASE_SOURCE}/${PACKAGE}/${VERSION}/win32_bin_download
			SOURCE_DIR ${EXTERNAL_ASSEMBLY_COMMON_PREFIX}
			#MD5 a1155c41b1954a2f6da1014c7c1a1263
			URL http://switch.dl.sourceforge.net/project/gnuwin32/bzip2/1.0.5/bzip2-1.0.5-bin.zip
			INSTALL_COMMAND ""
			CONFIGURE_COMMAND ""
			BUILD_COMMAND ""
		)
		#### add install step here (copy????)
	else()
		message("Still to implement ${PACKAGE} building under linux")
	endif()
endif()



#ExternalProject_Add(
#	${PACKAGE}
#	${Package_std_dirs}
#	URL http://www.bzip.org/1.0.5/bzip2-1.0.5.tar.gz
#	PATCH_COMMAND ${CMAKE_COMMAND} -E copy "${Package_Dir}/Patch/CMakeLists.txt" <SOURCE_DIR>/CMakeLists.txt
#	DEPENDS zlib
#	CMAKE_COMMAND ${CMAKE_COMMAND}
#	CMAKE_ARGS 
#		${Package_std_cmake_args}
#)
#