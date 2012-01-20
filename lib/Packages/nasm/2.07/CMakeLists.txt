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
	PackageSetup()

	if(WIN32)
		#### here we download the binary package,  sic
		PackageWindowsBinarySimpleAdd( http://www.nasm.us/pub/nasm/releasebuilds/2.07/win32/nasm-2.07-win32.zip )
	else()
		message("Still to implement patch building under linux")
	endif()
endif()


