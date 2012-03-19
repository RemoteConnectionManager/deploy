SET(Unzip_FOUND FALSE)
debug_message("DEBUGDEBUGDEBUG    called FindUnzip parent->${CMAKE_PARENT_LIST_FILE} current->${CMAKE_CURRENT_LIST_FILE}<-")
FIND_PROGRAM(
	Unzip_EXECUTABLE 
	unzip
	DOC "unzip exe"
	${Package_search_hints}
)
MARK_AS_ADVANCED(Unzip_EXECUTABLE)
 
IF(Unzip_EXECUTABLE)
  SET(Unzip_FOUND TRUE)
ENDIF(Unzip_EXECUTABLE)
 
# handle the QUIETLY and REQUIRED arguments and set Unzip_FOUND to TRUE if 
# all listed variables are TRUE
INCLUDE(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(Unzip DEFAULT_MSG Unzip_EXECUTABLE)
 
 
