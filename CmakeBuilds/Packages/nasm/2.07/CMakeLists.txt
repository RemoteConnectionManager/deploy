#from http://www.nasm.us/
#netwide assembler
#seem needed by open ssl
#this imports variables here
PackageSetup()


if(WIN32)
	#### here we download the binary package,  sic
	PackageWindowsBinarySimpleAdd( http://www.nasm.us/pub/nasm/releasebuilds/2.07/win32/nasm-2.07-win32.zip )
else()
	set(Package_source_setup
		URL http://garr.dl.sourceforge.net/project/nasm/nasm%20sources/2.07/nasm-2.07.tar.gz
		URL_MD5 84d8e009b3d2565a810ab3ddad1f4f63
		#PATCH_COMMAND ${CMAKE_COMMAND} -P ${Package_Source_Stamp_Dir}/patch.cmake
	)
	set(Package_InSource ON)	
	PackageUnixConfigureAdd()
endif()



