SET(Bazaar_FOUND FALSE)
 
FIND_PROGRAM(Bazaar_EXECUTABLE bzr
  DOC "Bazaar command line client")
MARK_AS_ADVANCED(Bazaar_EXECUTABLE)
 
IF(Bazaar_EXECUTABLE)
  SET(Bazaar_FOUND TRUE)
#  MACRO(Bazaar_WC_INFO dir prefix)
#    EXECUTE_PROCESS(COMMAND ${Bazaar_EXECUTABLE} rev-list -n 1 HEAD
#       WORKING_DIRECTORY ${dir}
#        ERROR_VARIABLE Bazaar_error
#       OUTPUT_VARIABLE ${prefix}_WC_REVISION_HASH
#        OUTPUT_STRIP_TRAILING_WHITESPACE)
#    if(NOT ${Bazaar_error} EQUAL 0)
#      MESSAGE(SEND_ERROR "Command \"${Bazaar_EXECUTBALE} rev-list -n 1 HEAD\" in directory ${dir} failed with output:\n${Bazaar_error}")
#    ELSE(NOT ${Bazaar_error} EQUAL 0)
#      EXECUTE_PROCESS(COMMAND ${Bazaar_EXECUTABLE} name-rev ${${prefix}_WC_REVISION_HASH}
#         WORKING_DIRECTORY ${dir}
#         OUTPUT_VARIABLE ${prefix}_WC_REVISION_NAME
#          OUTPUT_STRIP_TRAILING_WHITESPACE)
#    ENDIF(NOT ${Bazaar_error} EQUAL 0)
#  ENDMACRO(Bazaar_WC_INFO)
ENDIF(Bazaar_EXECUTABLE)
 
IF(NOT Bazaar_FOUND)
  IF(NOT Bazaar_FIND_QUIETLY)
    MESSAGE(STATUS "Bazaar was not found")
  ELSE(NOT Bazaar_FIND_QUIETLY)
    if(Bazaar_FIND_REQUIRED)
      MESSAGE(FATAL_ERROR "Bazaar was not found")
    ENDIF(Bazaar_FIND_REQUIRED)
  ENDIF(NOT Bazaar_FIND_QUIETLY)
ENDIF(NOT Bazaar_FOUND)
 
