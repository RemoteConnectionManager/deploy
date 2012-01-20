# - Find curl
# Find the native CURL headers and libraries.
#
#  CURL_INCLUDE_DIRS - where to find curl/curl.h, etc.
#  CURL_LIBRARIES    - List of libraries when using curl.
#  CURL_FOUND        - True if curl found.

# Look for the header file.
FIND_PATH(
  CURL_INCLUDE_DIR 
  NAMES curl/curl.h curl/curlbuild.h
  ${Package_search_hints}
)
MARK_AS_ADVANCED(CURL_INCLUDE_DIR)

# Look for the library.

SET(CURL_NAMES curl libcurl)
foreach(_l ${CURL_NAMES})
	list(APPEND CURL_SEARCH_DEBUG_NAMES "${_l}${CMAKE_DEBUG_POSTFIX}")
endforeach()


FIND_LIBRARY(
  CURL_LIBRARY_DEBUG 
  NAMES ${CURL_SEARCH_DEBUG_NAMES} 
  ${Package_search_hints}
)
message("CURL_LIBRARY_DEBUG-->${CURL_LIBRARY_DEBUG}<--searched-->${CURL_SEARCH_DEBUG_NAMES}<--")
FIND_LIBRARY(
  CURL_LIBRARY_RELEASE 
  NAMES ${CURL_NAMES} 
  ${Package_search_hints}
)


#####################################################################################
  IF(NOT TARGET Libraries::Curl)
    ADD_LIBRARY(Libraries::Curl UNKNOWN IMPORTED )

    IF (CURL_LIBRARY_RELEASE)
      SET_PROPERTY(TARGET Libraries::Curl  APPEND PROPERTY
                   IMPORTED_CONFIGURATIONS RELEASE)
       SET_PROPERTY(TARGET Libraries::Curl  PROPERTY
               IMPORTED_LOCATION_RELEASE "${CURL_LIBRARY_RELEASE}" )
    ENDIF (CURL_LIBRARY_RELEASE)

    IF (CURL_LIBRARY_DEBUG)
      SET_PROPERTY(TARGET Libraries::Curl  APPEND PROPERTY
                   IMPORTED_CONFIGURATIONS DEBUG)
       SET_PROPERTY(TARGET Libraries::Curl  PROPERTY
               IMPORTED_LOCATION_DEBUG "${CURL_LIBRARY_DEBUG}" )
    ENDIF (CURL_LIBRARY_DEBUG)
  ENDIF(NOT TARGET Libraries::Curl)

  SET(CURL_LIBRARY     Libraries::Curl )
  SET(CURL_LIBRARIES   Libraries::Curl )

##############################################################################

#old#select_library_configurations(CURL)

MARK_AS_ADVANCED(CURL_INCLUDE_DIR CURL_LIBRARY CURL_LIBRARY_DEBUG)

# handle the QUIETLY and REQUIRED arguments and set CURL_FOUND to TRUE if 
# all listed variables are TRUE
INCLUDE(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(CURL DEFAULT_MSG CURL_LIBRARY CURL_INCLUDE_DIR)

IF(CURL_FOUND)
  SET(CURL_LIBRARIES ${CURL_LIBRARY})
  SET(CURL_INCLUDE_DIRS ${CURL_INCLUDE_DIR})
ELSE(CURL_FOUND)
  SET(CURL_LIBRARIES)
  SET(CURL_INCLUDE_DIRS)
ENDIF(CURL_FOUND)
