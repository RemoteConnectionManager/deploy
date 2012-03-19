SET(Bzip2_FOUND FALSE)
message("DEBUGDEBUGDEBUG    called FindBzip2 parent->${CMAKE_PARENT_LIST_FILE} current->${CMAKE_CURRENT_LIST_FILE}<-")

if(WIN32)
	FIND_PROGRAM(
		Bunzip2_EXECUTABLE 
		bunzip2
		DOC "bunzip2 exe"
	# this is forced to exclude system bunzip2 as this package provide a dll that is required by bzip
		NO_SYSTEM_ENVIRONMENT_PATH
	#	${Package_search_hints}
	)
else()
	FIND_PROGRAM(
		  Bunzip2_EXECUTABLE 
		  bunzip2
		  DOC "bunzip2 exe"
	  # this is forced to exclude system bunzip2 as this package provide a dll that is required by bzip
	  #	${Package_search_hints}
	  )
endif()

MARK_AS_ADVANCED(Bunzip2_EXECUTABLE)
 
IF(Bunzip2_EXECUTABLE)
  SET(Bzip2_FOUND TRUE)
ENDIF(Bunzip2_EXECUTABLE)
 
# handle the QUIETLY and REQUIRED arguments and set Bzip2_FOUND to TRUE if 
# all listed variables are TRUE
INCLUDE(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(Bzip2 DEFAULT_MSG Bunzip2_EXECUTABLE)
 
 
