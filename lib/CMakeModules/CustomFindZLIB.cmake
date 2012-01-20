# - Find zlib
# Find the native ZLIB headers and libraries.

message("-------CUSTOM FindZLIB------ with hints-->${Package_search_hints}<--")
#This find look also for debug library
#old#INCLUDE(SelectLibraryConfigurations)

#
#  ZLIB_INCLUDE_DIRS - where to find zlib.h, etc.
#  ZLIB_LIBRARIES    - List of libraries when using zlib.
#  ZLIB_LIBRARY_DEBUG - Debug version of Library
#  ZLIB_LIBRARY_RELEASE - Release Version of Library
#  ZLIB_FOUND        - True if zlib found.


####################################################################################################
IF (ZLIB_INCLUDE_DIR)
  # Already in cache, be silent
  SET(ZLIB_FIND_QUIETLY TRUE)
ENDIF (ZLIB_INCLUDE_DIR)

FIND_PATH(
	ZLIB_INCLUDE_DIR zlib.h
	${Package_search_hints}
)

SET(ZLIB_NAMES z zlib zdll)
foreach(_l ${ZLIB_NAMES})
	list(APPEND ZLIB_SEARCH_DEBUG_NAMES "${_l}${CMAKE_DEBUG_POSTFIX}")
endforeach()

FIND_LIBRARY(
	ZLIB_LIBRARY_DEBUG NAMES ${ZLIB_SEARCH_DEBUG_NAMES} 
	${Package_search_hints}
)
message("ZLIB_LIBRARY_DEBUG-->${ZLIB_LIBRARY_DEBUG}<--searched-->${ZLIB_SEARCH_DEBUG_NAMES}<--")
FIND_LIBRARY(
	ZLIB_LIBRARY_RELEASE NAMES ${ZLIB_NAMES} 
	${Package_search_hints}
)
message("ZLIB_LIBRARY_RELEASE-->${ZLIB_LIBRARY_RELEASE}<--searched-->${ZLIB_NAMES}<--")




#####################################################################################
  IF(NOT TARGET Libraries::Zlib)
    ADD_LIBRARY(Libraries::Zlib UNKNOWN IMPORTED )

    IF (ZLIB_LIBRARY_RELEASE)
      SET_PROPERTY(TARGET Libraries::Zlib  APPEND PROPERTY
                   IMPORTED_CONFIGURATIONS RELEASE)
       SET_PROPERTY(TARGET Libraries::Zlib  PROPERTY
               IMPORTED_LOCATION_RELEASE "${ZLIB_LIBRARY_RELEASE}" )
    ENDIF (ZLIB_LIBRARY_RELEASE)

    IF (ZLIB_LIBRARY_DEBUG)
      SET_PROPERTY(TARGET Libraries::Zlib  APPEND PROPERTY
                   IMPORTED_CONFIGURATIONS DEBUG)
       SET_PROPERTY(TARGET Libraries::Zlib  PROPERTY
               IMPORTED_LOCATION_DEBUG "${ZLIB_LIBRARY_DEBUG}" )
    ENDIF (ZLIB_LIBRARY_DEBUG)
  ENDIF(NOT TARGET Libraries::Zlib)

  SET(ZLIB_LIBRARY     Libraries::Zlib )
  SET(ZLIB_LIBRARIES   Libraries::Zlib )

##############################################################################

#old#select_library_configurations(ZLIB)

#old#MARK_AS_ADVANCED(ZLIB_INCLUDE_DIR ZLIB_LIBRARY ZLIB_LIBRARY_DEBUG)

# Per-recommendation
SET(ZLIB_INCLUDE_DIRS "${ZLIB_INCLUDE_DIR}")
SET(ZLIB_LIBRARIES    "${ZLIB_LIBRARY}")

# handle the QUIETLY and REQUIRED arguments and set ZLIB_FOUND to TRUE if 
# all listed variables are TRUE
INCLUDE(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(ZLIB DEFAULT_MSG ZLIB_LIBRARIES ZLIB_INCLUDE_DIRS)

#####################################################################################################



## Look for the header file.
#
## MESSAGE (STATUS "Finding zlib library and headers..." )
#SET (ZLIB_DEBUG 0)
#
#SET(ZLIB_INCLUDE_SEARCH_DIRS
#  $ENV{ZLIB_INSTALL}/include
#)
#
#SET (ZLIB_LIB_SEARCH_DIRS
#  $ENV{ZLIB_INSTALL}/lib
#  )
#
#SET (ZLIB_BIN_SEARCH_DIRS
#  $ENV{ZLIB_INSTALL}/bin
#)
#
#FIND_PATH(ZLIB_INCLUDE_DIR
#  NAMES zlib.h
#  PATHS ${ZLIB_INCLUDE_SEARCH_DIRS}
#  NO_DEFAULT_PATH
#)
#
#IF (WIN32 AND NOT MINGW)
#    SET (ZLIB_SEARCH_DEBUG_NAMES "zlibdll_D;libzlib_D")
#    SET (ZLIB_SEARCH_RELEASE_NAMES "zlibdll;libzlib")
#ELSE (WIN32 AND NOT MINGW)
#    SET (ZLIB_SEARCH_DEBUG_NAMES "zlib_debug")
#    SET (ZLIB_SEARCH_RELEASE_NAMES "zlib")
#ENDIF(WIN32 AND NOT MINGW)
#
#
#IF (ZLIB_DEBUG)
#message (STATUS "ZLIB_INCLUDE_SEARCH_DIRS: ${ZLIB_INCLUDE_SEARCH_DIRS}")
#message (STATUS "ZLIB_LIB_SEARCH_DIRS: ${ZLIB_LIB_SEARCH_DIRS}")
#message (STATUS "ZLIB_BIN_SEARCH_DIRS: ${ZLIB_BIN_SEARCH_DIRS}")
#message (STATUS "ZLIB_SEARCH_RELEASE_NAMES: ${ZLIB_SEARCH_RELEASE_NAMES}")
#message (STATUS "ZLIB_SEARCH_DEBUG_NAMES: ${ZLIB_SEARCH_DEBUG_NAMES}")
#ENDIF (ZLIB_DEBUG)
#
## Look for the library.
#FIND_LIBRARY(ZLIB_LIBRARY_DEBUG
#  NAMES ${ZLIB_SEARCH_DEBUG_NAMES}
#  PATHS ${ZLIB_LIB_SEARCH_DIRS}
#  NO_DEFAULT_PATH
#  )
#
#FIND_LIBRARY(ZLIB_LIBRARY_RELEASE
#  NAMES ${ZLIB_SEARCH_RELEASE_NAMES}
#  PATHS ${ZLIB_LIB_SEARCH_DIRS}
#  NO_DEFAULT_PATH
#  )
#
#SET (ZLIB_XMLWF_PROG_NAME "xmlwf")
#IF (WIN32)
#    SET (ZLIB_XMLWF_PROG_NAME "xmlwf.exe")
#ENDIF(WIN32)
#
#FIND_PROGRAM(ZLIB_XMLWF_PROG
#    NAMES ${ZLIB_XMLWF_PROG_NAME}
#    PATHS ${ZLIB_BIN_SEARCH_DIRS}
#    NO_DEFAULT_PATH
#)
#MARK_AS_ADVANCED(ZLIB_XMLWF_PROG)
#
#IF (ZLIB_DEBUG)
#MESSAGE(STATUS "ZLIB_INCLUDE_DIR: ${ZLIB_INCLUDE_DIR}")
#MESSAGE(STATUS "ZLIB_LIBRARY_DEBUG: ${ZLIB_LIBRARY_DEBUG}")
#MESSAGE(STATUS "ZLIB_LIBRARY_RELEASE: ${ZLIB_LIBRARY_RELEASE}")
#MESSAGE(STATUS "CMAKE_BUILD_TYPE: ${CMAKE_BUILD_TYPE}")
#endif(ZLIB_DEBUG)
#
#ADJUST_LIB_VARS(ZLIB)
#
## MESSAGE( STATUS "ZLIB_LIBRARY: ${ZLIB_LIBRARY}")
#
## Copy the results to the output variables.
#IF(ZLIB_INCLUDE_DIR AND ZLIB_LIBRARY)
#  SET(ZLIB_FOUND 1)
#  SET(ZLIB_LIBRARIES ${ZLIB_LIBRARY})
#  SET(ZLIB_INCLUDE_DIRS ${ZLIB_INCLUDE_DIR})
#  IF (ZLIB_LIBRARY_DEBUG)
#    GET_FILENAME_COMPONENT(ZLIB_LIBRARY_PATH ${ZLIB_LIBRARY_DEBUG} PATH)
#    SET(ZLIB_LIB_DIR  ${ZLIB_LIBRARY_PATH})
#  ELSEIF(ZLIB_LIBRARY_RELEASE)
#    GET_FILENAME_COMPONENT(ZLIB_LIBRARY_PATH ${ZLIB_LIBRARY_RELEASE} PATH)
#    SET(ZLIB_LIB_DIR  ${ZLIB_LIBRARY_PATH})
#  ENDIF(ZLIB_LIBRARY_DEBUG)
#
#  IF (ZLIB_XMLWF_PROG)
#    GET_FILENAME_COMPONENT(ZLIB_BIN_PATH ${ZLIB_XMLWF_PROG} PATH)
#    SET(ZLIB_BIN_DIR  ${ZLIB_BIN_PATH})
#  ENDIF (ZLIB_XMLWF_PROG)
#
#ELSE(ZLIB_INCLUDE_DIR AND ZLIB_LIBRARY)
#  SET(ZLIB_FOUND 0)
#  SET(ZLIB_LIBRARIES)
#  SET(ZLIB_INCLUDE_DIRS)
#ENDIF(ZLIB_INCLUDE_DIR AND ZLIB_LIBRARY)
#
## Report the results.
#IF(NOT ZLIB_FOUND)
#  SET(ZLIB_DIR_MESSAGE
#    "ZLIB was not found. Make sure ZLIB_LIBRARY and
#ZLIB_INCLUDE_DIR are set or set the ZLIB_INSTALL environment
#variable.")
#  IF(NOT ZLIB_FIND_QUIETLY)
#    MESSAGE(STATUS "${ZLIB_DIR_MESSAGE}")
#  ELSE(NOT ZLIB_FIND_QUIETLY)
#    IF(ZLIB_FIND_REQUIRED)
#      # MESSAGE(FATAL_ERROR "${ZLIB_DIR_MESSAGE}")
#      MESSAGE(FATAL_ERROR "Expat was NOT found and is Required by this project")
#    ENDIF(ZLIB_FIND_REQUIRED)
#  ENDIF(NOT ZLIB_FIND_QUIETLY)
#ENDIF(NOT ZLIB_FOUND)
#
#
#IF (ZLIB_FOUND)
#  INCLUDE(CheckSymbolExists)
#  #############################################
#  # Find out if ZLIB was build using dll's
#  #############################################
#  # Save required variable
#  SET(CMAKE_REQUIRED_INCLUDES_SAVE ${CMAKE_REQUIRED_INCLUDES})
#  SET(CMAKE_REQUIRED_FLAGS_SAVE    ${CMAKE_REQUIRED_FLAGS})
#  # Add ZLIB_INCLUDE_DIR to CMAKE_REQUIRED_INCLUDES
#  SET(CMAKE_REQUIRED_INCLUDES
#"${CMAKE_REQUIRED_INCLUDES};${ZLIB_INCLUDE_DIRS}")
#
#  CHECK_SYMBOL_EXISTS(ZLIB_BUILT_AS_DYNAMIC_LIB "zlib_config.h"
#HAVE_ZLIB_DLL)
#
#    IF (HAVE_ZLIB_DLL STREQUAL "TRUE")
#        SET (HAVE_ZLIB_DLL "1")
#    ENDIF (HAVE_ZLIB_DLL STREQUAL "TRUE")
#
#  # Restore CMAKE_REQUIRED_INCLUDES and CMAKE_REQUIRED_FLAGS variables
#  SET(CMAKE_REQUIRED_INCLUDES ${CMAKE_REQUIRED_INCLUDES_SAVE})
#  SET(CMAKE_REQUIRED_FLAGS    ${CMAKE_REQUIRED_FLAGS_SAVE})
#  #
#  #############################################