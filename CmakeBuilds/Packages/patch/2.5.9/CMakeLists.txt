#from http://www.gnu.org/software/patch/patch.html
#this seems better http://directory.fsf.org/project/patch/
#latest source http://ftp.gnu.org/gnu/patch/patch-2.6.1.tar.bz2
#this imports variables here
PackageSetup()

FIND_PROGRAM(Patch_EXECUTABLE patch
  DOC "patch executable"
  ${Package_search_hints}
)

if(Patch_EXECUTABLE)
	message("found patch, skipping external")
else()
	message("patch NOT FOUND, inserting external")
	if(WIN32)
		#### here we download the binary package, ase md5deep does not currently support building under windows..... sic
		
		ExternalProject_Add(
			${PACKAGE}
			#WARNING!!!! this way  zip file directly expand into install/bin dir == source dir
			DOWNLOAD_DIR ${EXTERNAL_ASSEMBLY_BASE_SOURCE}/${PACKAGE}/${VERSION}/win32_bin_download
			SOURCE_DIR ${EXTERNAL_ASSEMBLY_COMMON_PREFIX}
			#MD5 b9c8b31d62f4b2e4f1887bbb63e8a905
			URL http://switch.dl.sourceforge.net/project/gnuwin32/patch/2.5.9-7/patch-2.5.9-7-bin.zip
			INSTALL_COMMAND ""
			CONFIGURE_COMMAND ""
			BUILD_COMMAND ""
		)
		#### add install step here (copy????)
	else()
		message("Still to implement patch building under linux")
	endif()
endif()


