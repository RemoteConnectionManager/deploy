#from http://gnuwin32.sourceforge.net/packages/unzip.htm
#this imports variables here
PackageSetup()

FIND_PROGRAM(Zip_EXECUTABLE zip
  DOC "zip executable"
)

if(Zip_EXECUTABLE)
	message("found zip, skipping external ")
	add_custom_target(${PACKAGE})
else()
	message("unzip NOT FOUND, inserting external")
	if(WIN32)
		#### here we download the binary package, ase md5deep does not currently support building under windows..... sic
		
		ExternalProject_Add(
			${PACKAGE}
			#WARNING!!!! this way  zip file directly expand into install/bin dir == source dir
			DOWNLOAD_DIR ${EXTERNAL_ASSEMBLY_BASE_SOURCE}/${PACKAGE}/${VERSION}/win32_bin_download
			SOURCE_DIR ${EXTERNAL_ASSEMBLY_COMMON_PREFIX}
			#MD5 5b268fe06ce5f89bc5762805a7a9d7aa
			URL http://switch.dl.sourceforge.net/project/gnuwin32/zip/3.0/zip-3.0-bin.zip
			DEPENDS bzip2
			INSTALL_COMMAND ""
			CONFIGURE_COMMAND ""
			BUILD_COMMAND ""
		)
		#### add install step here (copy????)
	else()
		message("Still to implement zip building under linux")
	endif()
endif()


