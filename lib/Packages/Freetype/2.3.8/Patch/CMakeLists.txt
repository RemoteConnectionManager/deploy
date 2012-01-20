project(Freetype C)

set(FREETYPE2_MAJOR_VERSION 2)
set(FREETYPE2_MINOR_VERSION 3)
set(FREETYPE2_PATCH_VERSION 8)

set(FREETYPE2_LIB_NAME ${CMAKEPORTS_NAME_PREFIX}freetype${FREETYPE2_MAJOR_VERSION}${FREETYPE2_MINOR_VERSION}${FREETYPE2_PATCH_VERSION})

if(MSVC)
    set(CMAKE_DEBUG_POSTFIX "D")
    add_definitions(-D_CRT_SECURE_NO_DEPRECATE)
endif()


# Must have. Enables the #include <MACRO> build system
add_definitions(-DFT2_BUILD_LIBRARY)

# Provide a way to enable ERROR debug level
option(FREETYPE2_DEBUG_LEVEL_ERROR "Get error messages" OFF)
if(FREETYPE2_DEBUG_LEVEL_ERROR)
    add_definitions(-DFT_DEBUG_LEVEL_ERROR)
endif()
# Provide a way to enable the TRACE debug level
option(FREETYPE2_DEBUG_LEVEL_TRACE "Get error and trace messages" OFF)
if(FREETYPE2_DEBUG_LEVEL_TRACE)
    add_definitions(-DFT_DEBUG_LEVEL_TRACE)
endif()

# Make headers visible to everything
include_directories(include)

# now add the source
add_subdirectory(src)


if(NOT SKIP_INSTALL_HEADERS AND NOT SKIP_INSTALL_ALL )
    install(DIRECTORY include/ DESTINATION include/freetype2 PATTERN "internal" EXCLUDE)
endif()
