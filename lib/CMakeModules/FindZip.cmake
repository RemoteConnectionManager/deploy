SET(zip_FOUND FALSE)
 
FIND_PROGRAM(zip_EXECUTABLE zip
  DOC "zip exe")
MARK_AS_ADVANCED(zip_EXECUTABLE)
 
IF(zip_EXECUTABLE)
  SET(zip_FOUND TRUE)
ENDIF(zip_EXECUTABLE)
 
# handle the QUIETLY and REQUIRED arguments and set ZLIB_FOUND to TRUE if 
# all listed variables are TRUE
INCLUDE(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(zip DEFAULT_MSG zip_EXECUTABLE)
 
 
