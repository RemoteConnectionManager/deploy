SET(Patch_FOUND FALSE)
message("DEBUG    called FindPatch parent->${CMAKE_PARENT_LIST_FILE} current->${CMAKE_CURRENT_LIST_FILE}<-")
FIND_PROGRAM(
	Patch_EXECUTABLE 
	patch
	DOC "Patch exe"
	${Package_search_hints}
)
MARK_AS_ADVANCED(Patch_EXECUTABLE)
 
IF(Patch_EXECUTABLE)
  SET(Patch_FOUND TRUE)
ENDIF(Patch_EXECUTABLE)
 
# handle the QUIETLY and REQUIRED arguments and set Patch_FOUND to TRUE if 
# all listed variables are TRUE
INCLUDE(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(Patch DEFAULT_MSG Patch_EXECUTABLE)
 
 
