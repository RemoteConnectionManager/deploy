SET(Bzip2_FOUND FALSE)
message("DEBUGDEBUGDEBUG    called FindBzip2 parent->${CMAKE_PARENT_LIST_FILE} current->${CMAKE_CURRENT_LIST_FILE}<-")
FIND_PROGRAM(
	Bzip2_EXECUTABLE 
	bunzip2
	DOC "bunzip2 exe"
# this is forced to exclude system bunzip as this is required by bzip to be
	NO_SYSTEM_ENVIRONMENT_PATH
#	${Package_search_hints}
)
MARK_AS_ADVANCED(Bzip2_EXECUTABLE)
 
IF(Bzip2_EXECUTABLE)
  SET(Bzip2_FOUND TRUE)
ENDIF(Bzip2_EXECUTABLE)
 
# handle the QUIETLY and REQUIRED arguments and set Bzip2_FOUND to TRUE if 
# all listed variables are TRUE
INCLUDE(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(Bzip2 DEFAULT_MSG Bzip2_EXECUTABLE)
 
 
