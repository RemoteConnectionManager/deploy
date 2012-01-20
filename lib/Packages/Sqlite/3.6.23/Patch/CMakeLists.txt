#from http://www.mail-archive.com/sqlite-users@sqlite.org/msg38681.html

cmake_minimum_required ( VERSION 2.6 FATAL_ERROR )

project ( sqlite3 C )


set ( SOURCES sqlite3.c )
set ( HEADERS sqlite3.h )

if ( WIN32 )
  if ( MSVC )
#    set ( CMAKE_SHARED_LINKER_FLAGS /DEF:sqlite3.def )
#    set ( SQLITE3_DEF_FILE "${CMAKE_CURRENT_BINARY_DIR}/sqlite3.def" )
     add_definitions( "-DSQLITE_API=__declspec(dllexport)" )
  endif ( MSVC )
endif ( WIN32 )

add_library ( sqlite3 SHARED
  ${SOURCES}
  ${HEADERS}
)

INSTALL ( TARGETS sqlite3
  RUNTIME DESTINATION bin
  LIBRARY DESTINATION lib
  ARCHIVE DESTINATION lib
)

INSTALL ( FILES sqlite3.h DESTINATION include )

