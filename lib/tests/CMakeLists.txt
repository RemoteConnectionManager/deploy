# For other curl specific tests, use this macro.
macro(CURL_INTERNAL_TEST CURL_TEST)
  if("${CURL_TEST}" MATCHES "^${CURL_TEST}$")
    set(MACRO_CHECK_FUNCTION_DEFINITIONS 
      "-D${CURL_TEST} ${CURL_TEST_DEFINES} ${CMAKE_REQUIRED_FLAGS}")
    if(CMAKE_REQUIRED_LIBRARIES)
      set(CURL_TEST_ADD_LIBRARIES
        "-DLINK_LIBRARIES:STRING=${CMAKE_REQUIRED_LIBRARIES}")
    endif(CMAKE_REQUIRED_LIBRARIES)

    message(STATUS "Performing Curl Test ${CURL_TEST}")
    try_compile(${CURL_TEST}
      ${CMAKE_BINARY_DIR}
      ${CMAKE_CURRENT_SOURCE_DIR}/CMake/CurlTests.c
      CMAKE_FLAGS -DCOMPILE_DEFINITIONS:STRING=${MACRO_CHECK_FUNCTION_DEFINITIONS}
      "${CURL_TEST_ADD_LIBRARIES}"
      OUTPUT_VARIABLE OUTPUT)
    if(${CURL_TEST})
      set(${CURL_TEST} 1 CACHE INTERNAL "Curl test ${FUNCTION}")
      message(STATUS "Performing Curl Test ${CURL_TEST} - Success")
      file(APPEND ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/CMakeOutput.log 
        "Performing Curl Test ${CURL_TEST} passed with the following output:\n"
        "${OUTPUT}\n")
    else(${CURL_TEST})
      message(STATUS "Performing Curl Test ${CURL_TEST} - Failed")
      set(${CURL_TEST} "" CACHE INTERNAL "Curl test ${FUNCTION}")
      file(APPEND ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/CMakeError.log 
        "Performing Curl Test ${CURL_TEST} failed with the following output:\n"
        "${OUTPUT}\n")
    endif(${CURL_TEST})
  endif("${CURL_TEST}" MATCHES "^${CURL_TEST}$")
endmacro(CURL_INTERNAL_TEST) 

macro(CURL_INTERNAL_TEST_RUN CURL_TEST)
  if("${CURL_TEST}_COMPILE" MATCHES "^${CURL_TEST}_COMPILE$")
    set(MACRO_CHECK_FUNCTION_DEFINITIONS 
      "-D${CURL_TEST} ${CMAKE_REQUIRED_FLAGS}")
    if(CMAKE_REQUIRED_LIBRARIES)
      set(CURL_TEST_ADD_LIBRARIES
        "-DLINK_LIBRARIES:STRING=${CMAKE_REQUIRED_LIBRARIES}")
    endif(CMAKE_REQUIRED_LIBRARIES)

    message(STATUS "Performing Curl Test ${CURL_TEST}")
    try_run(${CURL_TEST} ${CURL_TEST}_COMPILE
      ${CMAKE_BINARY_DIR}
      ${CMAKE_CURRENT_SOURCE_DIR}/CMake/CurlTests.c
      CMAKE_FLAGS -DCOMPILE_DEFINITIONS:STRING=${MACRO_CHECK_FUNCTION_DEFINITIONS}
      "${CURL_TEST_ADD_LIBRARIES}"
      OUTPUT_VARIABLE OUTPUT)
    if(${CURL_TEST}_COMPILE AND NOT ${CURL_TEST})
      set(${CURL_TEST} 1 CACHE INTERNAL "Curl test ${FUNCTION}")
      message(STATUS "Performing Curl Test ${CURL_TEST} - Success")
    else(${CURL_TEST}_COMPILE AND NOT ${CURL_TEST})
      message(STATUS "Performing Curl Test ${CURL_TEST} - Failed")
      set(${CURL_TEST} "" CACHE INTERNAL "Curl test ${FUNCTION}")
      file(APPEND "${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/CMakeError.log"
        "Performing Curl Test ${CURL_TEST} failed with the following output:\n"
        "${OUTPUT}")
      if(${CURL_TEST}_COMPILE)
        file(APPEND 
          "${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/CMakeError.log" 
          "There was a problem running this test\n")
      endif(${CURL_TEST}_COMPILE)
      file(APPEND "${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/CMakeError.log" 
        "\n\n")
    endif(${CURL_TEST}_COMPILE AND NOT ${CURL_TEST})
  endif("${CURL_TEST}_COMPILE" MATCHES "^${CURL_TEST}_COMPILE$")
endmacro(CURL_INTERNAL_TEST_RUN) 


foreach(CURL_TEST 
    HAVE_SOCKLEN_T
  curl_internal_test(${CURL_TEST})
  message("test for ${CURL_TEST} resulted in -->${${CURL_TEST}}<--")
endforeach(CURL_TEST)

if(HAVE_SOCKLEN_T)
  set(CURL_TYPEOF_CURL_SOCKLEN_T "socklen_t")
  check_type_size("socklen_t" CURL_SIZEOF_CURL_SOCKLEN_T)
else()
  set(CURL_TYPEOF_CURL_SOCKLEN_T int)
  set(CURL_SIZEOF_CURL_SOCKLEN_T ${SIZEOF_INT})
endif()
