message("-------CUSTOM FindZip------ with hints-->${Package_search_hints}<--")
SET(Zip_FOUND FALSE)
 
FIND_PROGRAM(
	zip_EXECUTABLE zip
	DOC "zip exe"
	${Package_search_hints}
#always prefer system installed tools (no linux package yet)	${Package_search_hints}
)
MARK_AS_ADVANCED(zip_EXECUTABLE)
 
IF(zip_EXECUTABLE)
  SET(Zip_FOUND TRUE)
ENDIF(zip_EXECUTABLE)
 
# handle the QUIETLY and REQUIRED arguments and set ZLIB_FOUND to TRUE if 
# all listed variables are TRUE
INCLUDE(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(Zip DEFAULT_MSG zip_EXECUTABLE)
 
 
