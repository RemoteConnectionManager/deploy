#from http://www.nasm.us/
#netwide assembler
#seem needed by open ssl
#this imports variables here
PackageSetup()

FIND_PROGRAM(Nasm_EXECUTABLE nasm
  DOC "nasm assembler executable"
  ${Package_search_hints}
)

if(Nasm_EXECUTABLE)
	message("found nasm, skipping external")
else()
	message("nasm NOT FOUND, inserting external")
	if(WIN32)
		#### here we download the binary package,  sic
		
		ExternalProject_Add(
			${PACKAGE}
			#WARNING!!!! this way  zip file directly expand into install/bin dir == source dir
			DOWNLOAD_DIR ${EXTERNAL_ASSEMBLY_BASE_SOURCE}/${PACKAGE}/${VERSION}/win32_bin_download
			SOURCE_DIR ${EXTERNAL_ASSEMBLY_COMMON_PREFIX}
			URL http://www.nasm.us/pub/nasm/releasebuilds/2.07/win32/nasm-2.07-win32.zip
			INSTALL_COMMAND ""
			CONFIGURE_COMMAND ""
			BUILD_COMMAND ""
		)
		#### add install step here (copy????)
	else()
		message("Still to implement patch building under linux")
	endif()
endif()


