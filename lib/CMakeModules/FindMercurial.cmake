SET(Mercurial_FOUND FALSE)
 
FIND_PROGRAM(
	Mercurial_EXECUTABLE hg
	DOC "Mercurial command line client"
	#always prefer system path ${Package_search_hints}
)
MARK_AS_ADVANCED(Mercurial_EXECUTABLE)
 
IF(Mercurial_EXECUTABLE)
  SET(Mercurial_FOUND TRUE)
#  MACRO(Mercurial_WC_INFO dir prefix)
#    EXECUTE_PROCESS(COMMAND ${Mercurial_EXECUTABLE} rev-list -n 1 HEAD
#       WORKING_DIRECTORY ${dir}
#        ERROR_VARIABLE Mercurial_error
#       OUTPUT_VARIABLE ${prefix}_WC_REVISION_HASH
#        OUTPUT_STRIP_TRAILING_WHITESPACE)
#    if(NOT ${Mercurial_error} EQUAL 0)
#      MESSAGE(SEND_ERROR "Command \"${Mercurial_EXECUTBALE} rev-list -n 1 HEAD\" in directory ${dir} failed with output:\n${Mercurial_error}")
#    ELSE(NOT ${Mercurial_error} EQUAL 0)
#      EXECUTE_PROCESS(COMMAND ${Mercurial_EXECUTABLE} name-rev ${${prefix}_WC_REVISION_HASH}
#         WORKING_DIRECTORY ${dir}
#         OUTPUT_VARIABLE ${prefix}_WC_REVISION_NAME
#          OUTPUT_STRIP_TRAILING_WHITESPACE)
#    ENDIF(NOT ${Mercurial_error} EQUAL 0)
#  ENDMACRO(Mercurial_WC_INFO)
ENDIF(Mercurial_EXECUTABLE)
 
IF(NOT Mercurial_FOUND)
  IF(NOT Mercurial_FIND_QUIETLY)
    MESSAGE(STATUS "Mercurial was not found")
  ELSE(NOT Mercurial_FIND_QUIETLY)
    if(Mercurial_FIND_REQUIRED)
      MESSAGE(FATAL_ERROR "Mercurial was not found")
    ENDIF(Mercurial_FIND_REQUIRED)
  ENDIF(NOT Mercurial_FIND_QUIETLY)
ENDIF(NOT Mercurial_FOUND)
 
