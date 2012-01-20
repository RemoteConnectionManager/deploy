if(WIN32)
  set(Package_current_dependencies EXPAT)
else()
  set(Package_current_dependencies EXPAT PkgConfig)
endif()

